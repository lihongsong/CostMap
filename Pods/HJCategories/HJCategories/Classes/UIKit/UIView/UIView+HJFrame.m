//
//  UIView+HJFrame.m
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import "UIView+HJFrame.h"

@implementation UIView (HJFrame)

#pragma mark - GET
- (CGFloat)hj_x{
    return self.frame.origin.x;
}

- (CGFloat)hj_y{
    return self.frame.origin.y;
}

- (CGSize)hj_size{
    return self.frame.size;
}

- (CGFloat)hj_width{
    return self.frame.size.width;
}

- (CGFloat)hj_height{
    return self.frame.size.height;
}

- (CGPoint)hj_origin{
    return self.frame.origin;
}

- (CGFloat)hj_centerX{
    return self.center.x;
}

- (CGFloat)hj_centerY{
    return self.center.y;
}

#pragma mark - SET
- (void)setHj_x:(CGFloat)hj_x{
    CGRect temp = self.frame;
    temp.origin.x = hj_x;
    self.frame = temp;
}

- (void)setHj_y:(CGFloat)hj_y{
    CGRect temp = self.frame;
    temp.origin.y = hj_y;
    self.frame = temp;
}

- (void)setHj_size:(CGSize)hj_size{
    CGRect temp = self.frame;
    temp.size = hj_size;
    self.frame = temp;
}

- (void)setHj_width:(CGFloat)hj_width{
    CGRect temp = self.frame;
    temp.size.width = hj_width;
    self.frame = temp;
}

- (void)setHj_height:(CGFloat)hj_height{
    CGRect temp = self.frame;
    temp.size.height = hj_height;
    self.frame = temp;
}

- (void)setHj_origin:(CGPoint)hj_origin{
    CGRect temp = self.frame;
    temp.origin = hj_origin;
    self.frame = temp;
}

- (void)setHj_centerX:(CGFloat)hj_centerX{
    CGPoint temp = self.center;
    temp.x = hj_centerX;
    self.center = temp;
}

- (void)setHj_centerY:(CGFloat)hj_centerY{
    CGPoint temp = self.center;
    temp.y = hj_centerY;
    self.center = temp;
    
}

@end
