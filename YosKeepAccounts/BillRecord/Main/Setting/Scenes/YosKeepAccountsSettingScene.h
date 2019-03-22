#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void (^YosKeepAccountsSettingSceneGotoVC)(UIViewController *);
@interface YosKeepAccountsSettingScene : UIView
+ (void)showSettingSceneOnSuperPresenter:(UIViewController *)superVC gotoVCHandler:(YosKeepAccountsSettingSceneGotoVC)gotoVC;
@property (nonatomic, copy, nullable) YosKeepAccountsSettingSceneGotoVC gotoSceneContoller;
@property (nonatomic, weak) UIViewController *superPresenter;
@end
NS_ASSUME_NONNULL_END
