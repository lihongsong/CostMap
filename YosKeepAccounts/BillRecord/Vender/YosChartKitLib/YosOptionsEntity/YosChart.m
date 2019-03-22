#import "YosChart.h"
@implementation YosChart
YosPropSetFuncImplementation(YosChart, NSString    *, type);
YosPropSetFuncImplementation(YosChart, NSString    *, backgroundColor);
YosPropSetFuncImplementation(YosChart, NSString    *, pinchType);
YosPropSetFuncImplementation(YosChart, BOOL ,         panning);
YosPropSetFuncImplementation(YosChart, BOOL ,         polar);
YosPropSetFuncImplementation(YosChart, YosOptions3d *, options3d);
YosPropSetFuncImplementation(YosChart, YosAnimation *, animation);
YosPropSetFuncImplementation(YosChart, BOOL ,         inverted);
YosPropSetFuncImplementation(YosChart, NSNumber    *, marginLeft);
YosPropSetFuncImplementation(YosChart, NSNumber    *, marginRight);
@end
