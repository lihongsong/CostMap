//
//  ZYZButton.m
//  SmartCar
//
//  Created by AsiaZhang on 16/4/28.
//  Copyright © 2016年 ZhiQiao. All rights reserved.
//

#import "ZYZButton.h"
#import "UIColor+AddColor.h"

@implementation ZYZButton
//设置文字位置 // 这两个方法写给系统调用的,不能自己调用
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    //NSLog(@"___%f",contentRect.size.width);
    return CGRectMake(0, -0.5, self.frame.size.width/2.0 + 20, self.frame.size.height);
}

//设置图片的位置
- (CGRect)imageRectForContentRect:(CGRect)bounds{
    return CGRectMake(self.frame.size.width/2.0 + 30, (self.frame.size.height-7)/2 - 0.5 , 14, 7);
}
@end
