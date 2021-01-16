//
//  NSAttributedString+OptimizeCrash.m
//  MHLPO
//
//  Created by 马洪亮 on 2021/1/14.
//

#import "NSAttributedString+OptimizeCrash.h"

@implementation NSAttributedString (OptimizeCrash)

+ (void)optimizeCrashCategoryMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //=================NSAttributedString================
        [self nsattributedString];
        //====================NSMutableAttributedString===================
        [self nsmutableAttributedString];
    });
}

#pragma mark - =================NSMutableAttributedString 类================

+ (void)nsmutableAttributedString {
    //initWithString:
    [OptimizeCrash exchangeMethod:NSClassFromString(NSConcreteMutableAttributedStringKey) oldMethodSel:@selector(initWithString:) newMethodSel:@selector(mhl_M_initWithString:) methodType:InstanceMethod];
    //initWithString:attributes:
    [OptimizeCrash exchangeMethod:NSClassFromString(NSConcreteMutableAttributedStringKey) oldMethodSel:@selector(initWithString:attributes:) newMethodSel:@selector(mhl_M_initWithString:attributes:) methodType:InstanceMethod];
}

#pragma mark - =================NSAttributedString 类================

+ (void)nsattributedString {
    //initWithString:
    [OptimizeCrash exchangeMethod:NSClassFromString(NSConcreteAttributedStringKey) oldMethodSel:@selector(initWithString:) newMethodSel:@selector(mhl_initWithString:) methodType:InstanceMethod];
    //initWithAttributedString
    [OptimizeCrash exchangeMethod:NSClassFromString(NSConcreteAttributedStringKey) oldMethodSel:@selector(initWithAttributedString:) newMethodSel:@selector(mhl_initWithAttributedString:) methodType:InstanceMethod];
    //initWithString:attributes:
    [OptimizeCrash exchangeMethod:NSClassFromString(NSConcreteAttributedStringKey) oldMethodSel:@selector(initWithString:attributes:) newMethodSel:@selector(mhl_initWithString:attributes:) methodType:InstanceMethod];
}


#pragma mark - ================NSAttributedString 方法================

/**
 * initWithString:
 * @param str str
 * @return instancetype
 */
- (instancetype)mhl_initWithString:(NSString *)str {

    id object = nil;
    @try {
        object = [self mhl_initWithString:str];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {
        return object;
    }

}

/**
 * initWithAttributedString:
 * @param attrStr attrStr
 * @return instancetype
 */
- (instancetype)mhl_initWithAttributedString:(NSAttributedString *)attrStr {

    id object = nil;
    @try {
        object = [self mhl_initWithAttributedString:attrStr];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {
        return object;
    }
}

/**
 * initWithString:attributes:
 */
- (instancetype)mhl_initWithString:(NSString *)str attributes:(NSDictionary<NSString *, id> *)attrs {
    id object = nil;

    @try {
        object = [self mhl_initWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {
        return object;
    }
}

#pragma mark - ================NSMutableAttributedString 方法================

/**
 * initWithString:
 */
- (instancetype)mhl_M_initWithString:(NSString *)str {
    id object = nil;

    @try {
        object = [self mhl_M_initWithString:str];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {
        return object;
    }
}

/**
 *  initWithString:attributes:
 */
- (instancetype)mhl_M_initWithString:(NSString *)str attributes:(NSDictionary<NSString *, id> *)attrs {
    id object = nil;

    @try {
        object = [self mhl_M_initWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {
        return object;
    }
}


@end
