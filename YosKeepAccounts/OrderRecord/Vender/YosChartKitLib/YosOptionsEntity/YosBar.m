#import "YosBar.h"
@implementation YosBar
YosPropSetFuncImplementation(YosBar, NSNumber *,     pointPadding);
YosPropSetFuncImplementation(YosBar, NSNumber *,     groupPadding);
YosPropSetFuncImplementation(YosBar, NSNumber *,     borderWidth);
YosPropSetFuncImplementation(YosBar, BOOL ,          colorByPoint);
YosPropSetFuncImplementation(YosBar, YosDataLabels *, dataLabels);
YosPropSetFuncImplementation(YosBar, NSNumber *,     borderRadius);
@end
