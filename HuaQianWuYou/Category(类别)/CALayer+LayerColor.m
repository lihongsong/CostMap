//
//  CALayer+LayerColor.m
//  WitCar
//
//  Created by AsiaZhang on 16/12/23.
//  Copyright © 2016年 zhifu360. All rights reserved.
//

#import "CALayer+LayerColor.h"

@implementation CALayer (LayerColor)
//默认边框黑色,设置任意色,需要添加类别
-(void)setBorderColorWithUIColor:(UIColor*)color{
    self.borderColor = color.CGColor;
}
@end
