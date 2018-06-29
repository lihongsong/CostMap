//
//  UIView+HJCarouselTool.m
//  HJCarousel
//
//  Created by yoser on 2017/12/28.
//  Copyright © 2017年 yoser. All rights reserved.
//

#import "UIView+HJCarouselTool.h"

@implementation UIView (HJCarouselTool)

- (CGFloat)hjc_x{
    return self.frame.origin.x;
}

- (CGFloat)hjc_y{
    return self.frame.origin.y;
}

- (CGFloat)hjc_width{
    return self.frame.size.width;
}

- (CGFloat)hjc_height{
    return self.frame.size.height;
}

#pragma mark - SET
- (void)setHjc_x:(CGFloat)hj_x{
    CGRect temp = self.frame;
    temp.origin.x = hj_x;
    self.frame = temp;
}

- (void)setHjc_y:(CGFloat)hj_y{
    CGRect temp = self.frame;
    temp.origin.y = hj_y;
    self.frame = temp;
}

- (void)setHjc_width:(CGFloat)hj_width{
    CGRect temp = self.frame;
    temp.size.width = hj_width;
    self.frame = temp;
}

- (void)setHjc_height:(CGFloat)hj_height{
    CGRect temp = self.frame;
    temp.size.height = hj_height;
    self.frame = temp;
}

@end
