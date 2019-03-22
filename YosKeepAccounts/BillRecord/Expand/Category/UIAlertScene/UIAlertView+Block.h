#import <UIKit/UIKit.h>
typedef void(^UIAlertViewCallBackBlock)(NSInteger buttonIndex);
@interface UIAlertView (Block)<UIAlertViewDelegate>
@property (strong, nonatomic) UIAlertViewCallBackBlock alertSceneCallBackBlock;
+ (void)alertWithCallBackBlock:(UIAlertViewCallBackBlock)alertSceneCallBackBlock title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;
@end
