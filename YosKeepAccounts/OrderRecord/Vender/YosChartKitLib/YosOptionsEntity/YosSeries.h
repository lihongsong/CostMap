#import <Foundation/Foundation.h>
@class YosMarker,YosAnimation;
@interface YosSeries : NSObject
YosPropStatementAndFuncStatement(strong, YosSeries, NSNumber     *, borderRadius);
YosPropStatementAndFuncStatement(strong, YosSeries, YosMarker     *, marker);
YosPropStatementAndFuncStatement(copy,   YosSeries, NSString     *, stacking);
YosPropStatementAndFuncStatement(strong, YosSeries, YosAnimation  *, animation);
YosPropStatementAndFuncStatement(strong, YosSeries, NSArray      *, keys);
YosPropStatementAndFuncStatement(assign, YosSeries, BOOL ,          connectNulls);
YosPropStatementAndFuncStatement(strong, YosSeries, NSDictionary *, events);
@end
