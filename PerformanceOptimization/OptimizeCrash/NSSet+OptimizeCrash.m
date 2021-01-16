//
//  NSSet+OptimizeCrash.m
//  MHLPO
//
//  Created by 马洪亮 on 2021/1/14.
//

#import "NSSet+OptimizeCrash.h"

#define NSMutableSetRemovesNil @"NSMutableSet remove element is nil"
#define NSMutableSetAddNil @"NSMutableSet add element is nil"
#define NSMutableSetCount @"The number of NSMutableSet elements cannot be less than 0"


@implementation NSSet (OptimizeCrash)

+ (void)optimizeCrashCategoryMethod {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        //====================NSSet==========
        [OptimizeCrash exchangeMethod:NSClassFromString(__NSSetIKey) oldMethodSel:@selector(initWithObjects:) newMethodSel:@selector(mhl_initWithObjects:) methodType:InstanceMethod];
      
        //============NSMutableSet==========
        [OptimizeCrash exchangeMethod:NSClassFromString(__NSPlaceholderSetKey) oldMethodSel:@selector(initWithCapacity:) newMethodSel:@selector(mhl_initWithCapacity:) methodType:InstanceMethod];
        //addObject
        [OptimizeCrash exchangeMethod:NSClassFromString(__NSSetMKey) oldMethodSel:@selector(addObject:) newMethodSel:@selector(mhl_addObject:) methodType:InstanceMethod];
        
        //removeObject
        [OptimizeCrash exchangeMethod:NSClassFromString(__NSSetMKey) oldMethodSel:@selector(removeObject:) newMethodSel:@selector(mhl_removeObject:) methodType:InstanceMethod];
        
    });
    
}

#pragma mark  ================方法=======================
/**
 * initWithObjects:
 */
- (instancetype)mhl_initWithObjects:(const id _Nonnull [_Nonnull])objects{
    id instance = nil;
    @try {
        instance = [self mhl_initWithObjects:objects];
    } @catch (NSException *exception) {
    } @finally {
        return  instance;
    }
}

/**
 * initWithCapacity:
 */
- (instancetype)mhl_initWithCapacity:(NSUInteger)numItems{
    
    id instance = nil;
    @try {
        instance = [self mhl_initWithCapacity:numItems];
    } @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
        instance = [self mhl_initWithCapacity:0];
        
    } @finally {
        return instance;
    }
}

/**
 * addObject:
 */
- (void)mhl_addObject:(const id _Nonnull [_Nonnull])object{
    @try {
        [self mhl_addObject:object];
    } @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    } @finally {}
}

/**
 * removeObject:
 */
- (void)mhl_removeObject:(const id _Nonnull [_Nonnull])object{
    
    @try {
        [self mhl_removeObject:object];
    } @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    } @finally {}
}

@end
