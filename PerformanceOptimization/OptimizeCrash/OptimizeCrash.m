//
//  OptimizeCrash.m
//  MHLPO
//
//  Created by 马洪亮 on 2021/1/14.
//

#import "OptimizeCrash.h"

@implementation OptimizeCrashResult


@end

@implementation OptimizeCrash


static CrashResultBlock block_;

static BOOL isPrintLogs_;
static BOOL isListeningMethod_;

/**
 * 开启crash优化
 */
+ (void)startOptimizeCrashIsPrintLogs:(BOOL)isPrintLogs isListeningMethod:(BOOL)isListeningMethod Block:(CrashResultBlock)block {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        isPrintLogs_ = isPrintLogs;
        isListeningMethod_ = isListeningMethod;
        if (isListeningMethod) {
            [NSObject optimizeCrashCategoryMethod];
        }
        [NSArray optimizeCrashCategoryMethod];
        [NSDictionary optimizeCrashCategoryMethod];
//        [NSString optimizeCrashCategoryMethod];
        [NSAttributedString optimizeCrashCategoryMethod];
        [NSData optimizeCrashCategoryMethod];
        [NSSet optimizeCrashCategoryMethod];
        [NSIndexSet optimizeCrashCategoryMethod];
        [UIView optimizeCrashCategoryMethod];
        //补漏处理,当方法交换的异常无法捕捉时,用runloop快速切换模式拦截异常,尽量用上面方法捕获异常,因为runloop快速切换模式会进入while循环,只输出一次
        [ExceptionHandler installUncaughtExceptionHandler];
        block_ = block;
        NSLog(@"");
//        NSLog(@"%@",objc_getClass(&block_));

    });
}

/**
 * 交换方法
 * @param cls 当前类
 * @param oldMethodSel 原来的方法
 * @param newMethodSel 新方法
 * @param methodType 方法类型:ClassMethod 类方法 InstanceMethod 对象方法
 */
+ (void)exchangeMethod:(Class)cls oldMethodSel:(SEL)oldMethodSel newMethodSel:(SEL)newMethodSel methodType:(MethodType)methodType {

    //类方法
    if (methodType == ClassMethod) {
        Method oldMethod = class_getClassMethod(cls, oldMethodSel);
        Method newMethod = class_getClassMethod(cls, newMethodSel);
        method_exchangeImplementations(oldMethod, newMethod);
    }
        //对象方法
    else if (methodType == InstanceMethod) {
        Method oldMethod = class_getInstanceMethod(cls, oldMethodSel);
        Method newMethod = class_getInstanceMethod(cls, newMethodSel);
        NSString *oldMethodSelString = NSStringFromSelector(oldMethodSel);
        //字典删除数据时不需要添加方法
        if ([oldMethodSelString isEqualToString:@"removeObjectForKey:"]) {
            method_exchangeImplementations(oldMethod, newMethod);
        } else {
            BOOL addMethod =
                    class_addMethod(cls,
                            oldMethodSel,
                            method_getImplementation(newMethod),
                            method_getTypeEncoding(newMethod));
            if (addMethod) {
                class_replaceMethod(cls,
                        newMethodSel,
                        method_getImplementation(oldMethod),
                        method_getTypeEncoding(oldMethod));
            } else {
                method_exchangeImplementations(oldMethod, newMethod);
            }
        }
    }

}

/**
 * 异常处理
 * @param exception 异常
 */
+ (void)errorWithException:(NSException *)exception {
    //堆栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
   
    NSString *mainCallStackSymbolMsg = [[self class] getMainCallStackSymbolMessageWithCallStackSymbols:callStackSymbolsArr];
    if (mainCallStackSymbolMsg == nil) {

        mainCallStackSymbolMsg = @"崩溃方法定位失败,请您查看函数调用栈来排查错误原因";
//        if (isPrintLogs_) {
        NSLog(@"函数调用栈------%@", callStackSymbolsArr);
//        }
    }

    NSString *errorName = exception.name;
    NSString *errorReason = exception.reason;
    //errorReason 可能为 -[__NSCFConstantString avoidCrashCharacterAtIndex:]: Range or index out of bounds
    
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"mhl_nsarrayikey_" withString:@""];
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"mhl_NSSingleObjectArrayIKey_" withString:@""];
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"mhl_NSArray0Key_" withString:@""];
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"mhl_NSArrayKey_" withString:@""];
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"mhl_NSSingleObjectArrayIKeyM_" withString:@""];
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"mhl_NSArrayIKey_" withString:@""];
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"mhl_M_" withString:@""];

    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"mhl_" withString:@""];

    
    
    
    
    NSString *errorPlace = mainCallStackSymbolMsg;
    NSString *separatorWithFlag = @"========================AvoidCrash Log==========================";
    NSString *logErrorMessage = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n%@", separatorWithFlag, errorName, errorReason, errorPlace];

    NSString *separator = @"============================================================";

    logErrorMessage = [NSString stringWithFormat:@"%@\n\n%@\n\n", logErrorMessage, separator];


    if (isPrintLogs_) {
        NSLog(@"%@", logErrorMessage);
    }

    OptimizeCrashResult *optimizeCrashResult = [[OptimizeCrashResult alloc] init];
    optimizeCrashResult.errorName = errorName;
    optimizeCrashResult.errorReason = errorReason;
    optimizeCrashResult.errorPlace = errorPlace;
    optimizeCrashResult.exception = exception;
    optimizeCrashResult.callStackSymbols = callStackSymbolsArr;
    
    block_(optimizeCrashResult);

}

+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbols:(NSArray<NSString *> *)callStackSymbols {

    //mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;

    //匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";

    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];

    for (int index = 2; index < callStackSymbols.count; index++) {
        NSString *callStackSymbol = callStackSymbols[index];

        [regularExp enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult *_Nullable result, NSMatchingFlags flags, BOOL *_Nonnull stop) {
            if (result) {
                NSString *tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];

                //get className
                NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                className = [className componentsSeparatedByString:@"["].lastObject;

                NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];

                //filter category and system class
                if (![className hasSuffix:@")"] && bundle == [NSBundle mainBundle]) {
                    mainCallStackSymbolMsg = tempCallStackSymbolMsg;

                }
                *stop = YES;
            }
        }];

        if (mainCallStackSymbolMsg.length) {
            break;
        }
    }

    return mainCallStackSymbolMsg;
}

@end
