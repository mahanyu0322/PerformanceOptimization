//
// Created by 马洪亮 on 2021/1/15.
//

#import <Foundation/Foundation.h>
#import "OptimizeCrashProtocol.h"
#import "OptimizeCrash.h"
//#import "NSTimerMiddleware.h"
@interface NSTimer (OptimizeCrash)<OptimizeCrashProtocol>
@end
