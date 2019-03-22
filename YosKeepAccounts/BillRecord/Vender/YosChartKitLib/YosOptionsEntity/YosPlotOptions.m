#import "YosPlotOptions.h"
@implementation YosPlotOptions
YosPropSetFuncImplementation(YosPlotOptions, YosColumn     *, column);
YosPropSetFuncImplementation(YosPlotOptions, YosLine       *, line);
YosPropSetFuncImplementation(YosPlotOptions, YosPie        *, pie);
YosPropSetFuncImplementation(YosPlotOptions, YosBar        *, bar);
YosPropSetFuncImplementation(YosPlotOptions, YosSpline     *, spline);
YosPropSetFuncImplementation(YosPlotOptions, YosSeries     *, series);
YosPropSetFuncImplementation(YosPlotOptions, YosArea       *, area);
YosPropSetFuncImplementation(YosPlotOptions, YosAreaspline *, areaspline);
YosPropSetFuncImplementation(YosPlotOptions, NSObject     *, columnrange);
YosPropSetFuncImplementation(YosPlotOptions, NSObject     *, arearange);
@end
