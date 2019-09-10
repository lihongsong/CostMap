#import "YosLegend.h"
@implementation YosLegend
YosPropSetFuncImplementation(YosLegend, YosLegendLayoutType,        layout);
YosPropSetFuncImplementation(YosLegend, YosLegendAlignType,         align);
YosPropSetFuncImplementation(YosLegend, YosLegendVerticalAlignType, verticalAlign);
YosPropSetFuncImplementation(YosLegend, BOOL,          enabled);
YosPropSetFuncImplementation(YosLegend, NSNumber    *, borderWidth);
YosPropSetFuncImplementation(YosLegend, NSNumber    *, itemMarginTop);
YosPropSetFuncImplementation(YosLegend, YosItemStyle *, itemStyle);
@end
