//
//  CInvestigationResultViewController.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CInvestigationResultViewController.h"

@interface CInvestigationResultViewController ()
@property(nonatomic, strong) UIImageView *centerImageview;
@property(nonatomic, strong) UILabel *tipLabel1;
@property(nonatomic, strong) UILabel *tipLabel2;
@property(nonatomic, strong) UIButton *bottomButton;
@end

@implementation CInvestigationResultViewController

#pragma - mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma - mark UI布局

- (void)setUpUI {
    self.title = @"查询结果";

    [self.view addSubview:self.centerImageview];
    [self.view addSubview:self.tipLabel1];
    [self.view addSubview:self.tipLabel2];
    [self.view addSubview:self.bottomButton];
    [self setLelftNavigationItemWithImageName:@"public_back_01_" hidden:NO];

    WeakObj(self);
    [self.centerImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.size.mas_equalTo(CGSizeMake(180, 140));
        make.top.mas_equalTo(self.view.mas_top).mas_offset(87.5);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];

    [self.tipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.top.mas_equalTo(self.centerImageview.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(25);
    }];

    [self.tipLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.top.mas_equalTo(self.tipLabel1.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(25);
    }];

    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.top.mas_equalTo(self.tipLabel2.mas_bottom).mas_offset(60);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
}

#pragma - mark setter && getter

- (void)setResultType:(CInvestigationResultType)resultType {
    _resultType = resultType;
    switch (resultType) {
        case CInvestigationResultType_Fail: {
            self.centerImageview.image = [UIImage imageNamed:@"defaultpage_fail"];
            self.tipLabel1.text = @"查询失败";
            self.tipLabel2.text = @"您填写的内容有误，请确认后重新查询";
            [self.bottomButton setTitle:@"返回" forState:UIControlStateNormal];
        }
            break;
        case CInvestigationResultType_Success: {
            self.centerImageview.image = [UIImage imageNamed:@"defaultpage_success"];
            self.tipLabel1.text = @"查询成功";
            self.tipLabel2.text = @"您的评分报告已成功生成";
            [self.bottomButton setTitle:@"查看我的报告" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

- (UIImageView *)centerImageview {
    if (!_centerImageview) {
        _centerImageview = [UIImageView new];
        _centerImageview.image = [UIImage imageNamed:@"defaultpage_fail"];
    }
    return _centerImageview;
}

- (UILabel *)tipLabel1 {
    if (!_tipLabel1) {
        _tipLabel1 = [UILabel new];
        _tipLabel1.text = @"查询失败";
        _tipLabel1.textColor = HJHexColor(0x999999);
        _tipLabel1.font = [UIFont systemFontOfSize:18];
    }
    return _tipLabel1;
}

- (UILabel *)tipLabel2 {
    if (!_tipLabel2) {
        _tipLabel2 = [UILabel new];
        _tipLabel2.text = @"您填写的内容有误，请确认后重新查询";
        _tipLabel2.textColor = HJHexColor(0x999999);
        _tipLabel2.font = [UIFont systemFontOfSize:15];
    }
    return _tipLabel2;
}

- (UIButton *)bottomButton {
    if (!_bottomButton) {
        _bottomButton = [UIButton new];
        _bottomButton.layer.borderColor = HJHexColor(0xff601a).CGColor;
        _bottomButton.layer.borderWidth = 0.5;
        _bottomButton.layer.cornerRadius = 4;
        [_bottomButton setTitle:@"返回" forState:UIControlStateNormal];
        [_bottomButton setTitleColor:HJHexColor(0xff601a) forState:UIControlStateNormal];
        [_bottomButton addTarget:self action:@selector(bottomButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomButton;
}

#pragma - mark Events

- (void)bottomButtonAction {
    switch (self.resultType) {
        case CInvestigationResultType_Fail: {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
            break;
        case CInvestigationResultType_Success: {

        }
            break;
        default:
            break;
    }
}

@end
