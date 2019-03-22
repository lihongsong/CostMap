#import <Foundation/Foundation.h>
@interface YosTooltip : NSObject
YosPropStatementAndFuncStatement(copy,   YosTooltip, NSString *, backgroundColor);
YosPropStatementAndFuncStatement(copy,   YosTooltip, NSString *, borderColor);
YosPropStatementAndFuncStatement(strong, YosTooltip, NSNumber *, borderRadius);
YosPropStatementAndFuncStatement(strong, YosTooltip, NSNumber *, borderWidth);
YosPropStatementAndFuncStatement(strong, YosTooltip, NSDictionary *, style);
YosPropStatementAndFuncStatement(assign, YosTooltip, BOOL,       enabled);
YosPropStatementAndFuncStatement(assign, YosTooltip, BOOL,       useHTML);
YosPropStatementAndFuncStatement(copy,   YosTooltip, NSString *, formatter);
YosPropStatementAndFuncStatement(copy,   YosTooltip, NSString *, headerFormat);
YosPropStatementAndFuncStatement(copy,   YosTooltip, NSString *, pointFormat);
YosPropStatementAndFuncStatement(copy,   YosTooltip, NSString *, footerFormat);
YosPropStatementAndFuncStatement(assign, YosTooltip, NSNumber *, valueDecimals);
YosPropStatementAndFuncStatement(assign, YosTooltip, BOOL,       shared);
YosPropStatementAndFuncStatement(assign, YosTooltip, BOOL,       crosshairs);
YosPropStatementAndFuncStatement(copy,   YosTooltip, NSString *, valueSuffix);
@end
