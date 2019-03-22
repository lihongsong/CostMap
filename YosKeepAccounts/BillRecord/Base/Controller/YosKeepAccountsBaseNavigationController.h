#import <UIKit/UIKit.h>
@class YosKeepAccountsBaseNavigationController;
@protocol YosKeepAccountsNavigationControllerShouldPopDelegate<NSObject>
@optional
- (BOOL)navigationControllerShouldPopPresenter;
@end
@interface YosKeepAccountsBaseNavigationController : UINavigationController
@end
