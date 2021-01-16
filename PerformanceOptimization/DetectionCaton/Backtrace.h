//
//  Backtrace.h
//  MHLPO
//
//  Created by 马洪亮 on 2021/1/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Backtrace : NSObject
+ (NSString *)mhl_backtraceOfAllThread;
+ (NSString *)mhl_backtraceOfMainThread;
+ (NSString *)mhl_backtraceOfCurrentThread;
+ (NSString *)mhl_backtraceOfNSThread:(NSThread *)thread;

+ (void)mhl_logMain;
+ (void)mhl_logCurrent;
+ (void)mhl_logAllThread;
@end

NS_ASSUME_NONNULL_END
