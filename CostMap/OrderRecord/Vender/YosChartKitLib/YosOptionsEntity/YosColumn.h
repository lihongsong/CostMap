#import <Foundation/Foundation.h>
@class YosDataLabels;
@interface YosColumn : NSObject
YosPropStatementAndFuncStatement(assign, YosColumn, BOOL,           grouping);
YosPropStatementAndFuncStatement(strong, YosColumn, NSNumber *,     pointPadding);
YosPropStatementAndFuncStatement(strong, YosColumn, NSNumber *,     groupPadding);
YosPropStatementAndFuncStatement(strong, YosColumn, NSNumber *,     borderWidth);
YosPropStatementAndFuncStatement(assign, YosColumn, BOOL,           colorByPoint);
YosPropStatementAndFuncStatement(strong, YosColumn, YosDataLabels *, dataLabels);
YosPropStatementAndFuncStatement(copy,   YosColumn, NSString *,     stacking);
YosPropStatementAndFuncStatement(strong, YosColumn, NSNumber *,     borderRadius);
@end
