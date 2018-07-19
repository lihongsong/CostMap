//
//  LoginHeaderView.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/20.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "LoginHeaderView.h"

@implementation LoginHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI:frame];
    }
    return self;
}

- (void)setUpUI:(CGRect)frame {
    UIImageView *bgImage = [UIImageView new];
    bgImage.frame = CGRectMake((frame.size.width - 125)/2.0, 14, 125, 50);
    bgImage.image = [UIImage imageNamed:@"login_slogan"];
    [self addSubview:bgImage];
}

@end
