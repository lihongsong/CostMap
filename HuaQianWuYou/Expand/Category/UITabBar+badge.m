//
//  UITabBar+badge.m
//  WitCar
//
//  Created by AsiaZhang on 16/12/19.
//  Copyright © 2016年 jason. All rights reserved.
//

#import "UITabBar+badge.h"
#import "ZYZControl.h"
#define TabbarItemNums 4.0    //tabbar的数量

@implementation UITabBar (badge)
- (void)showBadgeOnItemIndex:(int)index{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);
    [self addSubview:badgeView];
    
}

-(void)showNewMessage:(int)index{
    //确定iamge的位置
    CGRect tabFrame = self.frame;
    float percentX = (index + 0.35) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    UIImageView *image = [ZYZControl createImageViewFrame:CGRectMake(x, -21, 70, 23) imageName:@"tip"];
    image.tag = 895 + index;
    [self addSubview:image];
}

-(void)hideMessage:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        
        if (subView.tag == 895 + index) {
            
            [subView removeFromSuperview];
            
        }
    }
}

- (void)hideBadgeOnItemIndex:(int)index{
    
    //移除小红点
    [self removeBadgeOnItemIndex:index];
    
}

- (void)removeBadgeOnItemIndex:(int)index{
    
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        
        if (subView.tag == 888+index) {
            
            [subView removeFromSuperview];
            
        }
    }
}
@end
