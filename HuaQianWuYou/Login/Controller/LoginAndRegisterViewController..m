//
//  LoginViewController.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/4.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "LoginAndRegisterViewController.h"
#import "SelectTheLoginModeView.h"
#import "TwoTextFieldView.h"
#import "HQWYSMSModel.h"
#import "HQWYSMSModel+Service.h"
#import "PasswordViewController.h"
#import "ChangePasswordViewController.h"
@interface LoginAndRegisterViewController ()<SelectTheLoginModeViewDelegate,UITextFieldDelegate,TwoTextFieldViewDelegate>
@property(nonatomic,strong)TwoTextFieldView *codeInputView;
@property(nonatomic,strong)TwoTextFieldView *passwordInputView;
@property(nonatomic,strong)UIButton *forgetButton;
@property(nonatomic,strong)UIButton *loginButton;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger countTime;
@end

@implementation LoginAndRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.countTime = 60;
    [self setUpUi];
}
- (void)setUpUi{
    SelectTheLoginModeView *selectHeader = [[SelectTheLoginModeView alloc]initWithFrame:CGRectMake(0, 0,SWidth, 100)];
    selectHeader.delegate = self;
    [self.view addSubview:selectHeader];
    
    [self.view addSubview:self.codeInputView];
    [self.view addSubview:self.passwordInputView];
    
    [self.view addSubview:self.forgetButton];
    [self.view addSubview:self.loginButton];
    
    UILabel *stateLabel = [ZYZControl createLabelWithFrame:CGRectMake(SWidth/2.0 - 100, CGRectGetMaxY(self.loginButton.frame) + 15, 110, 30) Font:[UIFont systemFontOfSize:13.0] Text:@"登录即代表您同意"];
    stateLabel.textColor = [UIColor stateGrayColor];
    [self.view addSubview:stateLabel];
    
    UIButton *agrementButton = [ZYZControl createButtonWithFrame:CGRectMake(CGRectGetMaxX(stateLabel.frame) - 3, stateLabel.hj_y, 107, stateLabel.hj_height) target:self SEL:@selector(agrementClick) title:@"《用户服务协议》"];
    agrementButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [agrementButton setTitleColor:[UIColor skinColor] forState:UIControlStateNormal];
    [self.view addSubview:agrementButton];
    
}

- (TwoTextFieldView *)codeInputView{
    if (!_codeInputView) {
        _codeInputView = [[TwoTextFieldView alloc]initWithFrame:CGRectMake(0, 100 + 50, SWidth, 125)];
        _codeInputView.firstTF.delegate = self;
        _codeInputView.secondTF.delegate = self;
        [_codeInputView setType:TextFieldTypeCode];
    }
    return _codeInputView;
}

- (TwoTextFieldView *)passwordInputView{
    if (!_passwordInputView) {
        _passwordInputView = [[TwoTextFieldView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.codeInputView.frame), self.codeInputView.hj_y, SWidth, 125)];;
        _passwordInputView.firstTF.delegate = self;
        _passwordInputView.secondTF.delegate = self;
        [_passwordInputView setType:TextFieldTypeCode];
    }
    return _passwordInputView;
}

- (UIButton*)forgetButton{
    if (!_forgetButton) {
        _forgetButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _forgetButton.frame = CGRectMake(SWidth - LeftSpace - 80, CGRectGetMaxY(self.codeInputView.frame) + 10, 80, 40);
        [_forgetButton addTarget:self action:@selector(forgetButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_forgetButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetButton setTitleColor:[UIColor skinColor] forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont NormalSmallTitleFont];
        _forgetButton.hidden = true;
    }
    return _forgetButton;
}

- (UIButton*)loginButton{
    if (!_loginButton) {
        _loginButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.frame = CGRectMake(LeftSpace, CGRectGetMaxY(self.forgetButton.frame) + 30, SWidth - 2 * LeftSpace, 45);
        [_loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_loginButton setBackgroundColor:[UIColor lightGrayColor]];
        _loginButton.titleLabel.font = [UIFont NormalSmallTitleFont];
        _loginButton.layer.cornerRadius = 20;
    }
    return _loginButton;
}

#pragma mark delegate 验证码登录
- (void)selectTheLoginModeCode{
    [self.codeInputView.firstTF becomeFirstResponder];
    self.codeInputView.firstLineView.backgroundColor = [UIColor skinColor];
    self.codeInputView.secondLineView.backgroundColor = [UIColor lightGrayColor];
    self.forgetButton.hidden = true;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.passwordInputView.eyeButton.hidden = true;
        self.passwordInputView.transform = CGAffineTransformIdentity;
        self.codeInputView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.codeInputView.codeButton.hidden = false;
    }];
}


#pragma mark delegate 密码登录
- (void)selectTheLoginModePassword{
    [self.passwordInputView.firstTF becomeFirstResponder];
    self.passwordInputView.firstLineView.backgroundColor = [UIColor skinColor];
    self.passwordInputView.secondLineView.backgroundColor = [UIColor lightGrayColor];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.codeInputView.codeButton.hidden = true;
        self.passwordInputView.transform = CGAffineTransformMakeTranslation(-SWidth, 0);
        self.codeInputView.transform = CGAffineTransformMakeTranslation(-SWidth, 0);
    } completion:^(BOOL finished) {
        self.passwordInputView.eyeButton.hidden = false;
        self.forgetButton.hidden = false;
    }];
    
}

#pragma mark 忘记密码
- (void)forgetButtonClick{
    ChangePasswordViewController *passWordVC = [ChangePasswordViewController instance];
    passWordVC.type = PasswordTypeCode;
    [self.navigationController pushViewController:passWordVC animated:YES];
    
}

#pragma mark 登录事件
- (void)loginButtonClick{
    self.loginButton.enabled = false;
    if (self.forgetButton.hidden) {//代表验证码登录，无忘记密码
        if ([self.codeInputView.firstTF.text length] > 0) {
            if ([self.codeInputView.secondTF.text length] > 0) {
                if ([self.codeInputView.firstTF.text hj_isMobileNumber]) {
                    [self requestLogin];
                }else{
                    [self addAlertView:@"手机号格式不正确" block:^{
                        
                    }];
                }
            }else{
                [self addAlertView:@"请输入验证码" block:^{
                    
                }];
            }
        }else{
            [self addAlertView:@"请输入手机号" block:^{
                
            }];
        }
    }else{
        if ([self.passwordInputView.firstTF.text length] > 0) {
            if ([self.passwordInputView.secondTF.text length] > 0) {
                if ([self.passwordInputView.firstTF.text hj_isMobileNumber]) {
                    [self requestLogin];
                }else{
                    [self addAlertView:@"手机号格式不正确" block:^{
                        
                    }];
                }
            }else{
                [self addAlertView:@"请输入密码" block:^{
                    
                }];
            }
        }else{
            [self addAlertView:@"请输入手机号" block:^{
                
            }];
        }
    }
    
}

#pragma mark 请求登录
- (void)requestLogin{
    
}

#pragma mark 协议点击事件
- (void)agrementClick{
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
     if (self.forgetButton.hidden) {//代表验证码登录，无忘记密码
         if ([textField isEqual:self.codeInputView.firstTF]) {
             self.codeInputView.firstLineView.backgroundColor = [UIColor skinColor];
              self.codeInputView.secondLineView.backgroundColor = [UIColor lightGrayColor];
             if ([self.codeInputView.secondTF.text length] > 0) {
                 self.loginButton.enabled = true;
                 self.loginButton.backgroundColor = [UIColor skinColor];;
             }
         }else if([textField isEqual:self.codeInputView.secondTF]){
             self.codeInputView.firstLineView.backgroundColor = [UIColor lightGrayColor];
             self.codeInputView.secondLineView.backgroundColor = [UIColor skinColor];
             if ([self.codeInputView.firstTF.text length] > 0) {
                 self.loginButton.enabled = true;
                 self.loginButton.backgroundColor = [UIColor skinColor];;
             }
         }
     }else{
         if ([textField isEqual:self.passwordInputView.firstTF]) {
              self.passwordInputView.firstLineView.backgroundColor = [UIColor skinColor];
             self.passwordInputView.secondLineView.backgroundColor = [UIColor lightGrayColor];
             if ([self.passwordInputView.secondTF.text length] > 0) {
                 self.loginButton.enabled = true;
                 self.loginButton.backgroundColor = [UIColor skinColor];;
             }
         }else if([textField isEqual:self.passwordInputView.secondTF]){
              self.passwordInputView.firstLineView.backgroundColor = [UIColor lightGrayColor];
             self.passwordInputView.secondLineView.backgroundColor = [UIColor skinColor];
             if ([self.passwordInputView.firstTF.text length] > 0) {
                 self.loginButton.enabled = true;
                 self.loginButton.backgroundColor = [UIColor skinColor];
             }
         }
     }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField.text.length == 10){
        if (self.forgetButton.hidden) {//代表验证码登录，无忘记密码
            if ([textField isEqual:self.codeInputView.firstTF]) {
                self.codeInputView.codeButton.selected = true;
                self.codeInputView.codeButton.enabled = true;
            }
            /*
            else if([textField isEqual:self.codeInputView.secondTF]){
                if ([self.codeInputView.firstTF.text length] > 0) {
                    self.loginButton.enabled = true;
                    self.loginButton.backgroundColor = [UIColor skinColor];
                }
            }
        }else{
            if ([textField isEqual:self.passwordInputView.firstTF]) {
                self.passwordInputView.firstLineView.backgroundColor = [UIColor skinColor];
                self.passwordInputView.secondLineView.backgroundColor = [UIColor lightGrayColor];
                if ([self.passwordInputView.secondTF.text length] > 0) {
                    self.loginButton.enabled = true;
                    self.loginButton.backgroundColor = [UIColor skinColor];;
                }
            }else if([textField isEqual:self.passwordInputView.secondTF]){
                self.passwordInputView.firstLineView.backgroundColor = [UIColor lightGrayColor];
                self.passwordInputView.secondLineView.backgroundColor = [UIColor skinColor];
                if ([self.passwordInputView.firstTF.text length] > 0) {
                    self.loginButton.enabled = true;
                    self.loginButton.backgroundColor = [UIColor skinColor];
                }
            }
             */
        }
             
    }
        
    
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.forgetButton.hidden) {//代表验证码登录，无忘记密码
        if ([self.codeInputView.firstTF.text length] > 0 && [self.codeInputView.secondTF.text length] > 0) {
            self.loginButton.enabled = true;
            self.loginButton.backgroundColor = [UIColor skinColor];
        }else{
            self.loginButton.enabled = false;
            self.loginButton.backgroundColor = [UIColor lightGrayColor];
        }
    }else{
        if ([self.passwordInputView.firstTF.text length] > 0 && [self.passwordInputView.secondTF.text length] > 0) {
            self.loginButton.enabled = true;
            self.loginButton.backgroundColor = [UIColor skinColor];;
        }else{
            self.loginButton.enabled = false;
            self.loginButton.backgroundColor = [UIColor lightGrayColor];
        }
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.forgetButton.hidden) {//代表验证码登录，无忘记密码
        if ([textField isEqual:self.codeInputView.firstTF]) {
            self.codeInputView.firstLineView.backgroundColor = [UIColor lightGrayColor];
        }else if([textField isEqual:self.codeInputView.secondTF]){
            self.codeInputView.secondLineView.backgroundColor = [UIColor lightGrayColor];
        }
    }else{
        if ([textField isEqual:self.passwordInputView.firstTF]) {
            self.passwordInputView.firstLineView.backgroundColor = [UIColor lightGrayColor];
        }else if([textField isEqual:self.passwordInputView.secondTF]){
        self.passwordInputView.secondLineView.backgroundColor = [UIColor lightGrayColor];
        }
    }
    return YES;
}

#pragma mark 获取验证码按钮点击
- (void)getSMSCode{
    if ([self.codeInputView.firstTF.text hj_isMobileNumber]){
        [KeyWindow ln_showLoadingHUD];
        WeakObj(self);
        [HQWYSMSModel requestSMSCodeWithMobile:self.codeInputView.firstTF.text
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
        [self addAlertView:@"输入手机号格式不正确" block:^{
            
        }];
    }
    
}

- (void)changeTime{
    
    _countTime--;
    if (_countTime == 0) {
        _countTime = 60;
        [_timer invalidate];
        _timer = nil;
        self.codeInputView.codeButton.userInteractionEnabled = YES;
        [self.codeInputView.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        
    }else{
        NSString * timeString = [NSString stringWithFormat:@"%lds 重新获取",(long)_countTime];
        [self.codeInputView.codeButton setTitle:timeString forState:UIControlStateNormal];
        [self.codeInputView.codeButton setTitle:timeString forState:UIControlStateSelected];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
