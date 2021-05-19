#import <UIKit/UIKit.h>
@class CostMapBaseNavigationController;
@protocol CostMapNavigationControllerShouldPopDelegate<NSObject>
@optional
- (BOOL)navigationControllerShouldPopPresenter;
@end
@interface CostMapBaseNavigationController : UINavigationController
@end
