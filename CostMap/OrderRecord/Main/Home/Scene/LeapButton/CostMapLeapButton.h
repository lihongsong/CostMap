#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface CostMapLeapButton : UIButton
- (void)hideOutScreen;
- (void)showInScreen;
- (void)startLeapAnimation;
- (void)stopLeapAnimation;
- (void)startShakeAnimation;
- (void)stopShakeAnimation;
@end
NS_ASSUME_NONNULL_END
