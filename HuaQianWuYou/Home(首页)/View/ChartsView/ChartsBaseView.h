//
//  ChartsBaseView.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/10.
//  Copyright © 2018年 jason. All rights reserved.
//
typedef NS_ENUM(NSInteger, ChartsViewStates){
    ChartsViewStatesToggleValues,//切换值
    ChartsViewStatesToggleIcons,//切换icon
    ChartsViewStatesToggleHighlight,//
    ChartsViewStatesAnimateX,//X轴动画
    ChartsViewStatesAnimateY,//Y轴动画
    ChartsViewStatesAnimateXY,//XY动画
    ChartsViewStatesSaveToGallery,//保存至相册
    ChartsViewStatesTogglePinchZoom,
    ChartsViewStatesToggleAutoScaleMinMax,
    ChartsViewStatesToggleData,
    ChartsViewStatesToggletoggleBarBorders,
};

typedef NS_ENUM(NSInteger, AnimateDirection){
    animateDirectionX,
    animateDirectionY,
    animateDirectionXY,
};

#import <UIKit/UIKit.h>
#import "HuaQianWuYou-Bridging-Header.h"

@interface ChartsBaseView : UIView

#pragma mark 设置ChartsView的多个属性样式
// 用Bool，后期可自定义扩转换类型，参考animateDirection
@property(nonatomic,assign)BOOL toggleValues;//切换值
@property(nonatomic,assign)BOOL toggleIcons;//切换icon
@property(nonatomic,assign)BOOL toggleHighlight;
@property(nonatomic,assign)AnimateDirection animateDirection;//XY动画方向
@property(nonatomic,assign)BOOL togglePinchZoom;
@property(nonatomic,assign)BOOL toggleAutoScaleMinMax;
@property(nonatomic,assign)BOOL toggleBarBorders;

@property (nonatomic, assign) BOOL shouldHideData;
/*
#pragma mark 设置 PieChartView
- (void)setupPieChartView:(PieChartView *)chartView;

#pragma mark 设置 RadarChartView
- (void)setupRadarChartView:(RadarChartView *)chartView;

#pragma mark 设置 BarLineChartViewBase
- (void)setupBarLineChartView:(BarLineChartViewBase *)chartView;
 */
@end
