//
//  DetectionCaton.h
//  MHLPO
//
//  Created by 马洪亮 on 2021/1/15.
//

#import <Foundation/Foundation.h>
#import "Backtrace.h"
#define SHARED [DetectionCaton shared]

NS_ASSUME_NONNULL_BEGIN

@interface DetectionCaton : NSObject

+ (instancetype)shared;

-(void)start;

-(void)stop;

@end

NS_ASSUME_NONNULL_END
