#import <Foundation/Foundation.h>
@class YosDataLabels;
@interface YosBar : NSObject
YosPropStatementAndFuncStatement(strong, YosBar, NSNumber *,     pointPadding);
YosPropStatementAndFuncStatement(strong, YosBar, NSNumber *,     groupPadding);
YosPropStatementAndFuncStatement(strong, YosBar, NSNumber *,     borderWidth);
YosPropStatementAndFuncStatement(assign, YosBar, BOOL,           colorByPoint);
YosPropStatementAndFuncStatement(strong, YosBar, YosDataLabels *, dataLabels);
YosPropStatementAndFuncStatement(strong, YosBar, NSNumber *,     borderRadius);
@end
