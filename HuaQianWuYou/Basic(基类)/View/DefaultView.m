//
//  DefaultView.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/23.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "DefaultView.h"

@interface DefaultView(){
    UIImageView *topImageView;
    UILabel *tip1Label;
    UILabel *tip2Label;
}
@end
@implementation DefaultView
- (instancetype)init {
    if (self = [super init]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    topImageView = [UIImageView new];
    [self addSubview:topImageView];
    WeakObj(self);
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).mas_offset(88);
    }];
    topImageView.image = [UIImage imageNamed:@"defaultpage_noconnection"];
    
    tip1Label = [UILabel new];
    [self addSubview:tip1Label];
    [tip1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.top.mas_equalTo(self->topImageView.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(18);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    tip1Label.textAlignment = NSTextAlignmentCenter;
    tip1Label.textColor = HJHexColor(0x999999);
    tip1Label.font = [UIFont systemFontOfSize:18];
    tip1Label.text = @"网络连接失败";
    
    tip2Label = [UILabel new];
    [self addSubview:tip2Label];
    [tip2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.top.mas_equalTo(self->tip1Label.mas_bottom).mas_offset(5);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(15);
    }];
    tip2Label.textColor = HJHexColor(0x999999);
    tip2Label.textAlignment = NSTextAlignmentCenter;
    tip2Label.font = [UIFont systemFontOfSize:15];
    tip2Label.text = @"请在此刷新或检查网络";
    
    UIButton *reloadButton = [UIButton new];
    [self addSubview:reloadButton];
    [reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(150, 40));
        make.top.mas_equalTo(self->tip2Label.mas_bottom).mas_offset(60);
    }];
    [reloadButton setTitle:@"刷新" forState:UIControlStateNormal];
    [reloadButton setTitleColor:HJHexColor(0xff601a) forState:UIControlStateNormal];
    reloadButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [reloadButton addTarget:self action:@selector(reloadButtonAction) forControlEvents:UIControlEventTouchUpInside];
    reloadButton.layer.borderWidth = 0.5;
    reloadButton.layer.borderColor = HJHexColor(0xff601a).CGColor;
    reloadButton.layer.cornerRadius = 4;
}

- (void)reloadButtonAction {
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}


@end
