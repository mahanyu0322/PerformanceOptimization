//
//  NSArray+OptimizeCrash.m
//  MHLPO
//
//  Created by 马洪亮 on 2021/1/14.
//

#import "NSArray+OptimizeCrash.h"


@implementation NSArray (OptimizeCrash)

+ (void)optimizeCrashCategoryMethod {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //=================NSArray================
        [self nsarrayMethod];
        //=================NSMutableArray================
        [self nsmutableArrayMethod];
    });

}

#pragma mark - =================NSMutableArray 类================

+ (void)nsmutableArrayMethod {

    //objectAtIndex:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSArrayMKey) oldMethodSel:@selector(objectAtIndex:) newMethodSel:@selector(mhl_objectAtIndex:) methodType:InstanceMethod];
    //objectAtIndexedSubscript
    if (OptimizeCrashIsiOS(11.0)) {
        [OptimizeCrash exchangeMethod:NSClassFromString(__NSArrayMKey) oldMethodSel:@selector(objectAtIndexedSubscript:) newMethodSel:@selector(mhl_objectAtIndexedSubscript:) methodType:InstanceMethod];
    }
    //setObject:atIndexedSubscript:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSArrayMKey) oldMethodSel:@selector(setObject:atIndexedSubscript:) newMethodSel:@selector(mhl_setObject:atIndexedSubscript:) methodType:InstanceMethod];
    //removeObjectAtIndex:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSArrayMKey) oldMethodSel:@selector(removeObjectAtIndex:) newMethodSel:@selector(mhl_removeObjectAtIndex:) methodType:InstanceMethod];
    //insertObject:atIndex:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSArrayMKey) oldMethodSel:@selector(insertObject:atIndex:) newMethodSel:@selector(mhl_insertObject:atIndex:) methodType:InstanceMethod];
    //getObjects:range:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSArrayMKey) oldMethodSel:@selector(getObjects:range:) newMethodSel:@selector(mhl_getObjects:range:) methodType:InstanceMethod];

}

#pragma mark  - =================NSArray 类================

+ (void)nsarrayMethod {

    //类
    //arrayWithObjects:count:
    [OptimizeCrash exchangeMethod:[self class] oldMethodSel:@selector(arrayWithObjects:count:) newMethodSel:@selector(mhl_arrayWithObjects:count:) methodType:ClassMethod];
    //对象方法
    //objectsAtIndexes
    [OptimizeCrash exchangeMethod:NSClassFromString(NSArrayKey) oldMethodSel:@selector(objectsAtIndexes:) newMethodSel:@selector(mhl_objectsAtIndexes:) methodType:InstanceMethod];
    //__NSArrayI  objectAtIndex:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSArrayIKey) oldMethodSel:@selector(objectAtIndex:) newMethodSel:@selector(mhl_nsarrayikey_objectAtIndex:) methodType:InstanceMethod];
    //__NSSingleObjectArrayI  objectAtIndex:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSSingleObjectArrayIKey) oldMethodSel:@selector(objectAtIndex:) newMethodSel:@selector(mhl_NSSingleObjectArrayIKey_objectAtIndex:) methodType:InstanceMethod];
    //__NSArray0  objectAtIndex:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSArray0Key) oldMethodSel:@selector(objectAtIndex:) newMethodSel:@selector(mhl_NSArray0Key_objectAtIndex:) methodType:InstanceMethod];
    //objectAtIndexedSubscript::
    if (OptimizeCrashIsiOS(11.0)) {
        [OptimizeCrash exchangeMethod:NSClassFromString(__NSArrayIKey) oldMethodSel:@selector(objectAtIndexedSubscript:) newMethodSel:@selector(mhl_nsarrayikey_objectAtIndexedSubscript:) methodType:InstanceMethod];
    }
    //NSArray  getObjects:range:
    [OptimizeCrash exchangeMethod:NSClassFromString(NSArrayKey) oldMethodSel:@selector(getObjects:range:) newMethodSel:@selector(mhl_NSArrayKey_getObjects:range:) methodType:InstanceMethod];
    //__NSSingleObjectArrayI  getObjects:range:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSSingleObjectArrayIKey) oldMethodSel:@selector(getObjects:range:) newMethodSel:@selector(mhl_NSSingleObjectArrayIKeyM_getObjects:range:) methodType:InstanceMethod];
    //__NSArrayI  getObjects:range:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSArrayIKey) oldMethodSel:@selector(getObjects:range:) newMethodSel:@selector(mhl_NSArrayIKey_getObjects:range:) methodType:InstanceMethod];

}


#pragma mark ============NSArray 方法========================

/**
 * arrayWithObjects:count:
 */
+ (instancetype)mhl_arrayWithObjects:(const id _Nonnull[_Nonnull])objects count:(NSUInteger)cnt {

    id instance = nil;
    @try {
        instance = [self mhl_arrayWithObjects:objects count:cnt];
    } @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
        int newIndex = 0;
        id _Nonnull __unsafe_unretained newObjects[cnt];
        for (int i = 0; i < cnt; i++) {
            if (objects[i]) {
                newObjects[newIndex++] = objects[i];
            }
        }
        instance = [self mhl_arrayWithObjects:newObjects count:newIndex];
    } @finally {
        return instance;
    }

}

/**
 * objectsAtIndexes:
 */
- (NSArray *)mhl_objectsAtIndexes:(NSIndexSet *)indexes {

    NSArray *returnArray = nil;
    @try {
        returnArray = [self mhl_objectsAtIndexes:indexes];
    } @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    } @finally {
        return returnArray;
    }
}

/**
 * __NSArrayI objectAtIndex:
 */
- (id)mhl_nsarrayikey_objectAtIndex:(NSUInteger)index {

    id object = nil;
    @try {
        object = [self mhl_nsarrayikey_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {
        return object;
    }
}

/**
 * __NSSingleObjectArray objectAtIndex:
 */
- (id)mhl_NSSingleObjectArrayIKey_objectAtIndex:(NSUInteger)index {

    id object = nil;
    @try {
        object = [self mhl_NSSingleObjectArrayIKey_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {
        return object;
    }

}


/**
 * __NSArray0 objectAtIndex:
 */
- (id)mhl_NSArray0Key_objectAtIndex:(NSUInteger)index {

    id object = nil;
    @try {
        object = [self mhl_NSArray0Key_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {
        return object;
    }

}

/**
 * __NSArrayI objectAtIndexedSubscript:
 */
- (id)mhl_nsarrayikey_objectAtIndexedSubscript:(NSUInteger)index {

    id object = nil;
    @try {
        object = [self mhl_nsarrayikey_objectAtIndexedSubscript:index];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {
        return object;
    }

}

/**
 * NSArrayKey getObjects:range:
 */
- (void)mhl_NSArrayKey_getObjects:(const id _Nonnull[_Nonnull])objects range:(NSRange)range {

    @try {
        [self mhl_NSArrayKey_getObjects:objects range:range];
    } @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    } @finally {}
}

/**
 * __NSSingleObjectArrayI getObjects:range:
 */
- (void)mhl_NSSingleObjectArrayIKeyM_getObjects:(const id _Nonnull[_Nonnull])objects range:(NSRange)range {

    @try {
        [self mhl_NSSingleObjectArrayIKeyM_getObjects:objects range:range];
    } @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    } @finally {}
}

/**
 * __NSArrayI getObjects:range:
 */
- (void)mhl_NSArrayIKey_getObjects:(const id _Nonnull[_Nonnull])objects range:(NSRange)range {

    @try {
        [self mhl_NSArrayIKey_getObjects:objects range:range];
    } @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    } @finally {}

}

#pragma mark =========================NSMutableArray 方法============

/**
 * setObject:atIndexedSubscript:
 */
- (void)mhl_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {

    @try {
        [self mhl_setObject:obj atIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {}

}

/**
 * removeObjectAtIndex:
 */
- (void)mhl_removeObjectAtIndex:(NSUInteger)index {

    @try {
        [self mhl_removeObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {}

}

/**
 * insertObject:atIndex:
 */
- (void)mhl_insertObject:(id)anObject atIndex:(NSUInteger)index {

    @try {
        [self mhl_insertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {}

}

/**
 * objectAtIndex:
 */
- (id)mhl_objectAtIndex:(NSUInteger)index {

    id object = nil;
    @try {
        object = [self mhl_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {
        return object;
    }
}

/**
 * objectAtIndexedSubscript:
 */
- (id)mhl_objectAtIndexedSubscript:(NSUInteger)idx {

    id object = nil;
    @try {
        object = [self mhl_objectAtIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {
        return object;
    }
}

/**
 * getObjects:range:
 */
- (void)mhl_getObjects:(__unsafe_unretained id _Nonnull *)objects range:(NSRange)range {

    @try {
        [self mhl_getObjects:objects range:range];
    } @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    } @finally {}
}

@end
