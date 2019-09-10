#import "YosYAxis.h"
@implementation YosYAxis
YosPropSetFuncImplementation(YosYAxis, YosTitle  *, title);
YosPropSetFuncImplementation(YosYAxis, NSArray  *, plotLines);
YosPropSetFuncImplementation(YosYAxis, BOOL,       reversed);
YosPropSetFuncImplementation(YosYAxis, NSNumber *, gridLineWidth);
YosPropSetFuncImplementation(YosYAxis, NSString *, gridLineColor);
YosPropSetFuncImplementation(YosYAxis, NSString *, alternateGridColor);
YosPropSetFuncImplementation(YosYAxis, YosYAxisGridLineInterpolation, gridLineInterpolation);
YosPropSetFuncImplementation(YosYAxis, YosLabels *, labels);
YosPropSetFuncImplementation(YosYAxis, NSNumber *, lineWidth);
YosPropSetFuncImplementation(YosYAxis, NSString *, lineColor);
YosPropSetFuncImplementation(YosYAxis, BOOL,       allowDecimals); 
YosPropSetFuncImplementation(YosYAxis, NSNumber *, max); 
YosPropSetFuncImplementation(YosYAxis, NSNumber *, min); 
YosPropSetFuncImplementation(YosYAxis, NSArray  *, tickPositions);
YosPropSetFuncImplementation(YosYAxis, BOOL,       visible); 
YosPropSetFuncImplementation(YosYAxis, BOOL,       opposite);
YosPropSetFuncImplementation(YosYAxis, NSNumber *, tickInterval);
YosPropSetFuncImplementation(YosYAxis, YosCrosshair*, crosshair); 
@end
