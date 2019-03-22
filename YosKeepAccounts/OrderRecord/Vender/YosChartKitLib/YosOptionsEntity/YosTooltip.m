#import "YosTooltip.h"
@implementation YosTooltip
YosPropSetFuncImplementation(YosTooltip, NSString *, backgroundColor);
YosPropSetFuncImplementation(YosTooltip, NSString *, borderColor);
YosPropSetFuncImplementation(YosTooltip, NSNumber *, borderRadius);
YosPropSetFuncImplementation(YosTooltip, NSNumber *, borderWidth);
YosPropSetFuncImplementation(YosTooltip, NSDictionary *, style);
YosPropSetFuncImplementation(YosTooltip, BOOL,       enabled);
YosPropSetFuncImplementation(YosTooltip, BOOL,       useHTML);
YosPropSetFuncImplementation(YosTooltip, NSString *, formatter);
YosPropSetFuncImplementation(YosTooltip, NSString *, headerFormat);
YosPropSetFuncImplementation(YosTooltip, NSString *, pointFormat);
YosPropSetFuncImplementation(YosTooltip, NSString *, footerFormat);
YosPropSetFuncImplementation(YosTooltip, NSNumber *, valueDecimals);
YosPropSetFuncImplementation(YosTooltip, BOOL,       shared);
YosPropSetFuncImplementation(YosTooltip, BOOL,       crosshairs);
YosPropSetFuncImplementation(YosTooltip, NSString *, valueSuffix);
@end
