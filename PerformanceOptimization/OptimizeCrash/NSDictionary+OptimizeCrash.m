//
//  NSDictionary+OptimizeCrash.m
//  MHLPO
//
//  Created by 马洪亮 on 2021/1/14.
//

#import "NSDictionary+OptimizeCrash.h"

@implementation NSDictionary (OptimizeCrash)

+ (void)optimizeCrashCategoryMethod {

    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{

        //=================NSDictionary================
        //类方法
        //dictionaryWithObjects
        [OptimizeCrash exchangeMethod:[self class] oldMethodSel:@selector(dictionaryWithObjects:forKeys:count:) newMethodSel:@selector(mhl_dictionaryWithObjects:forKeys:count:) methodType:ClassMethod];

        //对象方法
        //setObject
        [OptimizeCrash exchangeMethod:NSClassFromString(__NSDictionaryMKey) oldMethodSel:@selector(setObject:forKey:) newMethodSel:@selector(mhl_setObject:forKey:) methodType:InstanceMethod];

        //setObject:forKeyedSubscript:
        if (OptimizeCrashIsiOS(11.0)) {
            [OptimizeCrash exchangeMethod:NSClassFromString(__NSDictionaryMKey) oldMethodSel:@selector(setObject:forKeyedSubscript:) newMethodSel:@selector(mhl_setObject:forKeyedSubscript:) methodType:InstanceMethod];
        }

        //removeObjectForKey
        [OptimizeCrash exchangeMethod:NSClassFromString(__NSDictionaryMKey) oldMethodSel:@selector(removeObjectForKey:) newMethodSel:@selector(mhl_removeObjectForKey:) methodType:InstanceMethod];
    });
}

#pragma mark  ================方法=======================

/**
 * dictionaryWithObjects:forKeys:count:
 */
+ (instancetype)mhl_dictionaryWithObjects:(const id _Nonnull __unsafe_unretained *)objects forKeys:(const id <NSCopying> _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {

    id instance = nil;

    @try {
        instance = [self mhl_dictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
        //处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id _Nonnull __unsafe_unretained newObjects[cnt];
        id _Nonnull __unsafe_unretained newkeys[cnt];
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index++] = keys[i];
            }
        }
        instance = [self mhl_dictionaryWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}

/**
 * setObject:forKey:
 */
- (void)mhl_setObject:(id)anObject forKey:(id <NSCopying>)aKey {

    @try {
        [self mhl_setObject:anObject forKey:aKey];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {}
}

/**
 * setObject:forKeyedSubscript:
 */
- (void)mhl_setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key {
    @try {
        [self mhl_setObject:obj forKeyedSubscript:key];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {}
}

/**
 * removeObjectForKey:
 */
#pragma mark - removeObjectForKey:

- (void)mhl_removeObjectForKey:(id)aKey {

    @try {
        [self mhl_removeObjectForKey:aKey];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {}
}

@end
