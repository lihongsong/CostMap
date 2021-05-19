#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface CostMapChartPieScene : UIView
@property (copy, nonatomic) NSArray<CostMapOrderEntity *> *entitys;
@property (assign, nonatomic) CGFloat holeRadiusPercent;
@property (assign, nonatomic) BOOL drawHoleEnabled;
- (void)animate;
@end
NS_ASSUME_NONNULL_END
