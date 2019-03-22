#import <Foundation/Foundation.h>
#import <UIKit/UIKitDefines.h>
#import "YosSeriesElement.h"
#import "YosPlotLinesElement.h"
typedef NS_ENUM(NSInteger,YosChartAnimation) {
    YosChartAnimationLinear = 0,
    YosChartAnimationEaseInQuad,
    YosChartAnimationEaseOutQuad,
    YosChartAnimationEaseInOutQuad,
    YosChartAnimationEaseInCubic,
    YosChartAnimationEaseOutCubic,
    YosChartAnimationEaseInOutCubic,
    YosChartAnimationEaseInQuart,
    YosChartAnimationEaseOutQuart,
    YosChartAnimationEaseInOutQuart,
    YosChartAnimationEaseInQuint,
    YosChartAnimationEaseOutQuint,
    YosChartAnimationEaseInOutQuint,
    YosChartAnimationEaseInSine,
    YosChartAnimationEaseOutSine,
    YosChartAnimationEaseInOutSine,
    YosChartAnimationEaseInExpo,
    YosChartAnimationEaseOutExpo,
    YosChartAnimationEaseInOutExpo,
    YosChartAnimationEaseInCirc,
    YosChartAnimationEaseOutCirc,
    YosChartAnimationEaseInOutCirc,
    YosChartAnimationEaseOutBounce,
    YosChartAnimationEaseInBack,
    YosChartAnimationEaseOutBack,
    YosChartAnimationEaseInOutBack,
    YosChartAnimationElastic,
    YosChartAnimationSwingFromTo,
    YosChartAnimationSwingFrom,
    YosChartAnimationSwingTo,
    YosChartAnimationBounce,
    YosChartAnimationBouncePast,
    YosChartAnimationEaseFromTo,
    YosChartAnimationEaseFrom,
    YosChartAnimationEaseTo,
};
typedef NSString *YosChartType;
typedef NSString *YosChartSubtitleAlignType;
typedef NSString *YosChartZoomType;
typedef NSString *YosChartStackingType;
typedef NSString *YosChartSymbolType;
typedef NSString *YosChartSymbolStyleType;
typedef NSString *YosChartFontWeightType;
typedef NSString *YosLineDashSyleType;
UIKIT_EXTERN YosChartType const YosChartTypeStrange;
UIKIT_EXTERN YosChartType const YosChartTypeColumn;
UIKIT_EXTERN YosChartType const YosChartTypeBar;
UIKIT_EXTERN YosChartType const YosChartTypeArea;
UIKIT_EXTERN YosChartType const YosChartTypeAreaspline;
UIKIT_EXTERN YosChartType const YosChartTypeLine;
UIKIT_EXTERN YosChartType const YosChartTypeSpline;
UIKIT_EXTERN YosChartType const YosChartTypeScatter;
UIKIT_EXTERN YosChartType const YosChartTypePie;
UIKIT_EXTERN YosChartType const YosChartTypeBubble;
UIKIT_EXTERN YosChartType const YosChartTypePyramid;
UIKIT_EXTERN YosChartType const YosChartTypeFunnel;
UIKIT_EXTERN YosChartType const YosChartTypeColumnrange;
UIKIT_EXTERN YosChartType const YosChartTypeArearange;
UIKIT_EXTERN YosChartType const YosChartTypeBoxplot;
UIKIT_EXTERN YosChartType const YosChartTypeWaterfall;
UIKIT_EXTERN YosChartSubtitleAlignType const YosChartSubtitleAlignTypeLeft;
UIKIT_EXTERN YosChartSubtitleAlignType const YosChartSubtitleAlignTypeCenter;
UIKIT_EXTERN YosChartSubtitleAlignType const YosChartSubtitleAlignTypeRight;
UIKIT_EXTERN YosChartZoomType const YosChartZoomTypeNone;
UIKIT_EXTERN YosChartZoomType const YosChartZoomTypeX;
UIKIT_EXTERN YosChartZoomType const YosChartZoomTypeY;
UIKIT_EXTERN YosChartZoomType const YosChartZoomTypeXY;
UIKIT_EXTERN YosChartStackingType const YosChartStackingTypeFalse;
UIKIT_EXTERN YosChartStackingType const YosChartStackingTypeNormal;
UIKIT_EXTERN YosChartStackingType const YosChartStackingTypePercent;
UIKIT_EXTERN YosChartSymbolType const YosChartSymbolTypeCircle;
UIKIT_EXTERN YosChartSymbolType const YosChartSymbolTypeSquare;
UIKIT_EXTERN YosChartSymbolType const YosChartSymbolTypeDiamond;
UIKIT_EXTERN YosChartSymbolType const YosChartSymbolTypeTriangle;
UIKIT_EXTERN YosChartSymbolType const YosChartSymbolTypeTriangle_down;
UIKIT_EXTERN YosChartSymbolStyleType const YosChartSymbolStyleTypeDefault;
UIKIT_EXTERN YosChartSymbolStyleType const YosChartSymbolStyleTypeInnerBlank;
UIKIT_EXTERN YosChartSymbolStyleType const YosChartSymbolStyleTypeBorderBlank;
UIKIT_EXTERN YosChartFontWeightType const YosChartFontWeightTypeThin;
UIKIT_EXTERN YosChartFontWeightType const YosChartFontWeightTypeRegular;
UIKIT_EXTERN YosChartFontWeightType const YosChartFontWeightTypeBold;
UIKIT_EXTERN YosLineDashSyleType const YosLineDashSyleTypeSolid;
UIKIT_EXTERN YosLineDashSyleType const YosLineDashSyleTypeShortDash;
UIKIT_EXTERN YosLineDashSyleType const YosLineDashSyleTypeShortDot;
UIKIT_EXTERN YosLineDashSyleType const YosLineDashSyleTypeShortDashDot;
UIKIT_EXTERN YosLineDashSyleType const YosLineDashSyleTypeShortDashDotDot;
UIKIT_EXTERN YosLineDashSyleType const YosLineDashSyleTypeDot;
UIKIT_EXTERN YosLineDashSyleType const YosLineDashSyleTypeDash;
UIKIT_EXTERN YosLineDashSyleType const YosLineDashSyleTypeLongDash;
UIKIT_EXTERN YosLineDashSyleType const YosLineDashSyleTypeDashDot;
UIKIT_EXTERN YosLineDashSyleType const YosLineDashSyleTypeLongDashDot;
UIKIT_EXTERN YosLineDashSyleType const YosLineDashSyleTypeLongDashDotDot;
@interface YosChartEntity : NSObject
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, title);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, titleFontSize);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, titleFontColor);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, titleFontWeight);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, subtitle);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, subtitleFontSize);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, subtitleFontColor);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, subtitleFontWeight);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSArray  *, series);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSArray *,  keys);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, YosChartSubtitleAlignType, subtitleAlign);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, YosChartType,              chartType);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, YosChartStackingType,      stacking);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, YosChartSymbolType,        symbol);
YosPropStatementAndFuncStatement(assign, YosChartEntity, YosChartSymbolStyleType,   symbolStyle);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, YosChartZoomType,          zoomType);
YosPropStatementAndFuncStatement(assign, YosChartEntity, YosChartAnimation,         animationType);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, animationDuration);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       inverted);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       xAxisReversed);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       yAxisReversed);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       gradientColorEnabled);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       polar);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       dataLabelEnabled);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, dataLabelFontColor);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, dataLabelFontSize);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, dataLabelFontWeight);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSNumber *, dataLabelRotation);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       dataLabelAllowOverlap);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       xAxisLabelsEnabled);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSNumber *, xAxisLabelsFontSize);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, xAxisLabelsFontColor);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, xAxisLabelsFontWeight);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSArray  *, categories);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, xAxisGridLineWidth);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, xAxisTickInterval);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       xAxisVisible);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       yAxisVisible);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       yAxisLabelsEnabled);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, yAxisTitle);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, yAxisLineWidth);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, yAxisLabelsFontSize);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, yAxisLabelsFontColor);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, yAxisLabelsFontWeight);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, yAxisGridLineWidth);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, yAxisAlternateGridColor);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, yAxisTickInterval);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSArray     <NSString *>*, colorsTheme);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, backgroundColor);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       tooltipEnabled);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, tooltipValueSuffix);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       connectNulls);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       legendEnabled);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       options3dEnabled);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, options3dAlpha);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, options3dBeta);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, options3dDepth);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, borderRadius);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, markerRadius);
YosPropStatementAndFuncStatement(assign, YosChartEntity, BOOL,       yAxisAllowDecimals);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSArray  *, yAxisPlotLines);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, yAxisMax);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, yAxisMin);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSArray  *, yAxisTickPositions);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, zoomResetButtonText); 
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, yAxisCrosshairWidth);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, yAxisCrosshairColor);
YosPropStatementAndFuncStatement(assign, YosChartEntity, YosLineDashSyleType,   yAxisCrosshairDashStyleType);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSNumber *, xAxisCrosshairWidth);
YosPropStatementAndFuncStatement(copy,   YosChartEntity, NSString *, xAxisCrosshairColor);
YosPropStatementAndFuncStatement(assign, YosChartEntity, YosLineDashSyleType,   xAxisCrosshairDashStyleType);
YosPropStatementAndFuncStatement(strong, YosChartEntity, NSDictionary  *, additionalOptions);
@end
