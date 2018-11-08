//
//  WYHQLeapButton.h
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/8.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYHQLeapButton : UIButton

/**
 隐藏在屏幕外 动画方向向下
 */
- (void)hideOutScreen;

/**
 现在在屏幕上 动画方向向上
 */
- (void)showInScreen;

/**
 开始跳动动画
 */
- (void)startLeapAnimate;

/**
 结束跳动动画
 */
- (void)stopLeapAnimate;

@end

NS_ASSUME_NONNULL_END
