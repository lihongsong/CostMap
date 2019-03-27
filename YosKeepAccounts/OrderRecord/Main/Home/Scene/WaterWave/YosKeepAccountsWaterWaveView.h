//
//  SHWWaterView.h
//  水波
//
//  Created by 孙洪伟 on 16/9/8.
//  Copyright © 2016年 Caffrey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YosKeepAccountsWaterWeakProxy.h"

@interface YosKeepAccountsWaterWaveView : UIView

/** 第一个波纹的速度，默认2.5像素/帧 */
@property(nonatomic, assign) CGFloat firstWaveSpeed;
/** 第二个波纹的速度，默认2像素/帧 */
@property(nonatomic, assign) CGFloat secondWaveSpeed;

/** 第一个波纹的高度，默认10 */
@property(nonatomic, assign) CGFloat firstWaveHeight;
/** 第二个波纹的高度，默认10 */
@property(nonatomic, assign) CGFloat secondWaveHeight;

/** 第一个波纹的颜色，默认cyanColor */
@property(nonatomic, strong) UIColor *firstWaveColor;
/** 第一个波纹的颜色，默认lightGrayColor */
@property(nonatomic, strong) UIColor *secondWaveColor;

/** 水波在视图中的进度(或者叫做在y轴方向的位置，0.5，为在中间，0在底部)，默认0.5 */
@property(nonatomic, assign) CGFloat progress;

/** 波纹有几个波 */
@property(nonatomic, assign) NSUInteger waterWaveNum;

/** 是否显示第二个波纹，默认NO */
@property(nonatomic, assign) BOOL showSecondWave;

@property(nonatomic, assign, readonly, getter = isAnimationing) BOOL animationing;

/** 开始动画 */
- (void)startWaveAnimate;

/** 结束动画 */
- (void)stopWaveAnimate;

@end
