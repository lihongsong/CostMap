//
//  UIButton+EnlableColor.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "UIButton+EnlableColor.h"
#import <objc/runtime.h>
static NSString *EnlableColor = @"EnlableColor";
static NSString *DisEnlableColor   = @"DisEnlableColor";

@implementation UIButton (EnlableColor)

- (void)setEnlableColor:(UIColor *)enlableColor{
    objc_setAssociatedObject(self, &EnlableColor, enlableColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
- (UIColor *)enlableColor{
    return objc_getAssociatedObject(self, &EnlableColor);
}

- (void)setDisEnlableColor:(UIColor *)disEnlableColor{
     objc_setAssociatedObject(self, &DisEnlableColor, disEnlableColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)disEnlableColor{
    return objc_getAssociatedObject(self, &DisEnlableColor);

}
- (void)enlableColor:(UIColor *)enlableColor disEnlableColor:(UIColor *)disEnlableColor{
    self.enlableColor = enlableColor;
    self.disEnlableColor = disEnlableColor;
    
}
- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    self.backgroundColor = enabled ? self.enlableColor : self.disEnlableColor ;
}

@end
