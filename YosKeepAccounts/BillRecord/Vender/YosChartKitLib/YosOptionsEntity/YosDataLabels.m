#import "YosDataLabels.h"
@implementation YosDataLabels
YosPropSetFuncImplementation(YosDataLabels, BOOL      , enabled);
YosPropSetFuncImplementation(YosDataLabels, YosStyle  *, style);
YosPropSetFuncImplementation(YosDataLabels, NSString *, format);
YosPropSetFuncImplementation(YosDataLabels, NSNumber *, rotation);
YosPropSetFuncImplementation(YosDataLabels, BOOL      , allowOverlap);
@end
