//
//  UINavigationItem+HJMargin.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//
// https://github.com/devxoul/UINavigationItem-Margin

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double UINavigationItem_MarginVersionNumber;
FOUNDATION_EXPORT const unsigned char UINavigationItem_MarginVersionString[];

@interface UINavigationItem (HJMargin)

/**
 leftItem 相对于左边界的 Margin
 */
@property (nonatomic, assign) CGFloat hj_leftMargin;

/**
 leftItem 相对于右边界的 Margin
 */
@property (nonatomic, assign) CGFloat hj_rightMargin;

/**
 返回系统默认的 Margin
 */
+ (CGFloat)hj_systemMargin;

@end
