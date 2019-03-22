#import <Foundation/Foundation.h>
@class YosDataLabels;
@interface YosPie : NSObject
YosPropStatementAndFuncStatement(strong, YosPie, NSNumber     *, size);
YosPropStatementAndFuncStatement(assign, YosPie, BOOL,           allowPointSelect);
YosPropStatementAndFuncStatement(copy,   YosPie, NSString     *, cursor);
YosPropStatementAndFuncStatement(strong, YosPie, YosDataLabels *, dataLabels);
YosPropStatementAndFuncStatement(assign, YosPie, BOOL,           showInLegend);
YosPropStatementAndFuncStatement(assign, YosPie, NSNumber     *, startAngle);
YosPropStatementAndFuncStatement(assign, YosPie, NSNumber     *, endAngle);
YosPropStatementAndFuncStatement(strong, YosPie, NSNumber     *, depth);
@end
