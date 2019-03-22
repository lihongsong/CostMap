#import <Foundation/Foundation.h>
@class YosStyle;
typedef NSString * YosChartTitleAlignType;
static YosChartTitleAlignType const YosChartTitleAlignTypeLeft   = @"left";
static YosChartTitleAlignType const YosChartTitleAlignTypeCenter = @"center";
static YosChartTitleAlignType const YosChartTitleAlignTypeRight  = @"right";
typedef NSString * YosChartTitleVerticalAlignType;
static YosChartTitleVerticalAlignType const YosChartTitleVerticalAlignTypeTop    = @"top";
static YosChartTitleVerticalAlignType const YosChartTitleVerticalAlignTypeMiddle = @"middle";
static YosChartTitleVerticalAlignType const YosChartTitleVerticalAlignTypeBottom = @"bottom";
@interface YosTitle : NSObject
YosPropStatementAndFuncStatement(copy,   YosTitle, NSString *, text);
YosPropStatementAndFuncStatement(strong, YosTitle, YosStyle  *, style);
YosPropStatementAndFuncStatement(copy,   YosTitle, YosChartTitleAlignType, align);
YosPropStatementAndFuncStatement(copy,   YosTitle, YosChartTitleVerticalAlignType, verticalAlign);
YosPropStatementAndFuncStatement(strong, YosTitle, NSNumber *, y);
@end
