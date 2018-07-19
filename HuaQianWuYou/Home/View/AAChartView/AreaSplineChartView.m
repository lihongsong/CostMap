//
//  AreaSplineChartView.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "AreaSplineChartView.h"

@implementation AreaSplineChartView
-(void)initialize{
}

-(AAChartView *)zzChartView{
    if (_zzChartView == nil) {
        _zzChartView = [[AAChartView alloc]init];
        _zzChartView.delegate = self;
        _zzChartView.scrollEnabled = NO;//禁用 zzChartView 滚动效果
        //    设置zzChartVie 的内容高度(content height)
        //    self.zzChartView.contentHeight = chartViewHeight*2;
        //    设置zzChartVie 的内容宽度(content  width)
        //    self.zzChartView.contentWidth = chartViewWidth*2;
    }
    return _zzChartView;
}

-(void)setChartType:(AreaSplineType)type{
    [self addSubview:self.zzChartView];
    
    //设置 zzChartView 的背景色是否为透明
    self.zzChartView.isClearBackgroundColor = YES;
    self.zzChartView.chartSeriesHidden = true;
    self.zzChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeAreaspline)//图表类型
    .titleSet(@"")//图表主标题
    .subtitleSet(@"")//图表副标题
    //.yAxisLineWidthSet(@0)//Y轴轴线线宽为0即是隐藏Y轴轴线
    .yAxisTitleSet(@"")//设置 Y 轴标题
    // .tooltipValueSuffixSet(@"℃")//设置浮动提示框单位后缀
//    .backgroundColorSet(@"#FF601A")
    .yAxisGridLineWidthSet(@0)//y轴横向分割线宽度为0(即是隐藏分割线)
    .xAxisGridLineWidthSet(@0)
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 //.nameSet(@"")
                 .dataSet(@[@37.0, @49.5, @68.2, @66.5, @58.3, @43.9])
                 ]
               );
    _chartType = type;
    [self configureTheStyleForDifferentTypeChart:type];//为不同类型图表设置样式
    
    /*配置 Y 轴标注线,解开注释,即可查看添加标注线之后的图表效果(NOTE:必须设置 Y 轴可见)*/
    [self configureTheYAxisPlotLineForAAChartView:type];
    
    [self.zzChartView aa_drawChartWithChartModel:self.zzChartModel];
}

- (void)layoutSubviews {
    CGFloat chartViewWidth  = self.hj_width;
    CGFloat chartViewHeight = self.hj_height;
     self.zzChartView.frame = CGRectMake(0, 0, chartViewWidth, chartViewHeight);
}

- (void)configureTheStyleForDifferentTypeChart:(AreaSplineType)type {
    self.zzChartModel.symbolStyle = AAChartSymbolStyleTypeInnerBlank;//设置折线连接点样式为:内部白色
    self.zzChartModel.gradientColorEnabled = true;//启用渐变色
    self.zzChartModel.animationType = AAChartAnimationEaseOutQuart;//图形的渲染动画为 EaseOutQuart 动画
    self.zzChartModel.xAxisCrosshairWidth = @0.9;//Zero width to disable crosshair by default
    self.zzChartModel.xAxisCrosshairColor = @"#f0f0f0";//(浓汤)乳脂,番茄色准星线
    self.zzChartModel.xAxisCrosshairDashStyleType = AALineDashSyleTypeLongDashDot;
    self.zzChartModel.yAxisLineWidth = @0;
    self.zzChartModel.tooltipEnabled = false;
    //self.zzChartModel.yAxisLabelsEnabled = false;
    self.zzChartModel.categoriesSet(@[@"11月", @"12月", @"01月", @"02月", @"03月", @"04月"]);
    if (type == AreaSplineTypeSingle) {
        self.zzChartModel.yAxisGridLineWidth = @0.5;
        self.zzChartModel.legendEnabled = false;
        self.zzChartModel.series =@[
                                    AAObject(AASeriesElement)
                                    .nameSet(@"2017")
                                    .lineWidthSet(@5)
                                    .fillOpacitySet(@0.3)
                                    .dataSet(self.callArr)
                                    ];
    }else if (type == AreaSplineTypeCompare){
        self.zzChartModel.yAxisGridLineWidth = @0;
        _zzChartModel.series =@[
                                    AAObject(AASeriesElement)
                                    .nameSet(@"主叫")
                                    .fillOpacitySet(@0.3)
                                    .dataSet(self.callArr),
                                    AAObject(AASeriesElement)
                                    .nameSet(@"被叫")
                                    .dataSet(self.beCallArr),
                                    ];
    }
    
}

- (void)configureTheYAxisPlotLineForAAChartView:(AreaSplineType)type {
    if (type == AreaSplineTypeSingle) {
        self.zzChartModel
        .yAxisMaxSet(@(10))//Y轴最大值
        .yAxisMinSet(@(1))//Y轴最小值
        .yAxisAllowDecimalsSet(NO)//是否允许Y轴坐标值小数
        .colorsThemeSet(@[@"#FF601A",@"#ffc069"])//设置折线，主体颜色数组
        .markerRadiusSet(@(4))
        .yAxisTickPositionsSet(@[@(0),@(2),@(6),@(10)])//指定y轴坐标
        .yAxisPlotLinesSet(@[
                             AAObject(AAPlotLinesElement)
                             .colorSet(@"#E6E6E6")//颜色值(16进制)
                             .dashStyleSet(AALineDashSyleTypeLongDashDot)//样式：Dash,Dot,Solid等,默认Solid
                             .widthSet(@(1)) //标示线粗细
                             .valueSet(@(40)) //所在位置
                             .zIndexSet(@(1)) //层叠,标示线在图表中显示的层叠级别，值越大，显示越向前
                             .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"#E6E6E6"}})/*这里其实也可以像AAPlotLinesElement这样定义个对象来赋值（偷点懒直接用了字典，最会终转为js代码，可参考https://www.hcharts.cn/docs/basic-plotLines来写字典）*/
                             ,AAObject(AAPlotLinesElement)
                             .colorSet(@"#E6E6E6")
                             .dashStyleSet(AALineDashSyleTypeLongDashDot)
                             .widthSet(@(1))
                             .valueSet(@(80))
                             .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"#E6E6E6"}})
                             /*,AAObject(AAPlotLinesElement)
                              .colorSet(@"#ADFF2F")
                              .dashStyleSet(AALineDashSyleTypeLongDashDot)
                              .widthSet(@(1))
                              .valueSet(@(100))
                              .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"f0f0f0"}})*/
                             ]
                           );
    }else if (type == AreaSplineTypeCompare){
        self.zzChartModel
        .yAxisMaxSet(@(11))//Y轴最大值
        .yAxisMinSet(@(0.1))//Y轴最小值
        .markerRadiusSet(@(0))
        .colorsThemeSet(@[@"#FD6F93",@"#F76B1C"])//设置折线，主体颜色数组
        .yAxisAllowDecimalsSet(NO)//是否允许Y轴坐标值小数
        .yAxisTickPositionsSet(@[@(0),@(2),@(4),@(6),@(8),@(10)])//指定y轴坐标
        .yAxisPlotLinesSet(@[
                             AAObject(AAPlotLinesElement)
                             .colorSet(@"#E6E6E6")//颜色值(16进制)
                             .dashStyleSet(AALineDashSyleTypeLongDashDot)//样式：Dash,Dot,Solid等,默认Solid
                             .widthSet(@(1)) //标示线粗细
                             .valueSet(@(2)) //所在位置
                             .zIndexSet(@(1)) //层叠,标示线在图表中显示的层叠级别，值越大，显示越向前
                             .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"#E6E6E6"}})/*这里其实也可以像AAPlotLinesElement这样定义个对象来赋值（偷点懒直接用了字典，最会终转为js代码，可参考https://www.hcharts.cn/docs/basic-plotLines来写字典）*/
                             ,AAObject(AAPlotLinesElement)
                             .colorSet(@"#E6E6E6")
                             .dashStyleSet(AALineDashSyleTypeLongDashDot)
                             .widthSet(@(1))
                             .valueSet(@(4))
                             .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"#E6E6E6"}})
                             ,AAObject(AAPlotLinesElement)
                              .colorSet(@"#E6E6E6")
                              .dashStyleSet(AALineDashSyleTypeLongDashDot)
                              .widthSet(@(1))
                              .valueSet(@(6))
                              .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"#E6E6E6"}})
                             ,AAObject(AAPlotLinesElement)
                              .colorSet(@"#E6E6E6")
                              .dashStyleSet(AALineDashSyleTypeLongDashDot)
                              .widthSet(@(1))
                              .valueSet(@(8))
                              .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"#E6E6E6"}})
                              ,AAObject(AAPlotLinesElement)
                             .colorSet(@"#E6E6E6")
                              .dashStyleSet(AALineDashSyleTypeLongDashDot)
                              .widthSet(@(1))
                              .valueSet(@(10))
                             .zIndexSet(@(2))
                              .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"E6E6E6"}})
                             ]
                           );
    }
}

#pragma mark -- AAChartView delegate
- (void)AAChartViewDidFinishLoad {
    NSLog(@"🔥🔥🔥🔥🔥 AAChartView content did finish load!!!");
}

@end
