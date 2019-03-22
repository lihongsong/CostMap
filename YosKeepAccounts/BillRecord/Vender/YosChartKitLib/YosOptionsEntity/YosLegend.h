#import <Foundation/Foundation.h>
@class YosItemStyle;
typedef NSString *YosLegendLayoutType;
typedef NSString *YosLegendAlignType;
typedef NSString *YosLegendVerticalAlignType;
static YosLegendLayoutType const YosLegendLayoutTypeHorizontal = @"horizontal";
static YosLegendLayoutType const YosLegendLayoutTypeVertical   = @"vertical";
static YosLegendAlignType const YosLegendAlignTypeLeft   = @"left";
static YosLegendAlignType const YosLegendAlignTypeCenter = @"center";
static YosLegendAlignType const YosLegendAlignTypeRight  = @"right";
static YosLegendVerticalAlignType const YosLegendVerticalAlignTypeTop    = @"top";
static YosLegendVerticalAlignType const YosLegendVerticalAlignTypeMiddle = @"middle";
static YosLegendVerticalAlignType const YosLegendVerticalAlignTypeBottom = @"bottom";
@interface YosLegend : NSObject
YosPropStatementAndFuncStatement(copy,   YosLegend, YosLegendLayoutType,        layout);
YosPropStatementAndFuncStatement(copy,   YosLegend, YosLegendAlignType,         align);
YosPropStatementAndFuncStatement(copy,   YosLegend, YosLegendVerticalAlignType, verticalAlign);
YosPropStatementAndFuncStatement(assign, YosLegend, BOOL,          enabled);
YosPropStatementAndFuncStatement(strong, YosLegend, NSNumber    *, borderWidth);
YosPropStatementAndFuncStatement(strong, YosLegend, NSNumber    *, itemMarginTop);
YosPropStatementAndFuncStatement(strong, YosLegend, YosItemStyle *, itemStyle);
@end
