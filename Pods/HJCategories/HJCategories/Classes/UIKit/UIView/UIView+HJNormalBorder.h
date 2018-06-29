//
//  UIView+HJNormalBorder.h
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import <UIKit/UIKit.h>

@interface UIView (HJNormalBorder)

/**
 边框的颜色
 */
@property (strong, nonatomic) IBInspectable UIColor *borderColor;

/**
 边框的宽度
 */
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;

@end
