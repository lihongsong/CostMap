#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface YosKeepAccountsChartLineScene : UIView
@property (copy, nonatomic) NSArray<YosKeepAccountsOrderEntity *> *entitys;
- (void)animate;
@end
NS_ASSUME_NONNULL_END
