#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface YosKeepAccountsChartPieScene : UIView
@property (copy, nonatomic) NSArray<YosKeepAccountsBillEntity *> *entitys;
@property (assign, nonatomic) CGFloat holeRadiusPercent;
@property (assign, nonatomic) BOOL drawHoleEnabled;
- (void)animate;
@end
NS_ASSUME_NONNULL_END
