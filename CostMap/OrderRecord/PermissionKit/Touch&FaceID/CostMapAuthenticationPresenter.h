#import <UIKit/UIKit.h>
@interface CostMapAuthenticationPresenter : UIViewController
@property (nonatomic,copy) void(^rootStartVC)(BOOL isCheckPass);
@end
