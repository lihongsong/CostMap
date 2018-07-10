//
//  UIButton+EnlableColor.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlableColor)

@property (nonatomic ,strong) UIColor *enlableColor;

@property (nonatomic ,strong) UIColor *disEnlableColor;

- (void)enlableColor:(UIColor*)enlableColor disEnlableColor:(UIColor *)disEnlableColor;
@end
