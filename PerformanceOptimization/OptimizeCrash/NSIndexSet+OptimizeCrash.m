//
//  NSIndexSet+OptimizeCrash.m
//  MHLPO
//
//  Created by 马洪亮 on 2021/1/14.
//

#import "NSIndexSet+OptimizeCrash.h"

@implementation NSIndexSet (OptimizeCrash)

+ (void)optimizeCrashCategoryMethod {

    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        //initWithIndex:
        [OptimizeCrash exchangeMethod:NSClassFromString(NSIndexSetKey) oldMethodSel:@selector(initWithIndex:) newMethodSel:@selector(mhl_initWithIndex:) methodType:InstanceMethod];

    });

}

#pragma mark  ================方法=======================

/**
 * initWithIndex:
 */
- (instancetype)mhl_initWithIndex:(NSUInteger)value {

    id instance = nil;
    @try {
        instance = [self mhl_initWithIndex:value];
    } @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
        instance = [self mhl_initWithIndex:0];

    } @finally {
        return instance;
    }
}

@end
