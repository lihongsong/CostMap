//
//  UIView+HJNormalBorder.m
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import "UIView+HJNormalBorder.h"

@implementation UIView (HJNormalBorder)

- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}

@end
