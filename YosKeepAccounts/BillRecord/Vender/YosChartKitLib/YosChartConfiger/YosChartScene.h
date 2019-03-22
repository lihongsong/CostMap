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
- (void)aa_drawChartWithChartEntity:(YosChartEntity *)chartEntity;
- (void)aa_onlyRefreshTheChartDataWithChartEntitySeries:(NSArray<NSDictionary *> *)series;
- (void)aa_refreshChartWithChartEntity:(YosChartEntity *)chartEntity;
- (void)aa_drawChartWithOptions:(YosOptions *)options;
- (void)aa_onlyRefreshTheChartDataWithOptionsSeries:(NSArray<NSDictionary *> *)series;
- (void)aa_refreshChartWithOptions:(YosOptions *)options;
- (void)aa_showTheSeriesElementContentWithSeriesElementIndex:(NSInteger)elementIndex;
- (void)aa_hideTheSeriesElementContentWithSeriesElementIndex:(NSInteger)elementIndex;
@end
@interface YosJsonConverter : NSObject
+ (NSString *)getPureOptionsString:(id)optionsObject;
+ (NSString *)getPureSeriesString:(NSArray<NSDictionary*> *)series;
@end
