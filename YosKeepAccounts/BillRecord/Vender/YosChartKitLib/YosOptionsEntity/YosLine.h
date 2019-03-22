#import <Foundation/Foundation.h>
@class YosDataLabels;
@interface YosLine : NSObject
YosPropStatementAndFuncStatement(strong, YosLine, NSNumber     *, lineWidth);
YosPropStatementAndFuncStatement(strong, YosLine, YosDataLabels *, dataLabels);
@end
