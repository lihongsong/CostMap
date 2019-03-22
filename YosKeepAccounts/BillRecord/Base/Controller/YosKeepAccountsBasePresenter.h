#import <UIKit/UIKit.h>
#import <CFYNavigationBarTransition/CFYNavigationBarTransition.h>
@interface YosKeepAccountsBasePresenter : UIViewController
- (void)setupCustomLeftWithImage:(UIImage *)image target:(id)tar action:(SEL)act;
- (void)setupCustomRightWithImage:(UIImage *)image target:(id)tar action:(SEL)act;
- (void)setupCustomRightWithtitle:(NSString *)title attributes:(NSDictionary<NSAttributedStringKey, id> *)attrs target:(id)tar action:(SEL)act;
@end
