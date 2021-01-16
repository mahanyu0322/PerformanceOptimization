//
//  ExceptionHandler.h
//  MHLPO
//
//  Created by 马洪亮 on 2021/1/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OptimizeCrash.h"
NS_ASSUME_NONNULL_BEGIN

@interface ExceptionHandler : NSObject
+(void)installUncaughtExceptionHandler;
@end

NS_ASSUME_NONNULL_END
