//
//  LoginViewController.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/20.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginHeaderView.h"
#import "RegisterOrForgetPwdVC.h"
#import "LoginInfoModel.h"
#import "LoginInfoModel+Service.h"
#import "AuthPhoneNumViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)LoginHeaderView *header;
@property(nonatomic,strong)UITextField *accountTF;
@property(nonatomic,strong)UITextField *passwordTF;
@property(nonatomic,strong)UIView *accountLineView;
@property(nonatomic,strong)UIView *pwdLineView;
@property(nonatomic,strong)UIButton *loginButton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self initUi];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)initUi{
    self.header = [[LoginHeaderView alloc] initWithFrame:CGRectMake(0, 14, SWidth, 64)];
    [self.view addSubview:self.header];
    [self.view addSubview:self.accountTF];
    [self.view addSubview:self.passwordTF];
    [self.view addSubview:self.accountLineView];
    [self.view addSubview:self.pwdLineView];
    [self.view addSubview:self.loginButton];
    
    UIButton *sucureButton = [ZYZControl createButtonWithFrame:CGRectMake(SWidth - LeftSpace - 30,self.passwordTF.center.y - 15, 30, 30) target:self SEL:@selector(sucureButtonClick:) title:@""];
    [sucureButton setImage:[UIImage imageNamed:@"public_password_invisible"] forState:UIControlStateNormal];
    [sucureButton setImage:[UIImage imageNamed:@"public_password_visible"] forState:UIControlStateSelected];
    sucureButton.selected = false;
    [self.view addSubview:sucureButton];
    
    UIButton *forgetButton = [ZYZControl createButtonWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(_loginButton.frame) + LeftSpace, 70, 30) target:self SEL:@selector(forgetButtonClick) title:@"忘记密码?"];
    [forgetButton setTitleColor:[UIColor stateLittleGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:forgetButton];
    
    UIButton *registerButton = [ZYZControl createButtonWithFrame:CGRectMake(SWidth - 56 - LeftSpace, CGRectGetMaxY(_loginButton.frame) + LeftSpace, 56, 30) target:self SEL:@selector(registerButtonClick) title:@"立即注册"];
     [registerButton setTitleColor:[UIColor colorFromHexCode:@"#4A90E2"] forState:UIControlStateNormal];
    [self.view addSubview:registerButton];
    
}

- (UITextField *)accountTF{
    if (_accountTF == nil) {
        _accountTF = [ZYZControl createTextFieldFrame:CGRectMake(LeftSpace, CGRectGetMaxY(self.header.frame) + 10, SWidth - LeftSpace * 2, 50) Font:[UIFont NormalSmallTitleFont] textColor:[UIColor blackColor] leftImageName:@"" rightImageName:@"" bgImageName:@"" placeHolder:@"请输入手机号码" sucureTextEntry:false];
        _accountTF.delegate = self;
        _accountTF.clearButtonMode = UITextFieldViewModeAlways;
        _accountTF.keyboardType = UIKeyboardTypeNumberPad;
        _accountTF.hj_maxLength = 11;
    }
    return _accountTF;
}

- (UITextField *)passwordTF{
    if (_passwordTF == nil) {
        _passwordTF = [ZYZControl createTextFieldFrame:CGRectMake(LeftSpace, CGRectGetMaxY(_accountTF.frame) + 10, SWidth - LeftSpace * 2 - 30, 50) Font:[UIFont NormalSmallTitleFont] textColor:[UIColor blackColor] leftImageName:@"" rightImageName:@"" bgImageName:@"" placeHolder:@"请输入您的密码" sucureTextEntry:true];
        _passwordTF.delegate = self;
         _passwordTF.clearButtonMode = UITextFieldViewModeAlways;
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

- (UIView *)pwdLineView{
    if (_pwdLineView == nil) {
        _pwdLineView = [ZYZControl createViewWithFrame:CGRectMake(LeftSpace, CGRectGetMaxY(self.passwordTF.frame), SWidth - LeftSpace * 2, 1)];
        _pwdLineView.backgroundColor = [UIColor sepreateColor];
    }
    return _pwdLineView;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.accountTF]) {
        self.accountLineView.backgroundColor = [UIColor skinColor];
        if ([self.passwordTF.text length] > 0) {
            self.loginButton.enabled = true;
            self.loginButton.selected = true;
        }
    }else if([textField isEqual:self.passwordTF]){
        self.pwdLineView.backgroundColor = [UIColor skinColor];
        if ([self.accountTF.text length] > 0) {
                self.loginButton.enabled = true;
                self.loginButton.selected = true;
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:self.accountTF]) {
        self.accountLineView.backgroundColor = [UIColor sepreateColor];
    }else if([textField isEqual:self.passwordTF]){
        self.pwdLineView.backgroundColor = [UIColor sepreateColor];
    }
    if ([self.accountTF.text length] > 0 && [self.passwordTF.text length] > 0) {
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
        if ([self.passwordTF.text length] > 0) {
            if ([self.accountTF.text hj_isMobileNumber]) {
                [self requestLogin];
            }else{
                [self setAlert:@"手机号格式不正确"];
            }
        }else{
            [self setAlert:@"请输入密码"];
        }
    }else{
      [self setAlert:@"请输入手机号"];
    }
}

#pragma mark 忘记密码
- (void)forgetButtonClick{
//    RegisterOrForgetPwdVC *forgetVC = [[RegisterOrForgetPwdVC alloc] init];
//    forgetVC.isRegister = false;
    AuthPhoneNumViewController *authPhoneVC = [AuthPhoneNumViewController new];
    [self.navigationController pushViewController:authPhoneVC animated:true];
}

#pragma mark 立即注册
- (void)registerButtonClick{
    RegisterOrForgetPwdVC *registerVC = [[RegisterOrForgetPwdVC alloc] init];
    registerVC.isRegister = true;
     [self.navigationController pushViewController:registerVC animated:true];
}

#pragma mark 是否密码遮掩
- (void)sucureButtonClick:(UIButton *)button{
    button.selected = !button.selected;
    self.passwordTF.secureTextEntry = !button.selected;
}

- (void)setAlert:(NSString*)title{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.loginButton.enabled = true;
    }];
    [alert addAction:sureAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestLogin {
    WeakObj(self);
    if (![self.accountTF.text hj_isMobileNumber]) {
        [KeyWindow ln_showToastHUD:@"请输入正确的手机号码"];
        return;
    }
    [KeyWindow ln_showLoadingHUD];
    [LoginInfoModel requestLoginWithMobile:self.accountTF.text
                                   channel:APP_ChannelId
                                  password:self.passwordTF.text
                                Completion:^(LoginInfoModel * _Nullable result, NSError * _Nullable error) {
                                    [KeyWindow ln_hideProgressHUD];
                                    StrongObj(self);
                                    if (error) {
                                        [KeyWindow ln_showToastHUD:error.userInfo[@"msg"]];
                                        return ;
                                    }
                                    if (result){
                                        [LoginUserInfoModel cacheLoginModel:result.userInfo];
                                        [self.navigationController popViewControllerAnimated:YES];
                                    }
                                }];
}
@end
