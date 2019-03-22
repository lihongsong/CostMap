#import <UIKit/UIKit.h>
#import "YosOptions.h"
@protocol YosChartSceneDidFinishLoadDelegate<NSObject>
- (void)YosChartSceneDidFinishLoad;
@end
@interface YosChartScene:UIView
@property (nonatomic, weak)   id<YosChartSceneDidFinishLoadDelegate> delegate;
@property (nonatomic, assign) BOOL scrollEnabled;
@property (nonatomic, assign) CGFloat  contentWidth;
@property (nonatomic, assign) CGFloat  contentHeight;
@property (nonatomic, assign) BOOL chartSeriesHidden;
@property (nonatomic, assign) BOOL isClearBackgroundColor;
@property (nonatomic, assign) BOOL blurEffectEnabled;
- (void)yos_method_drawChartWithChartEntity:(YosChartEntity *)chartEntity;
- (void)yos_method_onlyRefreshTheChartDataWithChartEntitySeries:(NSArray<NSDictionary *> *)series;
- (void)yos_method_refreshChartWithChartEntity:(YosChartEntity *)chartEntity;
- (void)yos_method_drawChartWithOptions:(YosOptions *)options;
- (void)yos_method_onlyRefreshTheChartDataWithOptionsSeries:(NSArray<NSDictionary *> *)series;
- (void)yos_method_refreshChartWithOptions:(YosOptions *)options;
- (void)yos_method_showTheSeriesElementContentWithSeriesElementIndex:(NSInteger)elementIndex;
- (void)yos_method_hideTheSeriesElementContentWithSeriesElementIndex:(NSInteger)elementIndex;
@end
@interface YosJsonConverter : NSObject
+ (NSString *)getPureOptionsString:(id)optionsObject;
+ (NSString *)getPureSeriesString:(NSArray<NSDictionary*> *)series;
@end
