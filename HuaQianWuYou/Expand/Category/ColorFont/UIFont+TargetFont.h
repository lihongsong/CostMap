//
//  UIFont+TargetFont.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/3.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (TargetFont)
#pragma mark 百分比 55
+ (UIFont *)PercentTitleFont;

#pragma mark 发现详情大标题 25
+ (UIFont *)NewsBigTitleFont;

#pragma mark 大标题字体 20
+ (UIFont *)BigTitleFont;



#pragma mark 航栏Title文字字号 19
+ (UIFont *)NavigationTitleFont;

#pragma mark 导航栏右边字体 17
+ (UIFont *)navigationRightFont;

#pragma mark 普通标题 16
+ (UIFont *)NormalTitleFont;

#pragma mark 小标题 15
+ (UIFont *)NormalSmallTitleFont;

#pragma mark 正文字号 14
+ (UIFont *)normalFont;


#pragma mark 说明性文字 12
+ (UIFont *)stateFont;

#pragma mark 标签栏文字 11
+ (UIFont *)tabBarFont;
//额外需求另加
@end
