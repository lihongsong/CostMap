#import <Foundation/Foundation.h>
@class YosColumn,YosBar,YosLine,YosSpline,YosArea,YosAreaspline,YosPie,YosSeries;
@interface YosPlotOptions : NSObject
YosPropStatementAndFuncStatement(strong, YosPlotOptions, YosColumn     *, column);
YosPropStatementAndFuncStatement(strong, YosPlotOptions, YosLine       *, line);
YosPropStatementAndFuncStatement(strong, YosPlotOptions, YosPie        *, pie);
YosPropStatementAndFuncStatement(strong, YosPlotOptions, YosBar        *, bar);
YosPropStatementAndFuncStatement(strong, YosPlotOptions, YosSpline     *, spline);
YosPropStatementAndFuncStatement(strong, YosPlotOptions, YosSeries     *, series);
YosPropStatementAndFuncStatement(strong, YosPlotOptions, YosArea       *, area);
YosPropStatementAndFuncStatement(strong, YosPlotOptions, YosAreaspline *, areaspline);
YosPropStatementAndFuncStatement(strong, YosPlotOptions, NSObject     *, columnrange);
YosPropStatementAndFuncStatement(strong, YosPlotOptions, NSObject     *, arearange);
@end
