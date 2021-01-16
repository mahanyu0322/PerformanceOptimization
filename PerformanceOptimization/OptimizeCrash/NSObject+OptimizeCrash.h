//
//  NSObject+OptimizeCrash.h
//  MHLPO
//
//  Created by 马洪亮 on 2021/1/14.
//

#import <Foundation/Foundation.h>
#import "OptimizeCrashProtocol.h"
#import "OptimizeCrash.h"
#import "MethodsForwarding.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (OptimizeCrash)<OptimizeCrashProtocol>

@end

NS_ASSUME_NONNULL_END
