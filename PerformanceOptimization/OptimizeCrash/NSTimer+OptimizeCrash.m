//
// Created by 马洪亮 on 2021/1/15.
//

#import "NSTimer+OptimizeCrash.h"

@interface NSTimerMiddleware : NSObject
@property(nonatomic, weak) id target;
@property(nonatomic,assign) SEL selector;
@property(nonatomic, assign) id userInfo;
@property(nonatomic, weak)NSTimer *timer;
@property(nonatomic, readwrite, assign) NSTimeInterval ti;
@end

@implementation NSTimerMiddleware

- (void)transferMethod {

    @try {
        if ([self.target respondsToSelector:self.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.target performSelector:self.selector];
#pragma clang diagnostic pop
        }
    }
    @catch (NSException *exception) {
        [self.timer invalidate];
        self.timer = nil;
        [OptimizeCrash errorWithException:exception];
    }
    @finally {}
}


@end


@implementation NSTimer (OptimizeCrash)

+ (void)optimizeCrashCategoryMethod {

    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        [OptimizeCrash exchangeMethod:[self class] oldMethodSel:@selector(scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:) newMethodSel:@selector(mhl_scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:) methodType:ClassMethod];

    });
}

#pragma mark ============方法=========
/**
 * scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:
 */
+ (NSTimer *)mhl_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)repeats{
    //过滤延迟性质的定时器
    if (!repeats){
        return [self mhl_scheduledTimerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:repeats];
    }
    NSTimerMiddleware *timerMiddleware = [NSTimerMiddleware new];
    timerMiddleware.selector = aSelector;
    timerMiddleware.target = aTarget;
    timerMiddleware.ti = ti;
    timerMiddleware.userInfo = userInfo;
    NSTimer *timer = [NSTimer mhl_scheduledTimerWithTimeInterval:ti target:timerMiddleware selector:@selector(transferMethod) userInfo:userInfo repeats:repeats];
    timerMiddleware.timer = timer;
    return timer;
}

@end
