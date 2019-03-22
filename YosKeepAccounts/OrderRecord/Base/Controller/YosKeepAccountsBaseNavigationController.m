#import "YosKeepAccountsBaseNavigationController.h"
#import <AddressBookUI/AddressBookUI.h>
#import <CFYNavigationBarTransition/CFYNavigationBarTransition.h>
@interface UINavigationController (UINavigationControllerNeedShouldPopItem) <UINavigationBarDelegate>
@end
@implementation UINavigationController (UINavigationControllerNeedShouldPopItem)
@end
@interface YosKeepAccountsBaseNavigationController () <UINavigationBarDelegate, UIGestureRecognizerDelegate>
@end
@implementation YosKeepAccountsBaseNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : HJHexColor(k0x444444)}];
    [self.navigationBar setTintColor:HJHexColor(k0x444444)];
    [self.navigationBar setBarTintColor:HJHexColor(k0xffffff)];
    [self.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"nav_btn_back_default"]];
    [self.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"nav_btn_back_default"]];
    [self.navigationBar setTranslucent:YES];
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage hj_imageWithColor:[UIColor clearColor]]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : HJHexColor(k0x444444) } forState:UIControlStateNormal];
    if (IOS_VERSION_9_OR_ABOVE) {
        [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[ABPeoplePickerNavigationController class], [UIImagePickerController class]]] setBarTintColor:HJHexColor(k0x444444)];
    }else{
       [[UINavigationBar appearanceWhenContainedIn:[ABPeoplePickerNavigationController class], [UIImagePickerController class], nil] setBarTintColor:HJHexColor(k0x444444)];
    }
    self.interactivePopGestureRecognizer.delegate = self;
    [self closeCFYNavigationBarFunction:NO];
}
#pragma mark - overwrite
- (void)pushPresenter:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed =(self.childViewControllers.count > 0)?YES:NO;
    [super pushViewController:viewController animated:animated];
}
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated{
    if (viewControllers.count>1) {
        viewControllers[1].hidesBottomBarWhenPushed = YES;
    }
    [super setViewControllers:viewControllers animated:animated];
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count > 1) {
            if ([self.topViewController conformsToProtocol:@protocol(YosKeepAccountsNavigationControllerShouldPopDelegate)]) {
                if ([self.topViewController respondsToSelector:@selector(navigationControllerShouldPopPresenter)]) {
                    return [(id<YosKeepAccountsNavigationControllerShouldPopDelegate>)self.topViewController navigationControllerShouldPopPresenter];
                }
            }
            return YES;
        }
        return NO;
    }
    return YES;
}
#pragma mark - UINavigationBarDelegate
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    if (item != self.topViewController.navigationItem) {
        return [super navigationBar:navigationBar shouldPopItem:item];
    }
    if ([self.topViewController conformsToProtocol:@protocol(YosKeepAccountsNavigationControllerShouldPopDelegate)]) {
        if ([self.topViewController respondsToSelector:@selector(navigationControllerShouldPopPresenter)]) {
            if (![(id<YosKeepAccountsNavigationControllerShouldPopDelegate>)self.topViewController navigationControllerShouldPopPresenter]) {
                return NO;
            }
        }
    }
    return [super navigationBar:navigationBar shouldPopItem:item];
}
@end
