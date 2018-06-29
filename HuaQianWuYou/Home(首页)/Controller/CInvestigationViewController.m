//
//  CInvestigationViewController.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CInvestigationViewController.h"

//typedef void(^ConfirmBlock)(void);
//typedef void(^CancelBlock)(void);

@interface CInvestigationViewController () {
    UIView *firstTfBg;
    UIView *secondTfBg;
    UIView *thirdTfBg;
    MASConstraint *heightConstraint;
}

@end

@implementation CInvestigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.barTintColor = [UIColor skinColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont NavigationTitleFont], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)setUpUI {
    self.title = @"报告查询";
    
    UIScrollView *bgScrollView = [UIScrollView new];
    [self.view addSubview:bgScrollView];
    [bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
//    bgScrollView.contentSize = CGSizeMake(SWidth, SHeight + 10);

    [self setLelftNavigationItemWithImageName:@"public_back_01_" hidden:NO];
    UIImageView *topView = [UIImageView new];
    [bgScrollView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SWidth, 190));
        make.centerX.top.mas_equalTo(bgScrollView);
    }];
    topView.image = [UIImage imageNamed:@"c_investigation_banner"];

    firstTfBg = [UIView new];
    [bgScrollView addSubview:firstTfBg];
    [firstTfBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(bgScrollView.mas_left).mas_offset(15);
        make.right.mas_equalTo(bgScrollView.mas_right).mas_offset(-15);
        make.height.mas_equalTo(48);
    }];

    [firstTfBg addSubview:self.firstTF];
    firstTfBg.backgroundColor = HJHexColor(0xffffff);
    firstTfBg.layer.cornerRadius = 4;
    firstTfBg.layer.borderWidth = 0.5;
    firstTfBg.layer.borderColor = HJHexColor(0xe6e6e6).CGColor;
    [self.firstTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 21));
        make.left.mas_equalTo(self->firstTfBg.mas_left).mas_offset(15);
        make.right.mas_equalTo(self->firstTfBg.mas_right);
        make.centerY.mas_equalTo(self->firstTfBg.mas_centerY);
    }];

    secondTfBg = [UIView new];
    [bgScrollView addSubview:secondTfBg];
    secondTfBg.backgroundColor = HJHexColor(0xffffff);
    secondTfBg.layer.cornerRadius = 4;
    secondTfBg.layer.borderWidth = 0.5;
    secondTfBg.layer.borderColor = HJHexColor(0xe6e6e6).CGColor;
    [secondTfBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.height.mas_equalTo(self->firstTfBg);
        make.top.mas_equalTo(self->firstTfBg.mas_bottom).mas_offset(10);
    }];

    [secondTfBg addSubview:self.secondTF];
    [self.secondTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 21));
        make.left.mas_equalTo(self->secondTfBg.mas_left).mas_offset(15);
        make.right.mas_equalTo(self->secondTfBg.mas_right);
        make.centerY.mas_equalTo(self->secondTfBg.mas_centerY);
    }];

    UIView *thirdTfBg = [UIView new];
    [bgScrollView addSubview:thirdTfBg];
    thirdTfBg.backgroundColor = HJHexColor(0xffffff);
    thirdTfBg.layer.cornerRadius = 4;
    thirdTfBg.layer.borderWidth = 0.5;
    thirdTfBg.layer.borderColor = HJHexColor(0xe6e6e6).CGColor;
    [thirdTfBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self->firstTfBg);
        heightConstraint = make.height.mas_equalTo(0);
        make.top.mas_equalTo(self->secondTfBg.mas_bottom).mas_offset(10);
    }];

    [thirdTfBg addSubview:self.thirdTF];
    [self.thirdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(thirdTfBg).mas_offset(15);
        make.right.bottom.mas_equalTo(thirdTfBg).mas_offset(-15);
    }];

    [bgScrollView addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(thirdTfBg.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(bgScrollView);
        make.left.mas_equalTo(bgScrollView.mas_left).mas_offset(15);
        make.right.mas_equalTo(bgScrollView.mas_right).mas_offset(-15);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(bgScrollView.mas_bottom).mas_offset (-50);
    }];

    [self.bottomBtn setTitle:@"下一步" forState:UIControlStateNormal];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id) [UIColor colorWithRed:255 / 255.0 green:96 / 255.0 blue:26 / 255.0 alpha:1].CGColor, (__bridge id) [UIColor colorWithRed:255 / 255.0 green:143 / 255.0 blue:0 alpha:1].CGColor];
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, 0, SWidth - 30, 50);
    gradientLayer.cornerRadius = 4;
    [self.bottomBtn.layer addSublayer:gradientLayer];
    [self.bottomBtn addTarget:self action:@selector(bottomButtonAction) forControlEvents:UIControlEventTouchUpInside];

}

- (void)setAlert:(NSString*)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        self.loginButton.enabled = true;
    }];
    [alert addAction:confirAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)bottomButtonAction {
}

- (void)showThridTF {
    // [self->thirdTfBg mas_updateConstraints:^(MASConstraintMaker *make) {
    //     make.height.mas_equalTo(0);
    //}];
    heightConstraint.mas_equalTo(48);
    [heightConstraint install];
//    [self->thirdTfBg layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITextField *)firstTF {
    if (!_firstTF) {
        _firstTF = [UITextField new];
    }
    return _firstTF;
}

- (UITextField *)secondTF {
    if (!_secondTF) {
        _secondTF = [UITextField new];
    }
    return _secondTF;
}

- (UITextField *)thirdTF {
    if (!_thirdTF) {
        _thirdTF = [UITextField new];
    }
    return _thirdTF;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [UIButton new];
    }
    return _bottomBtn;
}

- (CInvestigationRequestModel *)requestModel {
    if (!_requestModel) {
        _requestModel = [CInvestigationRequestModel new];
    }
    return _requestModel;
}

@end
