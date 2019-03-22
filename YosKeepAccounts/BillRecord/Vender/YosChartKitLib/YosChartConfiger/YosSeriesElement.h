#import <Foundation/Foundation.h>
@class YosMarker,YosDataLabels;
@interface YosSeriesElement : NSObject
YosPropStatementAndFuncStatement(copy,   YosSeriesElement, NSString *, type);
YosPropStatementAndFuncStatement(assign, YosSeriesElement, BOOL      , allowPointSelect);
YosPropStatementAndFuncStatement(copy,   YosSeriesElement, NSString *, name);
YosPropStatementAndFuncStatement(strong, YosSeriesElement, NSArray  *, data);
YosPropStatementAndFuncStatement(copy,   YosSeriesElement, NSString *, color);
YosPropStatementAndFuncStatement(strong, YosSeriesElement, YosMarker *, marker);
YosPropStatementAndFuncStatement(copy,   YosSeriesElement, NSString *, stacking);
YosPropStatementAndFuncStatement(copy,   YosSeriesElement, NSString *, dashStyle);
YosPropStatementAndFuncStatement(strong, YosSeriesElement, NSNumber *, threshold);
YosPropStatementAndFuncStatement(strong, YosSeriesElement, NSNumber *, lineWidth);
YosPropStatementAndFuncStatement(strong, YosSeriesElement, NSNumber *, fillColor);
YosPropStatementAndFuncStatement(strong, YosSeriesElement, NSNumber *, fillOpacity);
YosPropStatementAndFuncStatement(copy,   YosSeriesElement, NSString *, negativeColor); 
YosPropStatementAndFuncStatement(strong, YosSeriesElement, NSNumber *, borderRadius);
YosPropStatementAndFuncStatement(copy,   YosSeriesElement, NSString *, innerSize);
YosPropStatementAndFuncStatement(strong, YosSeriesElement, NSNumber *, size);
YosPropStatementAndFuncStatement(strong, YosSeriesElement, NSArray  *, keys);
YosPropStatementAndFuncStatement(strong, YosSeriesElement, NSNumber *, yAxis);
YosPropStatementAndFuncStatement(strong, YosSeriesElement, YosDataLabels*, dataLabels);
YosPropStatementAndFuncStatement(strong, YosSeriesElement, id        , step);
@end
