#import <Foundation/Foundation.h>
@class YosTitle,YosLabels,YosCrosshair;
typedef NSString *YosYAxisGridLineInterpolation;
static YosYAxisGridLineInterpolation const YosYAxisGridLineInterpolationCircle  = @"circle";
static YosYAxisGridLineInterpolation const YosYAxisGridLineInterpolationPolygon = @"polygon";
@interface YosYAxis : NSObject
YosPropStatementAndFuncStatement(strong, YosYAxis, YosTitle  *, title);
YosPropStatementAndFuncStatement(strong, YosYAxis, NSArray  *, plotLines);
YosPropStatementAndFuncStatement(assign, YosYAxis, BOOL,       reversed);
YosPropStatementAndFuncStatement(strong, YosYAxis, NSNumber *, gridLineWidth);
YosPropStatementAndFuncStatement(copy,   YosYAxis, NSString *, gridLineColor);
YosPropStatementAndFuncStatement(copy,   YosYAxis, NSString *, alternateGridColor);
YosPropStatementAndFuncStatement(copy,   YosYAxis, YosYAxisGridLineInterpolation, gridLineInterpolation);
YosPropStatementAndFuncStatement(strong, YosYAxis, YosLabels *, labels);
YosPropStatementAndFuncStatement(strong, YosYAxis, NSNumber *, lineWidth);
YosPropStatementAndFuncStatement(copy,   YosYAxis, NSString *, lineColor);
YosPropStatementAndFuncStatement(assign, YosYAxis, BOOL,       allowDecimals); 
YosPropStatementAndFuncStatement(assign, YosYAxis, NSNumber *, max); 
YosPropStatementAndFuncStatement(assign, YosYAxis, NSNumber *, min); 
YosPropStatementAndFuncStatement(strong, YosYAxis, NSArray  *, tickPositions);
YosPropStatementAndFuncStatement(assign, YosYAxis, BOOL,       visible); 
YosPropStatementAndFuncStatement(assign, YosYAxis, BOOL,       opposite);
YosPropStatementAndFuncStatement(strong, YosYAxis, NSNumber *, tickInterval);
YosPropStatementAndFuncStatement(strong, YosYAxis, YosCrosshair*, crosshair); 
@end
