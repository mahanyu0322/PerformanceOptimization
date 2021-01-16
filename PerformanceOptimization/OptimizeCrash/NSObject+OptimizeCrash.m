//
//  NSObject+OptimizeCrash.m
//  MHLPO
//
//  Created by 马洪亮 on 2021/1/14.
//

#import "NSObject+OptimizeCrash.h"

@implementation NSObject (OptimizeCrash)


+ (void)optimizeCrashCategoryMethod {

    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        //KVC
        //setValue:forKey:
        [OptimizeCrash exchangeMethod:[self class] oldMethodSel:@selector(setValue:forKey:) newMethodSel:@selector(mhl_setValue:forKey:) methodType:InstanceMethod];
        //setValue:forKeyPath:
        [OptimizeCrash exchangeMethod:[self class] oldMethodSel:@selector(setValue:forKeyPath:) newMethodSel:@selector(mhl_setValue:forKeyPath:) methodType:InstanceMethod];
        //setValue:forUndefinedKey:
        [OptimizeCrash exchangeMethod:[self class] oldMethodSel:@selector(setValue:forUndefinedKey:) newMethodSel:@selector(mhl_setValue:forUndefinedKey:) methodType:InstanceMethod];
        //setValuesForKeysWithDictionary:
        [OptimizeCrash exchangeMethod:[self class] oldMethodSel:@selector(setValuesForKeysWithDictionary:) newMethodSel:@selector(mhl_setValuesForKeysWithDictionary:) methodType:InstanceMethod];

        //unrecognized selector sent to instance
        [OptimizeCrash exchangeMethod:[self class] oldMethodSel:@selector(methodSignatureForSelector:) newMethodSel:@selector(mhl_methodSignatureForSelector:) methodType:InstanceMethod];
        [OptimizeCrash exchangeMethod:[self class] oldMethodSel:@selector(forwardInvocation:) newMethodSel:@selector(mhl_forwardInvocation:) methodType:InstanceMethod];
    });
}


#pragma mark  ================方法=======================

/**
 * methodSignatureForSelector:
 */
- (NSMethodSignature *)mhl_methodSignatureForSelector:(SEL)aSelector {

    NSMethodSignature *ms = [self mhl_methodSignatureForSelector:aSelector];

    BOOL flag = NO;
    if (ms == nil) {
        ms = [MethodsForwarding instanceMethodSignatureForSelector:@selector(forwardingMethod)];
        flag = YES;
    }
    if (flag == NO) {
        ms = [MethodsForwarding instanceMethodSignatureForSelector:@selector(forwardingMethod)];
    }
    return ms;
}

/**
 * forwardInvocation:
 */
- (void)mhl_forwardInvocation:(NSInvocation *)anInvocation {
    @try {
        [self mhl_forwardInvocation:anInvocation];
    } @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    } @finally {}
}

/**
 * setValue:forKey:
 */
- (void)mhl_setValue:(id)value forKey:(NSString *)key {
    @try {
        [self mhl_setValue:value forKey:key];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {}
}

/**
 * setValue:forKeyPath:
 */
- (void)mhl_setValue:(id)value forKeyPath:(NSString *)keyPath {
    @try {
        [self mhl_setValue:value forKeyPath:keyPath];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {}
}

/**
 * setValue:forUndefinedKey:
 */
- (void)mhl_setValue:(id)value forUndefinedKey:(NSString *)key {
    @try {
        [self mhl_setValue:value forUndefinedKey:key];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {}
}

/**
 * setValuesForKeysWithDictionary:
 */
- (void)mhl_setValuesForKeysWithDictionary:(NSDictionary<NSString *, id> *)keyedValues {
    @try {
        [self mhl_setValuesForKeysWithDictionary:keyedValues];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {}
}

@end
