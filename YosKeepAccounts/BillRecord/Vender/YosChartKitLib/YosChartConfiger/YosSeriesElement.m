#import "YosSeriesElement.h"
@implementation YosSeriesElement
YosPropSetFuncImplementation(YosSeriesElement, NSString *, type);
YosPropSetFuncImplementation(YosSeriesElement, BOOL      , allowPointSelect);
YosPropSetFuncImplementation(YosSeriesElement, NSString *, name);
YosPropSetFuncImplementation(YosSeriesElement, NSArray  *, data);
YosPropSetFuncImplementation(YosSeriesElement, NSString *, color);
YosPropSetFuncImplementation(YosSeriesElement, YosMarker *, marker);
YosPropSetFuncImplementation(YosSeriesElement, NSString *, stacking);
YosPropSetFuncImplementation(YosSeriesElement, NSString *, dashStyle);
YosPropSetFuncImplementation(YosSeriesElement, NSNumber *, threshold);
YosPropSetFuncImplementation(YosSeriesElement, NSNumber *, lineWidth);
YosPropSetFuncImplementation(YosSeriesElement, NSNumber *, fillColor);
YosPropSetFuncImplementation(YosSeriesElement, NSNumber *, fillOpacity);
YosPropSetFuncImplementation(YosSeriesElement, NSString *, negativeColor); 
YosPropSetFuncImplementation(YosSeriesElement, NSNumber *, borderRadius);
YosPropSetFuncImplementation(YosSeriesElement, NSString *, innerSize);
YosPropSetFuncImplementation(YosSeriesElement, NSNumber *, size);
YosPropSetFuncImplementation(YosSeriesElement, NSArray  *, keys);
YosPropSetFuncImplementation(YosSeriesElement, NSNumber *, yAxis);
YosPropSetFuncImplementation(YosSeriesElement, YosDataLabels*, dataLabels);
YosPropSetFuncImplementation(YosSeriesElement, id        , step);
@end
