#import "YosColumn.h"
@implementation YosColumn
- (instancetype)init {
    self = [super init];
    if (self) {
        self.grouping = YES;
    }
    return self;
}
YosPropSetFuncImplementation(YosColumn, BOOL,           grouping);
YosPropSetFuncImplementation(YosColumn, NSNumber *,     pointPadding);
YosPropSetFuncImplementation(YosColumn, NSNumber *,     groupPadding);
YosPropSetFuncImplementation(YosColumn, NSNumber *,     borderWidth);
YosPropSetFuncImplementation(YosColumn, BOOL ,          colorByPoint);
YosPropSetFuncImplementation(YosColumn, YosDataLabels *, dataLabels);
YosPropSetFuncImplementation(YosColumn, NSString *,     stacking);
YosPropSetFuncImplementation(YosColumn, NSNumber *,     borderRadius);
@end
