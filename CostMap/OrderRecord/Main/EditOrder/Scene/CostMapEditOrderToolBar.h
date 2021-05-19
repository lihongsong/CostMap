#import <UIKit/UIKit.h>
#import "CostMapOrderTool.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CostMapEditOrderToolBarSelectedTime)(NSDate * _Nullable orderTime);
typedef void(^CostMapEditOrderToolBarSelectedClassify)(CostMapOrderType orderType);
@interface CostMapEditOrderToolBar : UIView
+ (void)showEditOrderToolBarOnSuperVC:(UIViewController *)superVC
                            orderType:(CostMapOrderType)orderType
                            orderTime:(NSDate *)orderTime
                 selectedTimeHandler:(CostMapEditOrderToolBarSelectedTime)selectedTimeHandler
             selectedClassifyHandler:(CostMapEditOrderToolBarSelectedClassify)selectedClassifyHandler;
+ (void)hideEditOrderToolBar;
@end
NS_ASSUME_NONNULL_END
