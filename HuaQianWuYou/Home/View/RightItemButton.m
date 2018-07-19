//
//  RightItemView.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/3.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "RightItemButton.h"

@implementation RightItemButton
//设置文字位置 // 这两个方法写给系统调用的,不能自己调用
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
   // NSLog(@"___%f",contentRect.size.width);
    return CGRectMake(19.5, 0, self.frame.size.width- 14.5, self.frame.size.height);
}

//设置图片的位置
- (CGRect)imageRectForContentRect:(CGRect)bounds{
    return CGRectMake(0, (self.frame.size.height-14.5)/2, 14.5, 14.5);
}

/*
- (id)initWithFrame:(CGRect)frame{
    
    if (self) {
        self = [super initWithFrame:frame];
    }
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    //        self.titleLabel.font = [UIFont systemFontOfSize:17];
    //        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    //        [self setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
    //        [self.layer setMasksToBounds:YES];
    //        [self.layer setBorderWidth:1];
    //        self.layer.borderColor = [UIColor mainColor].CGColor;
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setUpUI];
    return self;
}

-(void)setUpUI{
    UILabel *locationLabel = [UILabel new];
    UIImageView *locationImage = [UIImageView new];
    [self addSubview:locationLabel];
    [self addSubview:locationImage];
    [locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(14.5, 14.5));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(locationImage.mas_right).mas_offset(5);
        make.right.mas_equalTo(self.mas_right);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    locationImage.image = [UIImage imageNamed:@"navbar_accurate"];
    locationLabel.text = @"精准推荐";
    locationLabel.textColor = HJHexColor(0x333333);
    locationLabel.adjustsFontSizeToFitWidth = YES;
    locationLabel.textAlignment = NSTextAlignmentRight;
    locationLabel.font = [UIFont systemFontOfSize:13];
}

*/
@end
