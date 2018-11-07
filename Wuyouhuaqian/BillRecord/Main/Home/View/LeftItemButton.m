//
//  leftItemView.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/3.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "LeftItemButton.h"

@implementation LeftItemButton


//设置文字位置 // 这两个方法写给系统调用的,不能自己调用
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    //NSLog(@"___%f",contentRect.size.width);
    return CGRectMake(17.5, 0, self.frame.size.width - 12.5, self.frame.size.height);
}

//设置图片的位置
- (CGRect)imageRectForContentRect:(CGRect)bounds{
    return CGRectMake(0, (self.frame.size.height-16)/2, 12.5, 16);
}

/*
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setUpUI];
    return self;
}

-(void)setUpUI{
    UIImageView *locationImage = [UIImageView new];
    UIImageView *arrowImage = [UIImageView new];
    [self addSubview:self.locationButton];
    [self addSubview:arrowImage];
    [self addSubview:locationImage];
    [locationImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(12.5, 16));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(locationImage.mas_right).mas_offset(5);
        make.right.mas_equalTo(self.mas_right);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    locationImage.image = [UIImage imageNamed:@"navbar_location_02"];
    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.locationButton.mas_right).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(5, 3));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    arrowImage.image = [UIImage imageNamed:@"navbar_triangle"];
}

- (UILabel *)locationButton{
    if (_locationButton == nil) {
        _locationButton = [[UILabel alloc]init];
        _locationButton.text = @"定位中...";
        _locationButton.textColor = HJHexColor(0x333333);
        _locationButton.adjustsFontSizeToFitWidth = YES;
        _locationButton.textAlignment = NSTextAlignmentLeft;
        _locationButton.font = [UIFont systemFontOfSize:13];
    }
    return _locationButton;
}
 
 */


@end
