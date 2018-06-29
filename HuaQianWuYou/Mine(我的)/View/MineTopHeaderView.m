//
//  MineTopHeaderView.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "MineTopHeaderView.h"
#import "LoginInfoModel.h"

@interface MineTopHeaderView ()
@property(nonatomic, strong) UIImageView *headImageView;
@property(nonatomic, strong) UIButton *loginBtn;
@property(nonatomic, strong) UILabel *loginLabel;
@end

@implementation MineTopHeaderView

- (instancetype)init {
    if (self = [super init]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    WeakObj(self);
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];

    UIImageView *bgImage = [UIImageView new];
    [bgView addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(bgView);
        make.bottom.mas_equalTo(bgView.mas_bottom).mas_offset(-10);
    }];
    bgImage.image = [UIImage imageNamed:@"mine_head_bg"];

    [bgView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView.mas_left).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.mas_equalTo(bgView.mas_top).mas_offset(57);
    }];


    [bgView addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.left.mas_equalTo(self.headImageView.mas_right).mas_offset(15);
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.centerY.mas_equalTo(self.headImageView.mas_centerY);
    }];

    UIView *separateView = [UIView new];
    [bgView addSubview:separateView];
    [separateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SWidth, 10));
        make.top.mas_equalTo(bgImage.mas_bottom);
    }];
    separateView.backgroundColor = HJHexColor(0xF2F2F2);

    [bgView addSubview:self.loginLabel];
    [self.loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.height.mas_equalTo(24);
        make.centerY.mas_equalTo(self.headImageView.mas_centerY);
        make.left.mas_equalTo(self.headImageView.mas_right).mas_offset(15);
        make.right.mas_equalTo(bgView.mas_right);
    }];

}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [UIImageView new];
        _headImageView.layer.cornerRadius = 30;
        _headImageView.image = [UIImage imageNamed:@"mine_head_notloggedin"];
    }
    return _headImageView;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton new];
        _loginBtn.layer.cornerRadius = 15;
        [_loginBtn setTitle:@"请登录" forState:UIControlStateNormal];
        _loginBtn.layer.borderWidth = 1;
        _loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_loginBtn setImage:[UIImage imageNamed:@"public_arrow_03"] forState:UIControlStateNormal];
        [_loginBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 70, 0, 0)];
        [_loginBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 12)];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loginBtn addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UILabel *)loginLabel {
    if (!_loginLabel) {
        _loginLabel = [UILabel new];
        _loginLabel.font = [UIFont systemFontOfSize:17];
        _loginLabel.hidden = YES;
        _loginLabel.textColor = HJHexColor(0xffffff);
    }
    return _loginLabel;
}

- (void)setIsUserLogin:(BOOL)isUserLogin {
    _isUserLogin = isUserLogin;
    self.loginBtn.hidden = isUserLogin;
    self.loginLabel.hidden = !isUserLogin;
    if (isUserLogin) {
        self.headImageView.image = [UIImage imageNamed:@"mine_head_loggedin"];
        LoginUserInfoModel *userInfo = [LoginUserInfoModel cachedLoginModel];
        self.loginLabel.text = [self getDesensitizedPhoneNumber:userInfo.mobile];
    } else {
        self.headImageView.image = [UIImage imageNamed:@"mine_head_notloggedin"];
        self.loginLabel.text = @"";
    }
}

- (NSString *)getDesensitizedPhoneNumber:(NSString *)phoneNumString {
    if (phoneNumString.length != 11) return phoneNumString;
    NSString *desensitizedString = [phoneNumString stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return desensitizedString;
}

- (void)loginButtonAction {
    if (self.loginBlock) {
        self.loginBlock();
    }
}

@end
