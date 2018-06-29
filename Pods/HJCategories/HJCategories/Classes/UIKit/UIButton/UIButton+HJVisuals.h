//
//  UIButton+HJVisuals.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <UIKit/UIKit.h>

@interface UIButton (HJVisuals)

/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)hj_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
