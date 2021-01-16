//
//  NSData+OptimizeCrash.m
//  MHLPO
//
//  Created by 马洪亮 on 2021/1/14.
//

#import "NSData+OptimizeCrash.h"

@implementation NSData (OptimizeCrash)

+ (void)optimizeCrashCategoryMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //initWithLength
        [OptimizeCrash exchangeMethod:NSClassFromString(NSConcreteMutableDataKey) oldMethodSel:@selector(initWithLength:) newMethodSel:@selector(mhl_initWithLength:) methodType:InstanceMethod];
        //replaceBytesInRange:withBytes:length:
        [OptimizeCrash exchangeMethod:NSClassFromString(NSConcreteMutableDataKey) oldMethodSel:@selector(replaceBytesInRange:withBytes:length:) newMethodSel:@selector(mhl_replaceBytesInRange:withBytes:length:) methodType:InstanceMethod];
    });
}

#pragma mark  ================方法=======================

/**
 * initWithLength
 * @param length length
 * @return instancetype
 */
- (nullable instancetype)mhl_initWithLength:(NSUInteger)length {

    id instance = nil;

    @try {
        instance = [self mhl_initWithLength:length];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
        instance = [self mhl_initWithLength:0];
    }
    @finally {
        return instance;
    }
}

/**
 * replaceBytesInRange:withBytes:length:
 * @param range range
 * @param replacementBytes replacementBytes
 * @param replacementLength replacementLength
 */
- (void)mhl_replaceBytesInRange:(NSRange)range withBytes:(nullable const void *)replacementBytes length:(NSUInteger)replacementLength {
    @try {
        [self mhl_replaceBytesInRange:range withBytes:replacementBytes length:replacementLength];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {}
}

@end
