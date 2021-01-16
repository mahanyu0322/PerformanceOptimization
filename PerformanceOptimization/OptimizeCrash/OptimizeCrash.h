//
//  OptimizeCrash.h
//  MHLPO
//
//  Created by 马洪亮 on 2021/1/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSArray+OptimizeCrash.h"
#import <objc/runtime.h>
#import "NSDictionary+OptimizeCrash.h"
#import "NSString+OptimizeCrash.h"
#import "NSAttributedString+OptimizeCrash.h"
#import "NSObject+OptimizeCrash.h"
#import "NSData+OptimizeCrash.h"
#import "NSSet+OptimizeCrash.h"
#import "NSIndexSet+OptimizeCrash.h"
#import "UIView+OptimizeCrash.h"
#import "ExceptionHandler.h"
@class OptimizeCrashResult;
#define OptimizeCrashIsiOS(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)

/**
 * 数组
 */
#define NSArrayKey @"NSArray"
#define __NSArrayIKey @"__NSArrayI"
#define __NSSingleObjectArrayIKey @"__NSSingleObjectArrayI"
#define __NSArray0Key @"__NSArray0"
#define __NSArrayMKey @"__NSArrayM"


/**
 * 字典
 */
#define __NSDictionaryMKey @"__NSDictionaryM"

/**
 * 字符串
 */
#define __NSCFConstantStringKey @"__NSCFConstantString"
#define __NSCFStringKey @"__NSCFString"
#define NSPathStore2Key @"NSPathStore2"

#define NSConcreteAttributedStringKey @"NSConcreteAttributedString"
#define NSConcreteMutableAttributedStringKey @"NSConcreteMutableAttributedString"
/**
 * NSData
 */
#define NSConcreteMutableDataKey @"NSConcreteMutableData"

/**
 * NSSet
 */
#define __NSSetIKey @"NSSet"
#define __NSSetMKey @"__NSSetM"
#define __NSPlaceholderSetKey @"__NSPlaceholderSet"
#define NSIndexSetKey @"NSIndexSet"


/**
 方法类型
 */
typedef enum : NSUInteger {
    ClassMethod,
    InstanceMethod,
} MethodType;

typedef void(^CrashResultBlock)(OptimizeCrashResult *optimizeCrashResult);


@interface OptimizeCrashResult : NSObject
/**
 * 错误名称
 */
@property(nonatomic, copy) NSString *errorName;
/**
 * 错误原因
 */
@property(nonatomic, copy) NSString *errorReason;
/**
 * 错误坐标
 */
@property(nonatomic, copy) NSString *errorPlace;
/**
 * 调用栈
 */
@property(nonatomic, strong) NSArray *callStackSymbols;
/**
 * 异常信息
 */
@property(nonatomic, strong) NSException *exception;

@end


@interface OptimizeCrash : NSObject


/**
 * 开启crash优化
 * @param isPrintLogs 是否在控制台打印信息
 * @param isListeningMethod 是否监听方法异常
 * @param block 回调
 */
+ (void)startOptimizeCrashIsPrintLogs:(BOOL)isPrintLogs isListeningMethod:(BOOL)isListeningMethod Block:(CrashResultBlock)block;

/**
 * 交换方法
 * @param cls 当前类
 * @param oldMethodSel 原来的方法
 * @param newMethodSel 新方法
 * @param methodType 方法类型:ClassMethod 类方法 InstanceMethod 对象方法
 */
+ (void)exchangeMethod:(Class)cls oldMethodSel:(SEL)oldMethodSel newMethodSel:(SEL)newMethodSel methodType:(MethodType)methodType;

/**
 * 异常处理
 * @param exception 异常
 */
+ (void)errorWithException:(NSException *)exception;

@end

