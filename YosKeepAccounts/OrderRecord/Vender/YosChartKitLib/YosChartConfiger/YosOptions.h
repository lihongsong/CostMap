#import <Foundation/Foundation.h>
#import "YosChart.h"
#import "YosAnimation.h"
#import "YosTitle.h"
#import "YosSubtitle.h"
#import "YosXAxis.h"
#import "YosYAxis.h"
#import "YosCrosshair.h"
#import "YosLabels.h"
#import "YosTooltip.h"
#import "YosPlotOptions.h"
#import "YosColumn.h"
#import "YosBar.h"
#import "YosArea.h"
#import "YosAreaspline.h"
#import "YosLine.h"
#import "YosSpline.h"
#import "YosPie.h"
#import "YosLegend.h"
#import "YosDataLabels.h"
#import "YosStyle.h"
#import "YosSeries.h"
#import "YosMarker.h"
#import "YosOptions3d.h"
@interface YosOptions : NSObject
YosPropStatementAndFuncStatement(strong, YosOptions, YosChart       *, chart);
YosPropStatementAndFuncStatement(strong, YosOptions, YosTitle       *, title);
YosPropStatementAndFuncStatement(strong, YosOptions, YosSubtitle    *, subtitle);
YosPropStatementAndFuncStatement(strong, YosOptions, YosXAxis       *, xAxis);
YosPropStatementAndFuncStatement(strong, YosOptions, YosYAxis       *, yAxis);
YosPropStatementAndFuncStatement(strong, YosOptions, YosTooltip     *, tooltip);
YosPropStatementAndFuncStatement(strong, YosOptions, YosPlotOptions *, plotOptions);
YosPropStatementAndFuncStatement(strong, YosOptions, NSArray       *, series);
YosPropStatementAndFuncStatement(strong, YosOptions, YosLegend      *, legend);
YosPropStatementAndFuncStatement(strong, YosOptions, NSArray       *, colors);
YosPropStatementAndFuncStatement(assign, YosOptions, BOOL,            gradientColorEnabled);
YosPropStatementAndFuncStatement(copy,   YosOptions, NSString      *, zoomResetButtonText); 
@end
#import "YosChartEntity.h"
@interface YosOptionsConstructor : NSObject
+ (YosOptions *)configureChartOptionsWithYosChartEntity:(YosChartEntity *)chartEntity;
@end
