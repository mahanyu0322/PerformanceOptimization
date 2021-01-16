//
// Created by 马洪亮 on 2021/1/15.
//

#import "UIView+OptimizeCrash.h"


@implementation UIView (OptimizeCrash)

+ (void)optimizeCrashCategoryMethod {

    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        [OptimizeCrash exchangeMethod:[self class] oldMethodSel:@selector(setNeedsLayout) newMethodSel:@selector(mhl_setNeedsLayout) methodType:InstanceMethod];
        [OptimizeCrash exchangeMethod:[self class] oldMethodSel:@selector(layoutIfNeeded) newMethodSel:@selector(mhl_layoutIfNeeded) methodType:InstanceMethod];
        [OptimizeCrash exchangeMethod:[self class] oldMethodSel:@selector(layoutSubviews) newMethodSel:@selector(mhl_layoutSubviews) methodType:InstanceMethod];
        [OptimizeCrash exchangeMethod:[self class] oldMethodSel:@selector(setNeedsUpdateConstraints) newMethodSel:@selector(mhl_setNeedsUpdateConstraints) methodType:InstanceMethod];

    });
}

#pragma mark ============方法=========
/**
 * setNeedsLayout
 */
-(void)mhl_setNeedsLayout{
    if ([NSThread isMainThread]){
        [self mhl_setNeedsLayout];
    } else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self mhl_setNeedsLayout];
        });
    }
}

/**
 * layoutIfNeeded
 */
-(void)mhl_layoutIfNeeded{
    if ([NSThread isMainThread]){
        [self mhl_layoutIfNeeded];
    } else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self mhl_layoutIfNeeded];
        });
    }
}

/**
 * layoutSubviews
 */
-(void)mhl_layoutSubviews{
    if ([NSThread isMainThread]){
        [self mhl_layoutSubviews];
    } else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self mhl_layoutSubviews];
        });
    }
}

/**
 * setNeedsUpdateConstraints
 */
-(void)mhl_setNeedsUpdateConstraints{
    if ([NSThread isMainThread]){
        [self mhl_setNeedsUpdateConstraints];
    } else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self mhl_setNeedsUpdateConstraints];
        });
    }
}


@end
