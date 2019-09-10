#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface CostMapChartLineScene : UIView
@property (copy, nonatomic) NSArray<CostMapOrderEntity *> *entitys;
- (void)animate;
@end
NS_ASSUME_NONNULL_END
