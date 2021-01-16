//
//  DetectionCaton.m
//  MHLPO
//
//  Created by 马洪亮 on 2021/1/15.
//

#import "DetectionCaton.h"

@interface DetectionCaton ()

@property (nonatomic, assign) int timeOut;
@property (nonatomic, assign) BOOL isMonitoring;
@property (nonatomic, assign) CFRunLoopObserverRef observer;
@property (nonatomic, assign) CFRunLoopActivity currentActivity;
@property (nonatomic, strong) dispatch_semaphore_t semphore;
@property (nonatomic, strong) dispatch_semaphore_t eventSemphore;

@end

#define MHL_SEMPHORE_SUCCESS 0
static NSTimeInterval mhlRestoreInterval = 5;
static NSTimeInterval mhlTimeOutInterval = 1;
static int64_t mhlWaitInterval = 200 * NSEC_PER_MSEC;


/*
 *  监听runloop状态为before waiting状态下是否卡顿
 */
static inline dispatch_queue_t mhl_event_monitor_queue() {
    static dispatch_queue_t mhl_event_monitor_queue;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        mhl_event_monitor_queue = dispatch_queue_create("mhl_event_monitor_queue", NULL);
    });
    return mhl_event_monitor_queue;
}

/*
 * 监听runloop状态在after waiting和before sources之间
 */
static inline dispatch_queue_t mhl_fluecy_monitor_queue() {
    static dispatch_queue_t mhl_fluecy_monitor_queue;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        mhl_fluecy_monitor_queue = dispatch_queue_create("mhl_monitor_queue", NULL);
    });
    return mhl_fluecy_monitor_queue;
}

#define LOG_RUNLOOP_ACTIVITY 0
static void mhlRunLoopObserverCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void * info) {
    SHARED.currentActivity = activity;
    dispatch_semaphore_signal(SHARED.semphore);
#if LOG_RUNLOOP_ACTIVITY
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"runloop entry");
            break;
            
        case kCFRunLoopExit:
            NSLog(@"runloop exit");
            break;
            
        case kCFRunLoopAfterWaiting:
            NSLog(@"runloop after waiting");
            break;
            
        case kCFRunLoopBeforeTimers:
            NSLog(@"runloop before timers");
            break;
            
        case kCFRunLoopBeforeSources:
            NSLog(@"runloop before sources");
            break;
            
        case kCFRunLoopBeforeWaiting:
            NSLog(@"runloop before waiting");
            break;
            
        default:
            break;
    }
#endif
};


@implementation DetectionCaton


+ (instancetype)shared{
    static DetectionCaton * shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[super allocWithZone:NSDefaultMallocZone()] init];
        [shared commonInit];
    });
    
    return shared;
}

+ (instancetype)allocWithZone: (struct _NSZone *)zone {
    return [self shared];
}


- (void)commonInit{
    self.semphore = dispatch_semaphore_create(0);
    self.eventSemphore = dispatch_semaphore_create(0);
}


- (void)dealloc {
    [self stop];
}

- (void)start {
    if (_isMonitoring) { return; }
    _isMonitoring = YES;
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)self,
        NULL,
        NULL
    };
    _observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &mhlRunLoopObserverCallback, &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    
    dispatch_async(mhl_event_monitor_queue(), ^{
        while (SHARED.isMonitoring) {
            if (SHARED.currentActivity == kCFRunLoopBeforeWaiting) {
                __block BOOL timeOut = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                    timeOut = NO;
                    dispatch_semaphore_signal(SHARED.eventSemphore);
                });
                [NSThread sleepForTimeInterval: mhlTimeOutInterval];
                if (timeOut) {
                    [Backtrace mhl_logMain];
                }
                dispatch_wait(SHARED.eventSemphore, DISPATCH_TIME_FOREVER);
            }
        }
    });
    
    dispatch_async(mhl_fluecy_monitor_queue(), ^{
        while (SHARED.isMonitoring) {
            long waitTime = dispatch_semaphore_wait(self.semphore, dispatch_time(DISPATCH_TIME_NOW, mhlWaitInterval));
            if (waitTime != MHL_SEMPHORE_SUCCESS) {
                if (!SHARED.observer) {
                    SHARED.timeOut = 0;
                    [SHARED stop];
                    continue;
                }
                if (SHARED.currentActivity == kCFRunLoopBeforeSources || SHARED.currentActivity == kCFRunLoopAfterWaiting) {
                    if (++SHARED.timeOut < 5) {
                        continue;
                    }
                    [Backtrace mhl_logMain];
                    [NSThread sleepForTimeInterval: mhlRestoreInterval];
                }
            }
            SHARED.timeOut = 0;
        }
    });
}

- (void)stop {
    if (!_isMonitoring) { return; }
    _isMonitoring = NO;
    
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    CFRelease(_observer);
    _observer = nil;
}

@end
