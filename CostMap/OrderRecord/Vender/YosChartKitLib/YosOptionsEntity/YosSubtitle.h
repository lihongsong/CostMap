#import <Foundation/Foundation.h>
@class YosStyle;
@interface YosSubtitle : NSObject
YosPropStatementAndFuncStatement(copy,   YosSubtitle, NSString *, text);
YosPropStatementAndFuncStatement(copy,   YosSubtitle, NSString *, align);
YosPropStatementAndFuncStatement(strong, YosSubtitle, YosStyle  *, style);
@end
