#import <UIKit/UIKit.h>
#import "YosKeepAccountsBillTool.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^YosKeepAccountsEditBillToolBarSelectedTime)(NSDate * _Nullable billTime);
typedef void(^YosKeepAccountsEditBillToolBarSelectedClassify)(YosKeepAccountsBillType billType);
@interface YosKeepAccountsEditBillToolBar : UIView
+ (void)showEditBillToolBarOnSuperVC:(UIViewController *)superVC
                            billType:(YosKeepAccountsBillType)billType
                            billTime:(NSDate *)billTime
                 selectedTimeHandler:(YosKeepAccountsEditBillToolBarSelectedTime)selectedTimeHandler
             selectedClassifyHandler:(YosKeepAccountsEditBillToolBarSelectedClassify)selectedClassifyHandler;
+ (void)hideEditBillToolBar;
@end
NS_ASSUME_NONNULL_END
