//
//  UIColor+HJGradient.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <UIKit/UIKit.h>

@interface UIColor (HJGradient)

/**
 *  @brief  渐变颜色
 *
 *  @param c1     开始颜色
 *  @param c2     结束颜色
 *  @param height 渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)hj_gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;

@end
