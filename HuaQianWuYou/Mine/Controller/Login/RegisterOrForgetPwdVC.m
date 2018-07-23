//
//  RegisterOrForgetPwdVC.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/20.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "RegisterOrForgetPwdVC.h"
#import "LoginHeaderView.h"
#import "AgreementViewController.h"
#import "LoginInfoModel.h"
#import "LoginInfoModel+Service.h"
#import<CommonCrypto/CommonDigest.h>
#import "LoginInfoModel+Service.h"
#import "ResetPasswordModel.h"
#import "ResetPasswordModel+Service.h"
#import "HQWYSMSModel.h"
#import "HQWYSMSModel+Service.h"

@interface RegisterOrForgetPwdVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *accountTF;
@property(nonatomic,strong)UITextField *passwordTF;
@property(nonatomic,strong)UITextField *smsCodeTF;
@property(nonatomic,strong)UIView *accountLineView;
@property(nonatomic,strong)UIView *codeLineView;
@property(nonatomic,strong)UIView *pwdLineView;
@property(nonatomic,strong)UIButton *loginButton;
@property(nonatomic,strong)UIButton *smsCodeButton;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger countTime;
@end

@implementation RegisterOrForgetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.countTime = 60;
    [self initUi];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    UIButton *serviceButton = (UIButton*)[self.view viewWithTag:300];
    UIButton *securityButton = (UIButton*)[self.view viewWithTag:301];
    serviceButton.enabled = true;
    securityButton.enabled = true;
}

- (void)initUi{
    LoginHeaderView *header = [[LoginHeaderView alloc] initWithFrame:CGRectMake(0, 14, SWidth, 64)];
    [self.view addSubview:header];
    [self.view addSubview:self.accountTF];
    [self.view addSubview:self.smsCodeTF];
    [self.view addSubview:self.passwordTF];
    [self.view addSubview:self.accountLineView];
    [self.view addSubview:self.pwdLineView];
    [self.view addSubview:self.smsCodeButton];
    [self.view addSubview:self.codeLineView];
    [self.view addSubview:self.loginButton];
    
}

- (void)createStatementLabel{
    NSString *valueString = @"用户注册即代表同意《服务条款》和《隐私政策》";
    UILabel *stateLabel = [ZYZControl createLabelWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(self.loginButton.frame) + 10, SWidth - 2 * LeftSpace, 30) Font:[UIFont stateFont] Text:@""];
    NSMutableAttributedString *stringM = [[NSMutableAttributedString alloc] initWithString:@"用户注册即代表同意《服务条款》和《隐私政策》"];
    NSRange range = [valueString rangeOfString:@"《服务条款》"];
    NSRange range1 =  [valueString rangeOfString:@"《隐私政策》"];
    [stringM addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"#4A90E2"] range:range];
    [stringM addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexCode:@"#4A90E2"] range:range1];
    stateLabel.attributedText = stringM;
    [self.view addSubview:stateLabel];
    
    UIButton *serviceButton = [ZYZControl createButtonWithFrame:CGRectMake(130, stateLabel.center.y - 15, 60, 30) target:self SEL:@selector(serviceButtonClick:) title:@""];
    serviceButton.tag = 300;
    [self.view addSubview:serviceButton];
    
    UIButton *securityButton = [ZYZControl createButtonWithFrame:CGRectMake(210, stateLabel.center.y - 15, 60, 30) target:self SEL:@selector(securityButtonClick:) title:@""];
    securityButton.tag = 301;
    [self.view addSubview:securityButton];
}

- (UITextField *)accountTF{
    if (_accountTF == nil) {
        _accountTF = [ZYZControl createTextFieldFrame:CGRectMake(LeftSpace,14 + 64 + 20, SWidth - LeftSpace * 2, 50) Font:[UIFont NormalSmallTitleFont] textColor:[UIColor blackColor] leftImageName:@"" rightImageName:@"" bgImageName:@"" placeHolder:@"请输入手机号码" sucureTextEntry:false];
        _accountTF.delegate = self;
        _accountTF.clearButtonMode = UITextFieldViewModeAlways;
        _accountTF.keyboardType = UIKeyboardTypeNumberPad;
        _accountTF.hj_maxLength = 11;
    }
    return _accountTF;
}

- (UITextField *)smsCodeTF{
    if (_smsCodeTF == nil) {
        _smsCodeTF = [ZYZControl createTextFieldFrame:CGRectMake(LeftSpace, CGRectGetMaxY(self.accountTF.frame) + 10, SWidth - LeftSpace * 2 - 90, 50) Font:[UIFont NormalSmallTitleFont] textColor:[UIColor blackColor] leftImageName:@"" rightImageName:@"" bgImageName:@"" placeHolder:@"请输入验证码" sucureTextEntry:false];
        _smsCodeTF.delegate = self;
        _smsCodeTF.clearButtonMode = UITextFieldViewModeAlways;
        _smsCodeTF.keyboardType = UIKeyboardTypeNumberPad;
        _smsCodeTF.hj_maxLength = 6;
    }
    return _smsCodeTF;
}

- (UITextField *)passwordTF{
    if (_passwordTF == nil) {
        _passwordTF = [ZYZControl createTextFieldFrame:CGRectMake(LeftSpace, CGRectGetMaxY(self.smsCodeTF.frame) + 10, SWidth - LeftSpace * 2, 50) Font:[UIFont NormalSmallTitleFont] textColor:[UIColor blackColor] leftImageName:@"" rightImageName:@"" bgImageName:@"" placeHolder:@"" sucureTextEntry:true];
        _passwordTF.delegate = self;
        _passwordTF.clearButtonMode = UITextFieldViewModeAlways;
        _passwordTF.keyboardType = UIKeyboardTypeASCIICapable;
    }
    return _passwordTF;
}

- (UIView *)accountLineView{
    if (_accountLineView == nil) {
        _accountLineView = [ZYZControl createViewWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(self.accountTF.frame), SWidth - LeftSpace * 2, 1)];
        _accountLineView.backgroundColor = [UIColor sepreateColor];
        
    }
    return _accountLineView;
}

- (UIButton *)loginButton{
    if (_loginButton == nil) {
        _loginButton = [ZYZControl createButtonWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(_passwordTF.frame) + 20, SWidth - LeftSpace * 2, 50) target:self SEL:@selector(loginButtonClick) title:@"登录"];
        _loginButton.titleLabel.font = [UIFont NormalSmallTitleFont];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_disabled"] forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"login_normal"] forState:UIControlStateSelected];
        _loginButton.enabled = false;
        
    }
    return _loginButton;
}

- (UIButton *)smsCodeButton{
    if (_smsCodeButton == nil) {
        _smsCodeButton = [ZYZControl createButtonWithFrame:CGRectMake(CGRectGetMaxX(_smsCodeTF.frame), _smsCodeTF.center.y - 15, 90, 30) target:self SEL:@selector(getSMSCodeButtonClick) title:@"获取验证码"];
        _smsCodeButton.titleLabel.font = [UIFont stateFont];
        [_smsCodeButton setTitleColor:[UIColor stateGrayColor] forState:UIControlStateNormal];
        _smsCodeButton.borderColor = [UIColor stateGrayColor];
        _smsCodeButton.layer.cornerRadius = 4;
        _smsCodeButton.borderWidth = 1.0f;
    }
    return _smsCodeButton;
}

- (UIView *)pwdLineView{
    if (_pwdLineView == nil) {
        _pwdLineView = [ZYZControl createViewWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(self.passwordTF.frame), SWidth - LeftSpace * 2, 1)];
        _pwdLineView.backgroundColor = [UIColor sepreateColor];
    }
    return _pwdLineView;
}

- (UIView *)codeLineView{
    if (_codeLineView == nil) {
        _codeLineView = [ZYZControl createViewWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(self.smsCodeTF.frame), SWidth - LeftSpace * 2, 1)];
        _codeLineView.backgroundColor = [UIColor sepreateColor];
        
    }
    return _codeLineView;
}

- (void)setIsRegister:(BOOL)isRegister{
    if (isRegister) {
        self.passwordTF.placeholder = @"请输入密码";
        [self createStatementLabel];
    }else{
        self.passwordTF.placeholder = @" 请设置新密码";
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.accountTF]) {
        self.accountLineView.backgroundColor = [UIColor skinColor];
        if ([self.passwordTF.text length] > 0 && [self.smsCodeTF.text length] > 0) {
            self.loginButton.enabled = true;
            self.loginButton.selected = true;
        }
    }else if([textField isEqual:self.passwordTF]){
        self.pwdLineView.backgroundColor = [UIColor skinColor];
        if ([self.accountTF.text length] > 0 && [self.smsCodeTF.text length] > 0) {
            self.loginButton.enabled = true;
            self.loginButton.selected = true;
        }
    }else if([textField isEqual:self.smsCodeTF]){
        self.codeLineView.backgroundColor = [UIColor skinColor];
        if ([self.passwordTF.text length] > 0 && [self.accountTF.text length] > 0) {
            self.loginButton.enabled = true;
            self.loginButton.selected = true;
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:self.accountTF]) {
        self.accountLineView.backgroundColor = [UIColor sepreateColor];
    }else if([textField isEqual:self.passwordTF]){
        self.pwdLineView.backgroundColor = [UIColor sepreateColor];
    }else if([textField isEqual:self.smsCodeTF]){
        self.codeLineView.backgroundColor = [UIColor sepreateColor];
    }
    
    if ([self.accountTF.text length] > 0 && [self.passwordTF.text length] > 0 && [self.smsCodeTF.text length] > 0) {
        self.loginButton.enabled = true;
        self.loginButton.selected = true;
    }else{
        self.loginButton.enabled = false;
        self.loginButton.selected = false;
    }
    
    
}

#pragma mark 登录按钮点击
- (void)loginButtonClick{
    self.loginButton.enabled = false;
    if ([self.accountTF.text length] > 0) {
        if ([self.smsCodeTF.text length] > 0) {
            if ([self.passwordTF.text length] > 0) {
                if ([self.accountTF.text hj_isMobileNumber]) {
                    [self registerAPI];
                }else{
                    [self setAlert:@"手机号格式不正确"];
                }
            }else{
                [self setAlert:@"请输入密码"];
            }
        }else{
               [self setAlert:@"请输入验证码"];
        }
    }else{
        [self setAlert:@"请输入手机号"];
    }
}

- (void)registerAPI{
    WeakObj(self);
    [KeyWindow ln_showLoadingHUDCommon];
    [LoginInfoModel requestRegisterWithMobile:self.accountTF.text
                                      smsCode:self.smsCodeTF.text
                                   Completion:^(LoginInfoModel * _Nullable result, NSError * _Nullable error) {
                                       StrongObj(self);
                                       [KeyWindow ln_hideProgressHUD];
                                       if (error) {
                                           [KeyWindow ln_showToastHUD:error.userInfo[@"msg"]];;
                                           return ;
                                       }
                                       if (result) {
                                           [LoginUserInfoModel cacheLoginModel:result.userInfo];
                                           [self updatePassword];
                                       }
                                   }];
    
}

- (void)updatePassword {
    [KeyWindow ln_showLoadingHUDCommon];
    [ResetPasswordModel requestUpdatePassword:self.passwordTF.text
                                   Completion:^(ResetPasswordModel * _Nullable result, NSError * _Nullable error) {
                                       [KeyWindow ln_hideProgressHUD];
                                       if (error) {
                                           [KeyWindow ln_showToastHUD:error.userInfo[@"msg"]];
                                           return ;
                                       }
                                       [self.navigationController popToRootViewControllerAnimated:YES];
                                   }];
}


#pragma mark 获取验证码按钮点击
- (void)getSMSCodeButtonClick{
    if ([self.accountTF.text hj_isMobileNumber]){
        [KeyWindow ln_showLoadingHUDCommon];
        WeakObj(self);
        [HQWYSMSModel requestSMSCodeWithMobile:self.accountTF.text
                                    Completion:^(id  _Nullable result, NSError * _Nullable error) {
                                        [KeyWindow ln_hideProgressHUD];
                                        StrongObj(self);
                                        if (error) {
                                            [KeyWindow ln_showToastHUD:error.userInfo[@"msg"]];
                                            return ;
                                        }
                                        if (result) {
                                            [KeyWindow ln_showToastHUD:@"发送成功"];
                                            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
                                            return ;
                                        }
                                    }];
    }else{
        [self setAlert:@"输入手机号格式不正确"];
    }
    
}


#pragma mark 服务条款
- (void)serviceButtonClick:(UIButton *)button{
    button.enabled = false;
    AgreementViewController *agreementVC = [[AgreementViewController alloc]init];
    agreementVC.title = @"服务条款";
    agreementVC.isXieYi = true;
    [self.navigationController pushViewController:agreementVC animated:true];
}

#pragma mark 隐私政策
- (void)securityButtonClick:(UIButton *)button{
    button.enabled = false;
    AgreementViewController *agreementVC = [[AgreementViewController alloc]init];
    agreementVC.title = @"隐私政策";
    agreementVC.isXieYi = false;
    [self.navigationController pushViewController:agreementVC animated:true];
}

- (void)setAlert:(NSString*)title{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.loginButton.enabled = true;
    }];
    [alert addAction:sureAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)changeTime{
    
    _countTime--;
    if (_countTime == 0) {
        _countTime = 60;
        [_timer invalidate];
        _timer = nil;
        _smsCodeButton.userInteractionEnabled = YES;
        [_smsCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _smsCodeButton.backgroundColor = [UIColor whiteColor];
        _smsCodeButton.borderWidth = 1.0;
        
    }else{
        NSString * timeString = [NSString stringWithFormat:@"%lds 重新获取",(long)_countTime];
        [_smsCodeButton setTitle:timeString forState:UIControlStateNormal];
        [_smsCodeButton setTitle:timeString forState:UIControlStateSelected];
        _smsCodeButton.backgroundColor = [UIColor sepreateColor];
        _smsCodeButton.borderWidth = 0.0;
        _smsCodeButton.userInteractionEnabled = NO;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
