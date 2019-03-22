#import <UIKit/UIKit.h>
#import "YosKeepAccountsOrderTool.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^YosKeepAccountsEditOrderToolBarSelectedTime)(NSDate * _Nullable orderTime);
typedef void(^YosKeepAccountsEditOrderToolBarSelectedClassify)(YosKeepAccountsOrderType orderType);
@interface YosKeepAccountsEditOrderToolBar : UIView
+ (void)showEditOrderToolBarOnSuperVC:(UIViewController *)superVC
                            orderType:(YosKeepAccountsOrderType)orderType
                            orderTime:(NSDate *)orderTime
                 selectedTimeHandler:(YosKeepAccountsEditOrderToolBarSelectedTime)selectedTimeHandler
             selectedClassifyHandler:(YosKeepAccountsEditOrderToolBarSelectedClassify)selectedClassifyHandler;
+ (void)hideEditOrderToolBar;
@end
NS_ASSUME_NONNULL_END
