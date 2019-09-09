#import "YosKeepAccountsBaseNavigationController.h"
#import <AddressBookUI/AddressBookUI.h>

@interface UINavigationController (UINavigationControllerNeedShouldPopItem) <UINavigationBarDelegate>
@end
@implementation UINavigationController (UINavigationControllerNeedShouldPopItem)
@end
@interface YosKeepAccountsBaseNavigationController () <UINavigationBarDelegate, UIGestureRecognizerDelegate>
@end
@implementation YosKeepAccountsBaseNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : YosKeepAccountsThemeTitleColor}];
    [self.navigationBar setTintColor:YosKeepAccountsThemeTitleColor];
    [self.navigationBar setBarTintColor:YosKeepAccountsThemeColor];
    [self.navigationBar setBackgroundColor:YosKeepAccountsThemeColor];
    [self.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"yka_navbar_back_02"]];
    [self.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"yka_navbar_back_02"]];
    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage hj_imageWithColor:[UIColor clearColor]]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : YosKeepAccountsThemeTitleColor } forState:UIControlStateNormal];
    if (IOS_VERSION_9_OR_ABOVE) {
        [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[ABPeoplePickerNavigationController class], [UIImagePickerController class]]] setBarTintColor:YosKeepAccountsThemeColor];
    }else{
       [[UINavigationBar appearanceWhenContainedIn:[ABPeoplePickerNavigationController class], [UIImagePickerController class], nil] setBarTintColor:YosKeepAccountsThemeColor];
    }
    self.interactivePopGestureRecognizer.delegate = self;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed =(self.childViewControllers.count > 0)?YES:NO;
    [super pushViewController:viewController animated:animated];
}
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated{
    if (viewControllers.count>1) {
        viewControllers[1].hidesBottomBarWhenPushed = YES;
    }
    [super setViewControllers:viewControllers animated:animated];
}
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
