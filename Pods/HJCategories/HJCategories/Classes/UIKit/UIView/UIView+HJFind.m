//
//  UIView+HJFind.m
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import "UIView+HJFind.h"

@implementation UIView (HJFind)

- (UIView *)hj_subViewClass:(Class)_class{
    
    if ([self isMemberOfClass:_class]) {
        return self;
    }
    
    for (UIView *v in self.subviews) {
        UIView *fv = [v hj_subViewClass:_class];
        if (fv) {
            return fv;
        }
    }
    return nil;
}

- (BOOL)hj_resignFirstResponder{
    
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        return YES;
    }
    
    for (UIView *v in self.subviews) {
        if ([v hj_resignFirstResponder]) {
            return YES;
        }
    }
    
    return NO;
}

- (UIView *)hj_superViewClass:(Class)_class{
    
    if (self == nil) {
        return nil;
    } else if (self.superview == nil) {
        return nil;
    } else if ([self.superview isKindOfClass:_class]) {
        return self.superview;
    } else {
        return [self.superview hj_superViewClass:_class];
    }
}

- (UIView *)hj_firstResponder{
    
    if (([self isKindOfClass:[UITextField class]] || [self isKindOfClass:[UITextView class]])
        && (self.isFirstResponder)) {
        return self;
    }
    
    for (UIView *v in self.subviews) {
        UIView *fv = [v hj_firstResponder];
        if (fv) {
            return fv;
        }
    }

    return nil;
}

- (UIViewController *)hj_viewController{
    
    UIResponder *responder = self.nextResponder;
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    } while (responder);
    
    return nil;
}

@end
