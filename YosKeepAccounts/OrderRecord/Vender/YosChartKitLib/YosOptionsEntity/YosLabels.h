#import <Foundation/Foundation.h>
@class YosStyle;
@interface YosLabels : NSObject
YosPropStatementAndFuncStatement(assign, YosLabels, BOOL, enabled);
YosPropStatementAndFuncStatement(assign, YosLabels, NSString *, fontSize);
YosPropStatementAndFuncStatement(assign, YosLabels, NSString *, fontColor);
YosPropStatementAndFuncStatement(assign, YosLabels, NSString *, fontWeight);
YosPropStatementAndFuncStatement(strong, YosLabels, YosStyle  *, style);
YosPropStatementAndFuncStatement(strong, YosLabels, NSString *, format);
@end
