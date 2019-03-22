#import "YosLine.h"
@implementation YosLine
-(instancetype)init{
    self = [super init];
    if (self ) {
    }
    return self;
}
YosPropSetFuncImplementation(YosLine, NSNumber     *, lineWidth);
YosPropSetFuncImplementation(YosLine, YosDataLabels *, dataLabels);
@end
