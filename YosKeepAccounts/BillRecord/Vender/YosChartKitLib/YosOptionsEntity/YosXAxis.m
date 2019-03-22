#import "YosXAxis.h"
@implementation YosXAxis
YosPropSetFuncImplementation(YosXAxis, NSArray  *, categories);
YosPropSetFuncImplementation(YosXAxis, BOOL ,      reversed);
YosPropSetFuncImplementation(YosXAxis, NSNumber *, lineWidth);
YosPropSetFuncImplementation(YosXAxis, NSString *, lineColor);
YosPropSetFuncImplementation(YosXAxis, NSString *, tickColor);
YosPropSetFuncImplementation(YosXAxis, NSNumber *, gridLineWidth);
YosPropSetFuncImplementation(YosXAxis, NSString *, gridLineColor);
YosPropSetFuncImplementation(YosXAxis, YosLabels *, labels);
YosPropSetFuncImplementation(YosXAxis, BOOL ,      visible);
YosPropSetFuncImplementation(YosXAxis, NSNumber *, tickInterval);
YosPropSetFuncImplementation(YosXAxis, YosCrosshair*, crosshair); 
YosPropSetFuncImplementation(YosXAxis, NSString *, tickmarkPlacement);
@end
