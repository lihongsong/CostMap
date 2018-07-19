//
//  CInvestigationFourViewController.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CInvestigationFourViewController.h"
#import "UIButton+HJCountDown.h"
#import "CInvestigationProgressViewController.h"
#import "CInvestigationResultViewController.h"
#import "LoginInfoModel.h"
#import "CInvestigationProgressViewController.h"
#import "HQWYSMSModel.h"
#import "HQWYSMSModel+Service.h"
#import "CInvestigationResultViewController.h"
#import "CInvestigationModel.h"
#import "CInvestigationModel+Service.h"

@interface CInvestigationFourViewController () {
    BOOL isDisabled;
    UIButton *commitBtn;
}
@property(nonatomic, strong) UITextField *dynamicCodeTF;
@property(nonatomic, strong) UIButton *smsBtn;

@end

@implementation CInvestigationFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor skinColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont NavigationTitleFont], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpUI {
    self.title = @"报告查询";
    [self setLelftNavigationItemWithImageName:@"public_back_01_" hidden:NO];
    UIImageView *topView = [UIImageView new];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SWidth, 190));
        make.centerX.top.mas_equalTo(self.view);
    }];
    topView.image = [UIImage imageNamed:@"c_investigation_banner"];

    UILabel *tipLabel = [UILabel new];
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
        make.top.mas_equalTo(topView.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(31);
    }];
    LoginUserInfoModel *userInfo = [LoginUserInfoModel cachedLoginModel];
    tipLabel.text = [NSString stringWithFormat:@"请填写 %@ 收到的短信验证码",[self getDesensitizedPhoneNumber:userInfo.mobile]];
    tipLabel.adjustsFontSizeToFitWidth = YES;

    UIView *bgView = [UIView new];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(tipLabel);
        make.top.mas_equalTo(tipLabel.mas_bottom).mas_offset(25);
        make.height.mas_equalTo(48);
    }];
    bgView.backgroundColor = HJHexColor(0xffffff);
    bgView.layer.borderWidth = 0.5;
    bgView.layer.borderColor = HJHexColor(0xe6e6e6).CGColor;

    self.smsBtn = [UIButton new];
    [bgView addSubview:self.smsBtn];

    [bgView addSubview:self.dynamicCodeTF];
    [self.dynamicCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView.mas_left).mas_offset(15);
        make.height.mas_equalTo(21);
        make.centerY.mas_equalTo(bgView.mas_centerY);
        make.right.mas_equalTo(self.smsBtn.mas_left).mas_offset(-10);
    }];

    [self.smsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 30));
        make.centerY.mas_equalTo(bgView.mas_centerY);
        make.right.mas_equalTo(bgView.mas_right).mas_offset(-15);
    }];
    self.smsBtn.layer.borderColor = HJHexColor(0x999999).CGColor;
    self.smsBtn.layer.borderWidth = 0.5;
    self.smsBtn.layer.cornerRadius = 4;
    [self.smsBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.smsBtn setTitleColor:HJHexColor(0x999999) forState:UIControlStateNormal];
    self.smsBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.smsBtn addTarget:self action:@selector(smsButtonAction) forControlEvents:UIControlEventTouchUpInside];
    commitBtn = [UIButton new];
    [self.view addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
        make.height.mas_equalTo(50);
    }];
    commitBtn.layer.cornerRadius = 4;
    [commitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [commitBtn setBackgroundColor:[UIColor lightGrayColor]];
    [commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];

}


- (void)smsButtonAction {
    [KeyWindow ln_showLoadingHUDCommon];
    WeakObj(self);
    LoginUserInfoModel *userModel = [LoginUserInfoModel cachedLoginModel];
    [HQWYSMSModel requestSMSCodeWithMobile:userModel.mobile Completion:^(id  _Nullable result, NSError * _Nullable error) {
        StrongObj(self);
        [KeyWindow ln_hideProgressHUD];
        if (error) {
            [KeyWindow ln_showToastHUD:error.userInfo[@"msg"]];
            return ;
        }
        if (result) {
            [KeyWindow ln_showToastHUD:@"发送成功"];
            if (!self->isDisabled) {
                self->isDisabled = YES;
                WeakObj(self);
                [self.smsBtn hj_startTime:60
                                    title:@"获取验证码"
                           waitTitleBlock:^NSAttributedString *(NSInteger timeIndex) {
                               NSString *string = [NSString stringWithFormat:@"%ldS 重新获取", (long) timeIndex];
                               return [[NSAttributedString alloc] initWithString:string
                                                                      attributes:@{NSForegroundColorAttributeName: HJHexColor(0x999999)}];
                           } enableTitleColor:HJHexColor(0x999999)
                        disableTitleColor:[UIColor whiteColor]
                          enableBackColor:[UIColor whiteColor]
                         disableBackColor:[UIColor whiteColor]
                                blockTime:1
                               completion:^{
                                   StrongObj(self);
                                   if (self) {
                                       self->isDisabled = NO;
                                   }
                               }];
            }
        }
    }];
}

- (void)commitBtnAction {
    if (StrIsEmpty(self.dynamicCodeTF.text)) {
        [self setAlert:@"请输入验证码"];
        return;
    }
    if (self.dynamicCodeTF.text.length != 6) {
      [self setAlert:@"请输入正确的验证码"];
      return;
    }
    self.requestModel.smsCode = self.dynamicCodeTF.text;
    [self requestData];
}

- (void)requestData {
    [KeyWindow ln_showLoadingHUDCommon];
    [CInvestigationModel requestCInvestigationWithAccumulationFundAccount:self.requestModel.accumulationFundAccount
                                                      accumulationFundPWD:self.requestModel.accumulationFundPWD
                                                                   iDCard:self.requestModel.iDCard
                                                                     name:self.requestModel.name
                                                              phoneNumber:self.requestModel.phoneNumber
                                                                  smsCode:self.requestModel.smsCode
                                                          servicePassword:self.requestModel.servicePassword
                                                               Completion:^(CInvestigationModel *_Nullable result, NSError *_Nullable error) {
                                                                   [KeyWindow ln_hideProgressHUD];
                                                                   if (error) {
                                                                       [KeyWindow ln_showToastHUD:error.userInfo[@"msg"]];
                                                                       return;
                                                                   }
                                                                   if (result) {
                                                                       CInvestigationProgressViewController *vc = [CInvestigationProgressViewController new];
                                                                       vc.accomplishBlock = ^{
                                                                           [self commit];
                                                                       };
                                                                       [self presentViewController:vc animated:YES completion:nil];
                                                                   }
                                                               }];
}

- (void)commit {
    CInvestigationResultViewController *resultVC = [CInvestigationResultViewController new];
    resultVC.resultType =CInvestigationResultType_Fail;
    [self.navigationController pushViewController:resultVC animated:YES];
}


- (UITextField *)dynamicCodeTF {
    if (!_dynamicCodeTF) {
        _dynamicCodeTF = [UITextField new];
        _dynamicCodeTF.placeholder = @"请输入验证码";
        _dynamicCodeTF.keyboardType = UIKeyboardTypeNumberPad;
        _dynamicCodeTF.hj_maxLength = 6;
        _dynamicCodeTF.delegate = (id<UITextFieldDelegate>)self;
    }
    return _dynamicCodeTF;
}

- (UIButton *)smsBtn {
    if (!_smsBtn) {
        _smsBtn = [UIButton new];

    }
    return _smsBtn;
}

- (NSString *)getDesensitizedPhoneNumber:(NSString *)phoneNumString {
    if (phoneNumString.length != 11) return phoneNumString;
    NSString *desensitizedString = [phoneNumString stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return desensitizedString;
}

- (void)setAlert:(NSString*)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:confirAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  if (!StrIsEmpty(self.dynamicCodeTF.text)) {
    [self setBottomButtonEnable];
  } else {
    [commitBtn setBackgroundColor:[UIColor lightGrayColor]];
  }

}
- (void)setBottomButtonEnable {
  commitBtn.enabled = YES;
  [commitBtn setTitle:@"下一步" forState:UIControlStateNormal];
  [commitBtn setBackgroundImage:[UIImage imageNamed:@"home_btn_pop"] forState:UIControlStateNormal];
  [commitBtn setBackgroundImage:[UIImage imageNamed:@"home_btn_pop"] forState:UIControlStateHighlighted];
  [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
