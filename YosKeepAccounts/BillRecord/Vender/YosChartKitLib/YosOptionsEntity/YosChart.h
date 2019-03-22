#import <Foundation/Foundation.h>
@class YosAnimation,YosOptions3d;
@interface YosChart : NSObject
YosPropStatementAndFuncStatement(copy,   YosChart, NSString    *, type);
YosPropStatementAndFuncStatement(copy,   YosChart, NSString    *, backgroundColor);
YosPropStatementAndFuncStatement(copy,   YosChart, NSString    *, pinchType);
YosPropStatementAndFuncStatement(assign, YosChart, BOOL,          panning);
YosPropStatementAndFuncStatement(assign, YosChart, BOOL,          polar);
YosPropStatementAndFuncStatement(strong, YosChart, YosOptions3d *, options3d);
YosPropStatementAndFuncStatement(assign, YosChart, YosAnimation *, animation);
YosPropStatementAndFuncStatement(assign, YosChart, BOOL,          inverted);
YosPropStatementAndFuncStatement(strong, YosChart, NSNumber    *, marginLeft);
YosPropStatementAndFuncStatement(strong, YosChart, NSNumber    *, marginRight);
@end
