#import <Foundation/Foundation.h>
@class YosStyle;
@interface YosDataLabels : NSObject
YosPropStatementAndFuncStatement(assign, YosDataLabels, BOOL      , enabled);
YosPropStatementAndFuncStatement(strong, YosDataLabels, YosStyle  *, style);
YosPropStatementAndFuncStatement(copy,   YosDataLabels, NSString *, format);
YosPropStatementAndFuncStatement(copy,   YosDataLabels, NSNumber *, rotation);
YosPropStatementAndFuncStatement(assign, YosDataLabels, BOOL      , allowOverlap);
@end
