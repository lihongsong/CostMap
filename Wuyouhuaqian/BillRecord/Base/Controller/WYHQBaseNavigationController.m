//
//  WYHQBaseNavigationController.m
//  JiKeLoan
//
//  Created by AndyMu on 16/12/27.
//  Copyright © 2016年 JiKeLoan. All rights reserved.
//

#import "WYHQBaseNavigationController.h"

#import <AddressBookUI/AddressBookUI.h>
#import <CFYNavigationBarTransition/CFYNavigationBarTransition.h>

@interface UINavigationController (UINavigationControllerNeedShouldPopItem) <UINavigationBarDelegate>
@end

@implementation UINavigationController (UINavigationControllerNeedShouldPopItem)
@end

@interface WYHQBaseNavigationController () <UINavigationBarDelegate, UIGestureRecognizerDelegate>

@end

@implementation WYHQBaseNavigationController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //  Do any additional setup after loading the view.
    //  Setting the UIApplication's statusBarStyle
    //  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    //Setting the UINavigationBar's title
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : HJHexColor(k0x444444)}];

    //behaves as described for the tintColor property added to UIView
    [self.navigationBar setTintColor:HJHexColor(k0x444444)];

    //Setting the UINavigationBar's background
    [self.navigationBar setBarTintColor:HJHexColor(k0xffffff)];

    //Setting the UINavigationBar's back indicator image
    //These properties must both be set if you want to customize the back indicator image
    [self.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"nav_btn_back_default"]];
    [self.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"nav_btn_back_default"]];

    //New behavior on iOS 7. Default is YES.
    [self.navigationBar setTranslucent:YES];

    //Setting the UINavigationBar's backgroundImag
    //if the default background image is used, the default shadow image will be used
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage hj_imageWithColor:[UIColor clearColor]]];

    //Setting the UIBarButtonItem's title
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : HJHexColor(k0x444444) } forState:UIControlStateNormal];

    //Setting the UINavigationBar's background when ContainedIn...
    if (IOS_VERSION_9_OR_ABOVE) {
        [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[ABPeoplePickerNavigationController class], [UIImagePickerController class]]] setBarTintColor:HJHexColor(k0x444444)];
    }else{
       [[UINavigationBar appearanceWhenContainedIn:[ABPeoplePickerNavigationController class], [UIImagePickerController class], nil] setBarTintColor:HJHexColor(k0x444444)];
    }
    
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - overwrite

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

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {

    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count > 1) {
            if ([self.topViewController conformsToProtocol:@protocol(WYHQNavigationControllerShouldPopDelegate)]) {
                if ([self.topViewController respondsToSelector:@selector(navigationControllerShouldPopViewController)]) {
                    return [(id<WYHQNavigationControllerShouldPopDelegate>)self.topViewController navigationControllerShouldPopViewController];
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

    if ([self.topViewController conformsToProtocol:@protocol(WYHQNavigationControllerShouldPopDelegate)]) {
        if ([self.topViewController respondsToSelector:@selector(navigationControllerShouldPopViewController)]) {
            if (![(id<WYHQNavigationControllerShouldPopDelegate>)self.topViewController navigationControllerShouldPopViewController]) {
                return NO;
            }
        }
    }
    return [super navigationBar:navigationBar shouldPopItem:item];
}

@end
