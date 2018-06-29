//
//  UINavigationController+HJStackManager.m
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import "UINavigationController+HJStackManager.h"

@implementation UINavigationController (HJStackManager)

- (id)hj_findViewController:(NSString*)className
{
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            return viewController;
        }
    }
    
    return nil;
}

- (BOOL)hj_isOnlyContainRootViewController
{
    if (self.viewControllers &&
        self.viewControllers.count == 1) {
        return YES;
    }
    return NO;
}

- (UIViewController *)hj_rootViewController
{
    if (self.viewControllers && [self.viewControllers count] >0) {
        return [self.viewControllers firstObject];
    }
    return nil;
}

- (NSArray *)hj_popToViewControllerWithClassName:(NSString*)className animated:(BOOL)animated{
    return [self popToViewController:[self hj_findViewController:className] animated:YES];
}

- (NSArray *)hj_popToViewControllerFromIndex:(NSInteger)index animated:(BOOL)animated{
    
    NSInteger viewControllersCount = self.viewControllers.count;
    
    if (viewControllersCount > index) {
        NSInteger idx = viewControllersCount - index - 1;
        UIViewController *viewController = self.viewControllers[idx];
        return [self popToViewController:viewController animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}

- (NSArray *)hj_popToViewControllerToIndex:(NSInteger)index Animated:(BOOL)animated{
    
    NSInteger viewControllersCount = self.viewControllers.count;
    
    if ((viewControllersCount - 1) > index && index >= 0) {
        UIViewController *viewController = self.viewControllers[index];
        return [self popToViewController:viewController animated:animated];
    } else {
        return self.viewControllers;
    }
}

#pragma mark - Loan & JKLoan

- (void)hj_pushViewController:(UIViewController *)destinationController ofIndex:(NSUInteger)index afterViewController:(UIViewController *)transitionController {
    if (self.viewControllers.count <= 0) {
        return;
    }
    if (!destinationController || index < 1) {
        return;
    }
    NSMutableArray *array = self.viewControllers.mutableCopy;
    if (array.count <= index) {
        
        if (array.count == index - 1 && transitionController) {
            [array addObject:transitionController];
        }else if (array.count == index && transitionController) {
            if (array.count == 1) {
                [array addObject:transitionController];
            } else {
                [array replaceObjectAtIndex:(index - 1) withObject:transitionController];
            }
        }
        
    }else{
        [array removeObjectsInRange:NSMakeRange(index, array.count - index)];
        if (transitionController) {
            [array addObject:transitionController];
        }
    }
    [array addObject:destinationController];
    [self setViewControllers:array animated:YES];
}

- (void)replaceViewControllerAtIndex:(NSUInteger)index withController:(UIViewController *)viewController {
    if (self.viewControllers.count <= 0) {
        return;
    }
    if (!viewController) {
        return;
    }
    NSMutableArray *array = self.viewControllers.mutableCopy;
    [array replaceObjectAtIndex:index withObject:viewController];
    [self setViewControllers:array animated:YES];
}

- (void)setLastViewController:(UIViewController *)viewController atIndex:(NSUInteger)index {
    if (self.viewControllers.count <= 0) {
        return;
    }
    if (!viewController) {
        return;
    }
    NSMutableArray *array = self.viewControllers.mutableCopy;
    [array removeObjectsInRange:NSMakeRange(index, array.count - index)];
    self.viewControllers = array;
    [self pushViewController:viewController animated:YES];
}

@end
