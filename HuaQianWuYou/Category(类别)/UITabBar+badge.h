//
//  UITabBar+badge.h
//  WitCar
//
//  Created by AsiaZhang on 16/12/19.
//  Copyright © 2016年 zhifu360. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)
- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

- (void)showNewMessage:(int)index; //显示提示图片
- (void)hideMessage:(int)index;// //隐藏图片
@end
