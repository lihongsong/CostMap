//
//  Debug.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/4.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "DebugSegmentedControl.h"
#import "UtilitiesDefine.h"

@implementation DebugSegmentedControl

- (instancetype)initWithItems:(NSArray *)items{
    self = [super initWithItems:items];
    if (self) {
        self.backgroundColor = [UIColor testNormalColor];
        //    默认为no，不设置则下面一句无效
        self.layer.masksToBounds = YES;
        
        //    设置圆角大小，同UIView
        self.layer.cornerRadius = 8;
        
        //    边框宽度，重新画边框，若不重新画，可能会出现圆角处无边框的情况
        self.layer.borderWidth = 1.5;
        
        self.layer.borderColor = [UIColor blackColor].CGColor; // 边框颜色
        
        self.frame = CGRectMake(SWidth/2.0 - 135, 20, 270, 40);
        
        self.selectedSegmentIndex = 0;
        
        self.tintColor = [UIColor testSelectColor];
        
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}forState:UIControlStateSelected];
        
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1],NSFontAttributeName:[UIFont normalFont]}forState:UIControlStateNormal];
        
        // 设置字体大小
        UIFont *font = [UIFont NormalSmallTitleFont];
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        
        [self setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
    return self;
}
@end
