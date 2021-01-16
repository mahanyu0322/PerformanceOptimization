//
//  NSString+OptimizeCrash.m
//  MHLPO
//
//  Created by 马洪亮 on 2021/1/14.
//

#import "NSString+OptimizeCrash.h"

@implementation NSString (OptimizeCrash)

+ (void)optimizeCrashCategoryMethod {

    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        //====================NSString============================
        [self nsstring];
        //====================NSMutableString============================
        [self nsmutableString];
    });

}

#pragma mark - =================NSMutableString 类================

+ (void)nsmutableString {
//replaceCharactersInRange:withString:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSCFStringKey) oldMethodSel:@selector(replaceCharactersInRange:withString:) newMethodSel:@selector(mhl_replaceCharactersInRange:withString:) methodType:InstanceMethod];

    //insertString:atIndex:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSCFStringKey) oldMethodSel:@selector(insertString:atIndex:) newMethodSel:@selector(mhl_insertString:atIndex:) methodType:InstanceMethod];

    //deleteCharactersInRange
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSCFStringKey) oldMethodSel:@selector(deleteCharactersInRange:) newMethodSel:@selector(mhl_deleteCharactersInRange:) methodType:InstanceMethod];
}

#pragma mark - =================NSString 类================

+ (void)nsstring {
    //characterAtIndex
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSCFConstantStringKey) oldMethodSel:@selector(characterAtIndex:) newMethodSel:@selector(mhl_characterAtIndex:) methodType:InstanceMethod];

    //substringFromIndex
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSCFConstantStringKey) oldMethodSel:@selector(substringFromIndex:) newMethodSel:@selector(mhl_substringFromIndex:) methodType:InstanceMethod];

    //substringToIndex
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSCFConstantStringKey) oldMethodSel:@selector(substringToIndex:) newMethodSel:@selector(mhl_substringToIndex:) methodType:InstanceMethod];

    //substringWithRange:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSCFConstantStringKey) oldMethodSel:@selector(substringWithRange:) newMethodSel:@selector(mhl_substringWithRange:) methodType:InstanceMethod];

    //stringByReplacingOccurrencesOfString:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSCFConstantStringKey) oldMethodSel:@selector(stringByReplacingOccurrencesOfString:withString:) newMethodSel:@selector(mhl_stringByReplacingOccurrencesOfString:withString:) methodType:InstanceMethod];

    //stringByReplacingOccurrencesOfString:withString:options:range:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSCFConstantStringKey) oldMethodSel:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) newMethodSel:@selector(mhl_stringByReplacingOccurrencesOfString:withString:options:range:) methodType:InstanceMethod];

    //stringByReplacingCharactersInRange:withString:
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSCFConstantStringKey) oldMethodSel:@selector(stringByReplacingCharactersInRange:withString:) newMethodSel:@selector(mhl_stringByReplacingCharactersInRange:withString:) methodType:InstanceMethod];

    //stringByAppendingString
    [OptimizeCrash exchangeMethod:NSClassFromString(__NSCFConstantStringKey) oldMethodSel:@selector(stringByAppendingString:) newMethodSel:@selector(mhl_stringByAppendingString:) methodType:InstanceMethod];

    /**
        * ==================NSPathStore2=======================
        */
    //stringByAppendingString:
    [OptimizeCrash exchangeMethod:NSClassFromString(NSPathStore2Key) oldMethodSel:@selector(stringByAppendingString:) newMethodSel:@selector(mhl_NSPathStore2StringByAppendingString:) methodType:InstanceMethod];
}


#pragma mark - =================NSString 方法================

/**
 * characterAtIndex:
 */
- (unichar)mhl_characterAtIndex:(NSUInteger)index {

    unichar characteristic;
    @try {
        characteristic = [self mhl_characterAtIndex:index];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {
        return characteristic;
    }
}

/**
 * substringFromIndex:
 */
- (NSString *)mhl_substringFromIndex:(NSUInteger)from {

    NSString *subString = nil;

    @try {
        subString = [self mhl_substringFromIndex:from];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
        subString = nil;
    }
    @finally {
        return subString;
    }
}

/**
 * substringToIndex:
 */
- (NSString *)mhl_substringToIndex:(NSUInteger)to {

    NSString *subString = nil;

    @try {
        subString = [self mhl_substringToIndex:to];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
        subString = nil;
    }
    @finally {
        return subString;
    }
}

/**
 * substringWithRange:
 */
- (NSString *)mhl_substringWithRange:(NSRange)range {
    NSString *subString = nil;
    @try {
        subString = [self mhl_substringWithRange:range];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
        subString = nil;
    }
    @finally {
        return subString;
    }
}

/**
 * stringByReplacingOccurrencesOfString:
 */
- (NSString *)mhl_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {
    NSString *newStr = nil;
    @try {
        newStr = [self mhl_stringByReplacingOccurrencesOfString:target withString:replacement];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

/**
 * stringByReplacingOccurrencesOfString:withString:options:range:
 */
- (NSString *)mhl_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    NSString *newStr = nil;
    @try {
        newStr = [self mhl_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

/**
 * stringByReplacingCharactersInRange:withString:
 */
- (NSString *)mhl_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    NSString *newStr = nil;

    @try {
        newStr = [self mhl_stringByReplacingCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

/**
 * stringByAppendingString:
 */
- (NSString *)mhl_stringByAppendingString:(NSString *)aString {
    NSString *newStr = nil;
    @try {
        newStr = [self mhl_stringByAppendingString:aString];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

/**
 * NSPathStore2 StringByAppendingString:
 */
- (NSString *)mhl_NSPathStore2StringByAppendingString:(NSString *)aString {
    NSString *newStr = nil;

    @try {
        newStr = [self mhl_NSPathStore2StringByAppendingString:aString];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}


#pragma mark - =================NSMutableString 方法================

/**
 * replaceCharactersInRange:withString:
 */
- (void)mhl_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {

    @try {
        [self mhl_replaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {

    }
}

/**
 * insertString:atIndex:
 */
- (void)mhl_insertString:(NSString *)aString atIndex:(NSUInteger)loc {

    @try {
        [self mhl_insertString:aString atIndex:loc];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {}
}

/**
 *  deleteCharactersInRange:
 */
- (void)mhl_deleteCharactersInRange:(NSRange)range {

    @try {
        [self mhl_deleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {

    }
}

@end
