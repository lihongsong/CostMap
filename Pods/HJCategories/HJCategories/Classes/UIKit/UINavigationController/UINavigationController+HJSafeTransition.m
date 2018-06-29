//
//  UINavigationController+HJSafeTransition.m
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import "UINavigationController+HJSafeTransition.h"

#import <objc/runtime.h>

@interface UINavigationController()<UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) BOOL viewTransitionInProgress;

@end

@implementation UINavigationController (HJSafeTransition)

+ (void)load {
    
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(pushViewController:animated:)),
                                   class_getInstanceMethod(self, @selector(safePushViewController:animated:)));
    
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(popViewControllerAnimated:)),
                                   class_getInstanceMethod(self, @selector(safePopViewControllerAnimated:)));
}

- (UIViewController *)safePopViewControllerAnimated:(BOOL)animated {
    
    if (self.viewTransitionInProgress) return nil;
    
    if (animated) {
        
        self.viewTransitionInProgress = YES;
    }
    
    UIViewController *viewController = [self safePopViewControllerAnimated:animated];
    
    if (viewController == nil) {
        
        self.viewTransitionInProgress = NO;
    }
    
    return viewController;
}

- (void)safePushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewTransitionInProgress == NO) {
        
        [self safePushViewController:viewController animated:animated];
        
        if (animated) {
            
            self.viewTransitionInProgress = YES;
        }
    }
}

#pragma mark - setter & getter
- (void)setViewTransitionInProgress:(BOOL)property {
    
    NSNumber *number = [NSNumber numberWithBool:property];
    
    objc_setAssociatedObject(self, @selector(viewTransitionInProgress), number, OBJC_ASSOCIATION_RETAIN);
    
}

- (BOOL)viewTransitionInProgress {
    
    NSNumber *number = objc_getAssociatedObject(self, @selector(viewTransitionInProgress));
    
    return [number boolValue];
}

@end

@implementation UIViewController (SafeTransitionLock)

+ (void)load {
    
    Method m1;
    Method m2;
    
    m1 = class_getInstanceMethod(self, @selector(safeViewDidAppear:));
    m2 = class_getInstanceMethod(self, @selector(viewDidAppear:));
    
    method_exchangeImplementations(m1, m2);
}

- (void)safeViewDidAppear:(BOOL)animated {
    
    self.navigationController.viewTransitionInProgress = NO;
    
    [self safeViewDidAppear:animated];
}

@end
