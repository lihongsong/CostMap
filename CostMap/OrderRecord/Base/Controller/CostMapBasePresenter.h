#import <UIKit/UIKit.h>
@interface CostMapBasePresenter : UIViewController
- (void)setupCustomLeftWithImage:(UIImage *)image target:(id)tar action:(SEL)act;
- (void)setupCustomRightWithImage:(UIImage *)image target:(id)tar action:(SEL)act;
- (void)setupCustomRightWithtitle:(NSString *)title attributes:(NSDictionary<NSAttributedStringKey, id> *)attrs target:(id)tar action:(SEL)act;
- (void)changeThemeColor;
@end
