//
//  UIViewController+Push.m
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/9.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "UIViewController+Push.h"
#import "objc/runtime.h"

static NSString *kAnimateRect = @"kAnimateRect";

@implementation UIViewController (WYHQPush)

- (void)setAnimateRect:(CGRect)animateRect {
    objc_setAssociatedObject(self, &kAnimateRect, [NSValue valueWithCGRect:animateRect], OBJC_ASSOCIATION_RETAIN);
}

- (CGRect)animateRect {
    return [objc_getAssociatedObject(self, &kAnimateRect) CGRectValue];
}

@end
