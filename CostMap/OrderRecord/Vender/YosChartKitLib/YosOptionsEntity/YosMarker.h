#import <Foundation/Foundation.h>
@interface YosMarker : NSObject
YosPropStatementAndFuncStatement(strong, YosMarker, NSNumber *, radius);
YosPropStatementAndFuncStatement(copy,   YosMarker, NSString *, symbol);
YosPropStatementAndFuncStatement(copy,   YosMarker, NSString *, fillColor);
YosPropStatementAndFuncStatement(strong, YosMarker, NSNumber *, lineWidth);
YosPropStatementAndFuncStatement(copy,   YosMarker, NSString *, lineColor);
@end
