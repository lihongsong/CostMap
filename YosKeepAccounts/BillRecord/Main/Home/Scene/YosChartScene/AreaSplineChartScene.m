#import "AreaSplineChartScene.h"
@implementation AreaSplineChartScene
-(void)initialize{
}
-(YosChartScene *)zzChartScene{
    if (_zzChartScene == nil) {
        _zzChartScene = [[YosChartScene alloc]init];
        _zzChartScene.delegate = self;
        _zzChartScene.scrollEnabled = NO;
    }
    return _zzChartScene;
}
-(void)setChartType:(AreaSplineType)type{
    [self addSubview:self.zzChartScene];
    self.zzChartScene.isClearBackgroundColor = YES;
    self.zzChartScene.chartSeriesHidden = true;
    self.zzChartEntity= YosObject(YosChartEntity)
    .chartTypeSet(YosChartTypeAreaspline)
    .titleSet(@"")
    .subtitleSet(@"")
    .yAxisTitleSet(@"")
    .yAxisGridLineWidthSet(@0)
    .xAxisGridLineWidthSet(@0)
    .seriesSet(@[
                 YosObject(YosSeriesElement)
                 .dataSet(@[@37.0, @49.5, @68.2, @66.5, @58.3, @43.9])
                 ]
               );
    _chartType = type;
    [self configureTheStyleForDifferentTypeChart:type];
    [self configureTheYAxisPlotLineForYosChartScene:type];
    [self.zzChartScene aa_drawChartWithChartEntity:self.zzChartEntity];
}
- (void)layoutSubviews {
    CGFloat chartSceneWidth  = self.hj_width;
    CGFloat chartSceneHeight = self.hj_height;
     self.zzChartScene.frame = CGRectMake(0, 0, chartSceneWidth, chartSceneHeight);
}
- (void)configureTheStyleForDifferentTypeChart:(AreaSplineType)type {
    self.zzChartEntity.symbolStyle = YosChartSymbolStyleTypeInnerBlank;
    self.zzChartEntity.gradientColorEnabled = true;
    self.zzChartEntity.animationType = YosChartAnimationEaseOutQuart;
    self.zzChartEntity.xAxisCrosshairWidth = @0.9;
    self.zzChartEntity.xAxisCrosshairColor = @"#f0f0f0";
    self.zzChartEntity.xAxisCrosshairDashStyleType = YosLineDashSyleTypeLongDashDot;
    self.zzChartEntity.yAxisLineWidth = @0;
    self.zzChartEntity.tooltipEnabled = false;
    self.zzChartEntity.categoriesSet(@[@"11月", @"12月", @"01月", @"02月", @"03月", @"04月"]);
    if (type == AreaSplineTypeSingle) {
        self.zzChartEntity.yAxisGridLineWidth = @0.5;
        self.zzChartEntity.legendEnabled = false;
        self.zzChartEntity.series =@[
                                    YosObject(YosSeriesElement)
                                    .nameSet(@"2017")
                                    .lineWidthSet(@5)
                                    .fillOpacitySet(@0.3)
                                    .dataSet(self.callArr)
                                    ];
    }else if (type == AreaSplineTypeCompare){
        self.zzChartEntity.yAxisGridLineWidth = @0;
        _zzChartEntity.series =@[
                                    YosObject(YosSeriesElement)
                                    .nameSet(@"主叫")
                                    .fillOpacitySet(@0.3)
                                    .dataSet(self.callArr),
                                    YosObject(YosSeriesElement)
                                    .nameSet(@"被叫")
                                    .dataSet(self.beCallArr),
                                    ];
    }
}
- (void)configureTheYAxisPlotLineForYosChartScene:(AreaSplineType)type {
    if (type == AreaSplineTypeSingle) {
        self.zzChartEntity
        .yAxisMaxSet(@(10))
        .yAxisMinSet(@(1))
        .yAxisAllowDecimalsSet(NO)
        .colorsThemeSet(@[@"#FF601A",@"#ffc069"])
        .markerRadiusSet(@(4))
        .yAxisTickPositionsSet(@[@(0),@(2),@(6),@(10)])
        .yAxisPlotLinesSet(@[
                             YosObject(YosPlotLinesElement)
                             .colorSet(@"#E6E6E6")
                             .dashStyleSet(YosLineDashSyleTypeLongDashDot)
                             .widthSet(@(1)) 
                             .valueSet(@(40)) 
                             .zIndexSet(@(1)) 
                             .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"#E6E6E6"}})
                             ,YosObject(YosPlotLinesElement)
                             .colorSet(@"#E6E6E6")
                             .dashStyleSet(YosLineDashSyleTypeLongDashDot)
                             .widthSet(@(1))
                             .valueSet(@(80))
                             .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"#E6E6E6"}})
                             ]
                           );
    }else if (type == AreaSplineTypeCompare){
        self.zzChartEntity
        .yAxisMaxSet(@(11))
        .yAxisMinSet(@(0.1))
        .markerRadiusSet(@(0))
        .colorsThemeSet(@[@"#FD6F93",@"#F76B1C"])
        .yAxisAllowDecimalsSet(NO)
        .yAxisTickPositionsSet(@[@(0),@(2),@(4),@(6),@(8),@(10)])
        .yAxisPlotLinesSet(@[
                             YosObject(YosPlotLinesElement)
                             .colorSet(@"#E6E6E6")
                             .dashStyleSet(YosLineDashSyleTypeLongDashDot)
                             .widthSet(@(1)) 
                             .valueSet(@(2)) 
                             .zIndexSet(@(1)) 
                             .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"#E6E6E6"}})
                             ,YosObject(YosPlotLinesElement)
                             .colorSet(@"#E6E6E6")
                             .dashStyleSet(YosLineDashSyleTypeLongDashDot)
                             .widthSet(@(1))
                             .valueSet(@(4))
                             .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"#E6E6E6"}})
                             ,YosObject(YosPlotLinesElement)
                              .colorSet(@"#E6E6E6")
                              .dashStyleSet(YosLineDashSyleTypeLongDashDot)
                              .widthSet(@(1))
                              .valueSet(@(6))
                              .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"#E6E6E6"}})
                             ,YosObject(YosPlotLinesElement)
                              .colorSet(@"#E6E6E6")
                              .dashStyleSet(YosLineDashSyleTypeLongDashDot)
                              .widthSet(@(1))
                              .valueSet(@(8))
                              .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"#E6E6E6"}})
                              ,YosObject(YosPlotLinesElement)
                             .colorSet(@"#E6E6E6")
                              .dashStyleSet(YosLineDashSyleTypeLongDashDot)
                              .widthSet(@(1))
                              .valueSet(@(10))
                             .zIndexSet(@(2))
                              .labelSet(@{@"text":@"",@"x":@(0),@"style":@{@"color":@"E6E6E6"}})
                             ]
                           );
    }
}
#pragma mark -- YosChartScene delegate
- (void)YosChartSceneDidFinishLoad {
    NSLog(@"🔥🔥🔥🔥🔥 YosChartScene content did finish load!!!");
}
@end
