#import "YosOptions.h"
@implementation YosOptions
YosPropSetFuncImplementation(YosOptions, YosChart       *, chart);
YosPropSetFuncImplementation(YosOptions, YosTitle       *, title);
YosPropSetFuncImplementation(YosOptions, YosSubtitle    *, subtitle);
YosPropSetFuncImplementation(YosOptions, YosXAxis       *, xAxis);
YosPropSetFuncImplementation(YosOptions, YosYAxis       *, yAxis);
YosPropSetFuncImplementation(YosOptions, YosTooltip     *, tooltip);
YosPropSetFuncImplementation(YosOptions, YosPlotOptions *, plotOptions);
YosPropSetFuncImplementation(YosOptions, NSArray       *, series);
YosPropSetFuncImplementation(YosOptions, YosLegend      *, legend);
YosPropSetFuncImplementation(YosOptions, NSArray       *, colors);
YosPropSetFuncImplementation(YosOptions, BOOL,            gradientColorEnabled);
YosPropSetFuncImplementation(YosOptions, NSString      *, zoomResetButtonText); 
@end
#define YosFontSizeFormat(fontSize) [NSString stringWithFormat:@"%@%@", fontSize, @"px"]
@implementation YosOptionsConstructor
+ (YosOptions *)configureChartOptionsWithYosChartEntity:(YosChartEntity *)aaChartEntity {
    YosChart *aaChart = YosObject(YosChart)
    .typeSet(aaChartEntity.chartType)
    .invertedSet(aaChartEntity.inverted)
    .backgroundColorSet(aaChartEntity.backgroundColor)
    .pinchTypeSet(aaChartEntity.zoomType)
    .panningSet(true)
    .polarSet(aaChartEntity.polar);
    if (aaChartEntity.options3dEnabled == true) {
        aaChart.options3d = (YosObject(YosOptions3d)
                             .enabledSet(aaChartEntity.options3dEnabled)
                             .alphaSet(@(-15))
                             );
    }
    YosTitle *aaTitle = YosObject(YosTitle)
    .textSet(aaChartEntity.title)
    .styleSet(YosObject(YosStyle)
              .colorSet(aaChartEntity.titleFontColor)
              .fontSizeSet(YosFontSizeFormat(aaChartEntity.titleFontSize))
              .fontWeightSet(aaChartEntity.titleFontWeight)
              );
    YosSubtitle *aaSubtitle = YosObject(YosSubtitle)
    .textSet(aaChartEntity.subtitle)
    .alignSet(aaChartEntity.subtitleAlign)
    .styleSet(YosObject(YosStyle)
              .colorSet(aaChartEntity.subtitleFontColor)
              .fontSizeSet(YosFontSizeFormat(aaChartEntity.subtitleFontSize))
              .fontWeightSet(aaChartEntity.subtitleFontWeight)
              );
    YosTooltip *aaTooltip = YosObject(YosTooltip)
    .enabledSet(aaChartEntity.tooltipEnabled)
    .sharedSet(true)
    .crosshairsSet(true)
    .valueSuffixSet(aaChartEntity.tooltipValueSuffix);
    YosPlotOptions *aaPlotOptions = YosObject(YosPlotOptions)
    .seriesSet(YosObject(YosSeries)
               .stackingSet(aaChartEntity.stacking)
               .keysSet(aaChartEntity.keys)
               );
    if (aaChartEntity.animationType != 0) {
        NSString *chartAnimationType = [self configureTheEasingAnimationType:aaChartEntity.animationType];
        aaPlotOptions.series.animation = (YosObject(YosAnimation)
                                          .easingSet(chartAnimationType)
                                          .durationSet(aaChartEntity.animationDuration)
                                          );
    }
    [self configureTheStyleOfConnectNodeWithChartEntity:aaChartEntity plotOptions:aaPlotOptions];
    aaPlotOptions = [self configureTheYosPlotOptionsWithPlotOptions:aaPlotOptions chartEntity:aaChartEntity];
    YosLegend *aaLegend = YosObject(YosLegend)
    .enabledSet(aaChartEntity.legendEnabled)
    .layoutSet(YosLegendLayoutTypeHorizontal)
    .alignSet(YosLegendAlignTypeCenter)
    .verticalAlignSet(YosLegendVerticalAlignTypeBottom)
    .itemMarginTopSet(@0);
    YosOptions *aaOptions = YosObject(YosOptions)
    .chartSet(aaChart)
    .titleSet(aaTitle)
    .subtitleSet(aaSubtitle)
    .tooltipSet(aaTooltip)
    .plotOptionsSet(aaPlotOptions)
    .legendSet(aaLegend)
    .seriesSet(aaChartEntity.series)
    .colorsSet(aaChartEntity.colorsTheme)
    .gradientColorEnabledSet(aaChartEntity.gradientColorEnabled)
    .zoomResetButtonTextSet(aaChartEntity.zoomResetButtonText);
    if (   ![aaChartEntity.chartType isEqualToString:YosChartTypePie]
        && ![aaChartEntity.chartType isEqualToString:YosChartTypePyramid]
        && ![aaChartEntity.chartType isEqualToString:YosChartTypeFunnel]) {
        YosXAxis *aaXAxis = YosObject(YosXAxis);
        YosYAxis *aaYAxis = YosObject(YosYAxis);
        [self configureAxisContentAndStyleWithYosXAxis:aaXAxis YosYAxis:aaYAxis YosChartEntity:aaChartEntity];
        aaOptions.xAxis = aaXAxis;
        aaOptions.yAxis = aaYAxis;
    }
    return aaOptions;
}
+ (void)configureAxisContentAndStyleWithYosXAxis:(YosXAxis *)aaXAxis YosYAxis:(YosYAxis *)aaYAxis YosChartEntity:(YosChartEntity *)aaChartEntity {
    aaXAxis.labelsSet(YosObject(YosLabels)
                      .enabledSet(aaChartEntity.xAxisLabelsEnabled)
                      .styleSet(YosObject(YosStyle)
                                .colorSet(aaChartEntity.xAxisLabelsFontColor)
                                .fontSizeSet(YosFontSizeFormat(aaChartEntity.xAxisLabelsFontSize))
                                .fontWeightSet(aaChartEntity.xAxisLabelsFontWeight)
                                )
                      )
    .reversedSet(aaChartEntity.xAxisReversed)
    .gridLineWidthSet(aaChartEntity.xAxisGridLineWidth)
    .categoriesSet(aaChartEntity.categories)
    .visibleSet(aaChartEntity.xAxisVisible)
    .tickIntervalSet(aaChartEntity.xAxisTickInterval);
    if ([aaChartEntity.xAxisCrosshairWidth floatValue]>0) {
        aaXAxis.crosshairSet(YosObject(YosCrosshair)
                             .widthSet(aaChartEntity.xAxisCrosshairWidth)
                             .colorSet(aaChartEntity.xAxisCrosshairColor)
                             .dashStyleSet(aaChartEntity.xAxisCrosshairDashStyleType)
                             );
    }
    aaYAxis.labelsSet(YosObject(YosLabels)
                      .enabledSet(aaChartEntity.yAxisLabelsEnabled)
                      .styleSet(YosObject(YosStyle)
                                .colorSet(aaChartEntity.yAxisLabelsFontColor)
                                .fontSizeSet(YosFontSizeFormat(aaChartEntity.yAxisLabelsFontSize))
                                .fontWeightSet(aaChartEntity.yAxisLabelsFontWeight)
                                )
                      .formatSet(@"{value:.,0f}")
                      )
    .minSet(aaChartEntity.yAxisMin)
    .maxSet(aaChartEntity.yAxisMax)
    .tickPositionsSet(aaChartEntity.yAxisTickPositions)
    .allowDecimalsSet(aaChartEntity.yAxisAllowDecimals)
    .plotLinesSet(aaChartEntity.yAxisPlotLines) 
    .reversedSet(aaChartEntity.yAxisReversed)
    .gridLineWidthSet(aaChartEntity.yAxisGridLineWidth)
    .titleSet(YosObject(YosTitle)
              .textSet(aaChartEntity.yAxisTitle))
    .lineWidthSet(aaChartEntity.yAxisLineWidth)
    .visibleSet(aaChartEntity.yAxisVisible)
    .tickIntervalSet(aaChartEntity.yAxisTickInterval);
    if ([aaChartEntity.yAxisCrosshairWidth floatValue]>0) {
        aaYAxis.crosshairSet(YosObject(YosCrosshair)
                             .widthSet(aaChartEntity.yAxisCrosshairWidth)
                             .colorSet(aaChartEntity.yAxisCrosshairColor)
                             .dashStyleSet(aaChartEntity.yAxisCrosshairDashStyleType)
                             );
    }
}
+ (void)configureTheStyleOfConnectNodeWithChartEntity:(YosChartEntity *)aaChartEntity plotOptions:(YosPlotOptions *)aaPlotOptions {
    if (   [aaChartEntity.chartType isEqualToString:YosChartTypeArea]
        || [aaChartEntity.chartType isEqualToString:YosChartTypeAreaspline]
        || [aaChartEntity.chartType isEqualToString:YosChartTypeLine]
        || [aaChartEntity.chartType isEqualToString:YosChartTypeSpline]) {
        YosMarker *aaMarker = YosObject(YosMarker)
        .radiusSet(aaChartEntity.markerRadius)
        .symbolSet(aaChartEntity.symbol);
        if (aaChartEntity.symbolStyle == YosChartSymbolStyleTypeInnerBlank) {
            aaMarker.fillColorSet(@"#ffffff")
            .lineWidthSet(@2)
            .lineColorSet(@"");
        } else if (aaChartEntity.symbolStyle == YosChartSymbolStyleTypeBorderBlank) {
            aaMarker.lineWidthSet(@2)
            .lineColorSet(aaChartEntity.backgroundColor);
        }
        YosSeries *aaSeries = aaPlotOptions.series;
        aaSeries.connectNulls = aaChartEntity.connectNulls;
        aaSeries.marker = aaMarker;
    }
}
+ (NSString *)configureTheEasingAnimationType:(YosChartAnimation)animationType {
    switch (animationType) {
        case YosChartAnimationLinear :
            return @"linear";
        case YosChartAnimationEaseInQuad:
            return @"easeInQuad";
        case YosChartAnimationEaseOutQuad:
            return @"easeOutQuad";
        case YosChartAnimationEaseInOutQuad:
            return @"easeInOutQuad";
        case YosChartAnimationEaseInCubic:
            return @"easeInCubic";
        case YosChartAnimationEaseOutCubic:
            return @"easeOutCubic";
        case YosChartAnimationEaseInOutCubic:
            return @"easeInOutCubic";
        case YosChartAnimationEaseInQuart:
            return @"easeInQuart";
        case YosChartAnimationEaseOutQuart:
            return @"easeOutQuart";
        case YosChartAnimationEaseInOutQuart:
            return @"easeInOutQuart";
        case YosChartAnimationEaseInQuint:
            return @"easeInQuint";
        case YosChartAnimationEaseOutQuint:
            return @"easeOutQuint";
        case YosChartAnimationEaseInOutQuint:
            return @"easeInOutQuint";
        case YosChartAnimationEaseInSine:
            return @"easeInSine";
        case YosChartAnimationEaseOutSine:
            return @"easeOutSine";
        case YosChartAnimationEaseInOutSine:
            return @"easeInOutSine";
        case YosChartAnimationEaseInExpo:
            return @"easeInExpo";
        case YosChartAnimationEaseOutExpo:
            return @"easeOutExpo";
        case YosChartAnimationEaseInOutExpo:
            return @"easeInOutExpo";
        case YosChartAnimationEaseInCirc:
            return @"easeInCirc";
        case YosChartAnimationEaseOutCirc:
            return @"easeOutCirc";
        case YosChartAnimationEaseInOutCirc:
            return @"easeInOutCirc";
        case YosChartAnimationEaseOutBounce:
            return @"easeOutBounce";
        case YosChartAnimationEaseInBack:
            return @"easeInBack";
        case YosChartAnimationEaseOutBack:
            return @"easeOutBack";
        case YosChartAnimationEaseInOutBack:
            return @"easeInOutBack";
        case YosChartAnimationElastic:
            return @"elastic";
        case YosChartAnimationSwingFromTo:
            return @"swingFromTo";
        case YosChartAnimationSwingFrom:
            return @"swingFrom";
        case YosChartAnimationSwingTo:
            return @"swingTo";
        case YosChartAnimationBounce:
            return @"bounce";
        case YosChartAnimationBouncePast:
            return @"bouncePast";
        case YosChartAnimationEaseFromTo:
            return @"easeFromTo";
        case YosChartAnimationEaseFrom:
            return @"easeFrom";
        case YosChartAnimationEaseTo:
            return @"easeTo";
    };
}
+ (YosPlotOptions *)configureTheYosPlotOptionsWithPlotOptions:(YosPlotOptions *)aaPlotOptions chartEntity:(YosChartEntity *)aaChartEntity {
    YosChartType chartType = aaChartEntity.chartType;
    YosDataLabels *aaDataLabels = (YosObject(YosDataLabels)
                                  .enabledSet(aaChartEntity.dataLabelEnabled)
                                  .styleSet(YosObject(YosStyle)
                                            .colorSet(aaChartEntity.dataLabelFontColor)
                                            .fontSizeSet(YosFontSizeFormat(aaChartEntity.dataLabelFontSize))
                                            .fontWeightSet(aaChartEntity.dataLabelFontWeight)
                                            )
                                  .rotationSet(aaChartEntity.dataLabelRotation)
                                  .allowOverlapSet(aaChartEntity.dataLabelAllowOverlap)
                                  );
    if ([chartType isEqualToString:YosChartTypeColumn]) {
        YosColumn *aaColumn = (YosObject(YosColumn)
                              .borderWidthSet(@0)
                              .borderRadiusSet(aaChartEntity.borderRadius)
                              .dataLabelsSet(aaDataLabels));
        if (aaChartEntity.polar == YES) {
            aaColumn.pointPaddingSet(@0)
            .groupPaddingSet(@0.005);
        }
        aaPlotOptions.columnSet(aaColumn);
    } else if ([chartType isEqualToString:YosChartTypeBar]) {
        YosBar *aaBar = (YosObject(YosBar)
                        .borderWidthSet(@0)
                        .borderRadiusSet(aaChartEntity.borderRadius)
                        .dataLabelsSet(aaDataLabels));
        if (aaChartEntity.polar == YES) {
            aaBar.pointPaddingSet(@0)
            .groupPaddingSet(@0.005);
        }
        aaPlotOptions.barSet(aaBar);
    } else if ([chartType isEqualToString:YosChartTypeArea]) {
        aaPlotOptions.areaSet(YosObject(YosArea)
                              .dataLabelsSet(aaDataLabels));
    } else if ([chartType isEqualToString:YosChartTypeAreaspline]) {
        aaPlotOptions.areasplineSet(YosObject(YosAreaspline)
                                    .dataLabelsSet(aaDataLabels));
    } else if ([chartType isEqualToString:YosChartTypeLine]) {
        aaPlotOptions.lineSet(YosObject(YosLine)
                              .dataLabelsSet(aaDataLabels));
    } else if ([chartType isEqualToString:YosChartTypeSpline]) {
        aaPlotOptions.splineSet(YosObject(YosSpline)
                                .dataLabelsSet(aaDataLabels));
    } else if ([chartType isEqualToString:YosChartTypePie]) {
        aaPlotOptions.pieSet(YosObject(YosPie)
                             .allowPointSelectSet(true)
                             .cursorSet(@"pointer")
                             .showInLegendSet(true)
                             .dataLabelsSet(aaDataLabels
                                            .formatSet(@"{point.percentage:.1f}%")));
        if (aaChartEntity.options3dEnabled == true) {
            aaPlotOptions.pie.depth = aaChartEntity.options3dDepth;
        }
    } else if ([chartType isEqualToString:YosChartTypeColumnrange]) {
        NSDictionary *columnrangeDic = @{@"borderRadius":@0,
                                         @"borderWidth":@0,
                                         @"dataLabels":aaDataLabels,};
        aaPlotOptions.columnrangeSet(columnrangeDic);
    } else if ([chartType isEqualToString:YosChartTypeArearange]) {
        NSDictionary *arearangeDic = @{@"dataLabels":aaDataLabels,};
        aaPlotOptions.arearangeSet(arearangeDic);
    }
    return aaPlotOptions;
}
@end
