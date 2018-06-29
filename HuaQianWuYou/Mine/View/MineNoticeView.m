//
//  MineNoticeView.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "MineNoticeView.h"

@implementation MineNoticeView

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
        make.size.mas_equalTo(CGSizeMake(SWidth, 36.5));
        make.edges.mas_equalTo(0);
    }];

    UILabel *noticeLabel = [UILabel new];
    [bgView addSubview:noticeLabel];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView.mas_left).mas_offset(15);
        make.centerY.mas_equalTo(bgView.mas_centerY);
        make.right.mas_equalTo(bgView.mas_right).mas_offset(-15);
        make.height.mas_equalTo(16.5);
    }];
    noticeLabel.text = @"启用安全访问后，您只能通过您的指纹来打开此应用程序";
    noticeLabel.font = [UIFont systemFontOfSize:12];
    noticeLabel.textColor = HJHexColor(0x999999);

}

@end
