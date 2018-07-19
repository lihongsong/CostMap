//
//  MineFooterView.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "MineFooterView.h"

@implementation MineFooterView

- (instancetype)init {
    if (self = [super init]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    UIView *bgView = [UIView new];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    bgView.backgroundColor = HJHexColor(0xf2f2f2);

    UILabel *titleLabel = [UILabel new];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_top).mas_offset(20);
        make.left.right.bottom.mas_equalTo(bgView);
    }];
    titleLabel.backgroundColor = HJHexColor(0xffffff);
    titleLabel.textColor = HJHexColor(0xFF601A);
    titleLabel.text = @"退出登录";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logout)];
    [titleLabel addGestureRecognizer:tap];
}

- (void)logout {
    if (self.tapLogout) {
        self.tapLogout();
    }
}
@end
