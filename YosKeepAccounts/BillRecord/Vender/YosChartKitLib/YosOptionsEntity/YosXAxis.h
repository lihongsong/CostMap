#import <Foundation/Foundation.h>
@class YosLabels,YosCrosshair;
@interface YosXAxis : NSObject
YosPropStatementAndFuncStatement(strong, YosXAxis, NSArray  *, categories);
YosPropStatementAndFuncStatement(assign, YosXAxis, BOOL,       reversed);
YosPropStatementAndFuncStatement(strong, YosXAxis, NSNumber *, lineWidth);
YosPropStatementAndFuncStatement(copy,   YosXAxis, NSString *, lineColor);
YosPropStatementAndFuncStatement(copy,   YosXAxis, NSString *, tickColor);
YosPropStatementAndFuncStatement(strong, YosXAxis, NSNumber *, gridLineWidth);
YosPropStatementAndFuncStatement(copy,   YosXAxis, NSString *, gridLineColor);
YosPropStatementAndFuncStatement(strong, YosXAxis, YosLabels *, labels);
YosPropStatementAndFuncStatement(assign, YosXAxis, BOOL ,      visible);
YosPropStatementAndFuncStatement(strong, YosXAxis, NSNumber *, tickInterval);
YosPropStatementAndFuncStatement(strong, YosXAxis, YosCrosshair *, crosshair); 
YosPropStatementAndFuncStatement(copy,   YosXAxis, NSString *, tickmarkPlacement);
@end
