#import "YosChartEntity.h"
YosChartType const YosChartTypeColumn      = @"column";
YosChartType const YosChartTypeBar         = @"bar";
YosChartType const YosChartTypeArea        = @"area";
YosChartType const YosChartTypeAreaspline  = @"areaspline";
YosChartType const YosChartTypeLine        = @"line";
YosChartType const YosChartTypeSpline      = @"spline";
YosChartType const YosChartTypeScatter     = @"scatter";
YosChartType const YosChartTypePie         = @"pie";
YosChartType const YosChartTypeBubble      = @"bubble";
YosChartType const YosChartTypePyramid     = @"pyramid";
YosChartType const YosChartTypeFunnel      = @"funnel";
YosChartType const YosChartTypeColumnrange = @"columnrange";
YosChartType const YosChartTypeArearange   = @"arearange";
YosChartType const YosChartTypeBoxplot     = @"boxplot";
YosChartType const YosChartTypeWaterfall   = @"waterfall";
YosChartSubtitleAlignType const YosChartSubtitleAlignTypeLeft   = @"left";
YosChartSubtitleAlignType const YosChartSubtitleAlignTypeCenter = @"center";
YosChartSubtitleAlignType const YosChartSubtitleAlignTypeRight  = @"right";
YosChartZoomType const YosChartZoomTypeNone = @"none";
YosChartZoomType const YosChartZoomTypeX    = @"x";
YosChartZoomType const YosChartZoomTypeY    = @"y";
YosChartZoomType const YosChartZoomTypeXY   = @"xy";
YosChartStackingType const YosChartStackingTypeFalse   = @"";
YosChartStackingType const YosChartStackingTypeNormal  = @"normal";
YosChartStackingType const YosChartStackingTypePercent = @"percent";
YosChartSymbolType const YosChartSymbolTypeCircle        = @"circle";
YosChartSymbolType const YosChartSymbolTypeSquare        = @"square";
YosChartSymbolType const YosChartSymbolTypeDiamond       = @"diamond";
YosChartSymbolType const YosChartSymbolTypeTriangle      = @"triangle";
YosChartSymbolType const YosChartSymbolTypeTriangle_down = @"triangle-down";
YosChartSymbolStyleType const YosChartSymbolStyleTypeDefault     = @"default";
YosChartSymbolStyleType const YosChartSymbolStyleTypeInnerBlank  = @"innerBlank";
YosChartSymbolStyleType const YosChartSymbolStyleTypeBorderBlank = @"borderBlank";
YosChartFontWeightType const YosChartFontWeightTypeThin     = @"thin";
YosChartFontWeightType const YosChartFontWeightTypeRegular  = @"regular";
YosChartFontWeightType const YosChartFontWeightTypeBold     = @"bold";
YosLineDashSyleType const YosLineDashSyleTypeSolid           = @"Solid";
YosLineDashSyleType const YosLineDashSyleTypeShortDash       = @"ShortDash";
YosLineDashSyleType const YosLineDashSyleTypeShortDot        = @"ShortDot";
YosLineDashSyleType const YosLineDashSyleTypeShortDashDot    = @"ShortDashDot";
YosLineDashSyleType const YosLineDashSyleTypeShortDashDotDot = @"ShortDashDotDot";
YosLineDashSyleType const YosLineDashSyleTypeDot             = @"Dot";
YosLineDashSyleType const YosLineDashSyleTypeDash            = @"Dash";
YosLineDashSyleType const YosLineDashSyleTypeLongDash        = @"LongDash";
YosLineDashSyleType const YosLineDashSyleTypeDashDot         = @"DashDot";
YosLineDashSyleType const YosLineDashSyleTypeLongDashDot     = @"LongDashDot";
YosLineDashSyleType const YosLineDashSyleTypeLongDashDotDot  = @"LongDashDotDot";
@implementation YosChartEntity
- (instancetype)init {
    self = [super init];
    if (self) {
        self.chartType              = YosChartTypeColumn;
        self.animationType          = YosChartAnimationLinear;
        self.animationDuration      = @800;
        self.subtitleAlign          = YosChartSubtitleAlignTypeLeft;
        self.stacking               = YosChartStackingTypeFalse;
        self.zoomType               = YosChartZoomTypeNone ;
        self.colorsTheme            = @[@"#9b43b4",@"#ef476f",@"#ffd066",@"#04d69f",@"#25547c",];
        self.tooltipEnabled         = YES;
        self.xAxisLabelsEnabled     = YES;
        self.xAxisGridLineWidth     = @0; 
        self.xAxisTickInterval      = @1; 
        self.xAxisVisible           = YES;
        self.yAxisVisible           = YES;
        self.yAxisLabelsEnabled     = YES;
        self.yAxisLineWidth         = @0.5; 
        self.yAxisGridLineWidth     = @1; 
        self.legendEnabled          = YES;
        self.borderRadius           = @0; 
        self.markerRadius           = @5; 
        self.yAxisAllowDecimals     = YES;
        self.zoomResetButtonText    = @"Restore zoom";
        self.titleFontColor         = @"#000000";
        self.titleFontWeight        = YosChartFontWeightTypeRegular;
        self.titleFontSize          = @11;
        self.subtitleFontColor      = @"#000000";
        self.subtitleFontWeight     = YosChartFontWeightTypeRegular;
        self.subtitleFontSize       = @9;
        self.dataLabelFontColor     = @"#000000";
        self.dataLabelFontWeight    = YosChartFontWeightTypeBold;
        self.dataLabelFontSize      = @10;
        self.xAxisLabelsFontSize    = @11;
        self.xAxisLabelsFontColor   = @"#778899";
        self.xAxisLabelsFontWeight  = YosChartFontWeightTypeThin;
        self.yAxisLabelsFontSize    = @11;
        self.yAxisLabelsFontColor   = @"#778899";
        self.yAxisLabelsFontWeight  = YosChartFontWeightTypeThin;
        self.yAxisAlternateGridColor= @"#ffffff";
    }
    return self;
}
YosPropSetFuncImplementation(YosChartEntity, NSString *, title);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, titleFontSize);
YosPropSetFuncImplementation(YosChartEntity, NSString *, titleFontWeight);
YosPropSetFuncImplementation(YosChartEntity, NSString *, titleFontColor);
YosPropSetFuncImplementation(YosChartEntity, NSString *, subtitle);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, subtitleFontSize);
YosPropSetFuncImplementation(YosChartEntity, NSString *, subtitleFontWeight);
YosPropSetFuncImplementation(YosChartEntity, NSString *, subtitleFontColor);
YosPropSetFuncImplementation(YosChartEntity, NSArray  *, series);
YosPropSetFuncImplementation(YosChartEntity, NSArray  *, keys);
YosPropSetFuncImplementation(YosChartEntity, YosChartSubtitleAlignType, subtitleAlign);
YosPropSetFuncImplementation(YosChartEntity, YosChartType,              chartType);
YosPropSetFuncImplementation(YosChartEntity, YosChartStackingType,      stacking);
YosPropSetFuncImplementation(YosChartEntity, YosChartSymbolType,        symbol);
YosPropSetFuncImplementation(YosChartEntity, YosChartSymbolStyleType,   symbolStyle);
YosPropSetFuncImplementation(YosChartEntity, YosChartZoomType,          zoomType);
YosPropSetFuncImplementation(YosChartEntity, YosChartAnimation,         animationType);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, animationDuration);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       inverted);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       xAxisReversed);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       yAxisReversed);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       gradientColorEnabled);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       polar);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       dataLabelEnabled);
YosPropSetFuncImplementation(YosChartEntity, NSString *, dataLabelFontColor);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, dataLabelFontSize);
YosPropSetFuncImplementation(YosChartEntity, NSString *, dataLabelFontWeight);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, dataLabelRotation);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       dataLabelAllowOverlap);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       xAxisLabelsEnabled);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, xAxisLabelsFontSize);
YosPropSetFuncImplementation(YosChartEntity, NSString *, xAxisLabelsFontWeight);
YosPropSetFuncImplementation(YosChartEntity, NSString *, xAxisLabelsFontColor);
YosPropSetFuncImplementation(YosChartEntity, NSArray  *, categories);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, xAxisGridLineWidth);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, xAxisTickInterval);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       xAxisVisible);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       yAxisVisible);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       yAxisLabelsEnabled);
YosPropSetFuncImplementation(YosChartEntity, NSString *, yAxisTitle);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, yAxisLineWidth);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, yAxisLabelsFontSize);
YosPropSetFuncImplementation(YosChartEntity, NSString *, yAxisLabelsFontWeight);
YosPropSetFuncImplementation(YosChartEntity, NSString *, yAxisLabelsFontColor);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, yAxisGridLineWidth);
YosPropSetFuncImplementation(YosChartEntity, NSString *, yAxisAlternateGridColor);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, yAxisTickInterval);
YosPropSetFuncImplementation(YosChartEntity, NSArray     <NSString *>*, colorsTheme);
YosPropSetFuncImplementation(YosChartEntity, NSString *, backgroundColor);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       tooltipEnabled);
YosPropSetFuncImplementation(YosChartEntity, NSString *, tooltipValueSuffix);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       connectNulls);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       legendEnabled);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       options3dEnabled);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, options3dAlpha);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, options3dBeta);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, options3dDepth);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, borderRadius);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, markerRadius);
YosPropSetFuncImplementation(YosChartEntity, BOOL,       yAxisAllowDecimals);
YosPropSetFuncImplementation(YosChartEntity, NSArray  *, yAxisPlotLines);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, yAxisMax);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, yAxisMin);
YosPropSetFuncImplementation(YosChartEntity, NSArray  *, yAxisTickPositions);
YosPropSetFuncImplementation(YosChartEntity, NSString *, zoomResetButtonText); 
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, yAxisCrosshairWidth);
YosPropSetFuncImplementation(YosChartEntity, NSString *, yAxisCrosshairColor);
YosPropSetFuncImplementation(YosChartEntity, YosLineDashSyleType,   yAxisCrosshairDashStyleType);
YosPropSetFuncImplementation(YosChartEntity, NSNumber *, xAxisCrosshairWidth);
YosPropSetFuncImplementation(YosChartEntity, NSString *, xAxisCrosshairColor);
YosPropSetFuncImplementation(YosChartEntity, YosLineDashSyleType,   xAxisCrosshairDashStyleType);
YosPropSetFuncImplementation(YosChartEntity, NSDictionary  *, additionalOptions);
@end
