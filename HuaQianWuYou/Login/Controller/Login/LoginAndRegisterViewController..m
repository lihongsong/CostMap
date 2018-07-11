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
#import "AuthCodeModel.h"
#import "AuthCodeModel+Service.h"
#import "ImageCodeViewController.h"
#import "UIButton+Count.h"
#import "HQWYUser.h"
#import "HQWYUser+Service.h"

@interface LoginAndRegisterViewController ()<SelectTheLoginModeViewDelegate,UITextFieldDelegate,TwoTextFieldViewDelegate>
/* 验证码登录 */
@property(nonatomic,strong)TwoTextFieldView *codeInputView;
/* 密码登录 */
@property(nonatomic,strong)TwoTextFieldView *passwordInputView;
/* 忘记密码按钮 */
@property(nonatomic,strong)UIButton *forgetButton;
/* 登录按钮 */
@property(nonatomic,strong)UIButton *loginButton;
/* 返回按钮 */
@property(nonatomic,strong)UIButton *closeButton;
/* 流水号 */
@property (nonatomic, copy) NSString  *serialNumber;
@end

@implementation LoginAndRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpUi];
}
- (void)setUpUi{
    [self.view addSubview:self.closeButton];
    
    SelectTheLoginModeView *selectHeader = [[SelectTheLoginModeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.closeButton.frame),SWidth, 100)];
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

- (UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(0, StatusBarHeight, 50, 40);
        [_closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setImage:[UIImage imageNamed:@"navbar_close"] forState:UIControlStateNormal];
    }
    return _closeButton;
}

#pragma mark delegate 验证码登录
- (void)selectTheLoginModeCode{
    [self.codeInputView.firstTF becomeFirstResponder];
    self.codeInputView.secondLineView.backgroundColor = [UIColor lightGrayColor];
    self.forgetButton.hidden = true;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.codeInputView setType:TextFieldTypeCode];
        self.passwordInputView.transform = CGAffineTransformIdentity;
        self.codeInputView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
}


#pragma mark delegate 密码登录
- (void)selectTheLoginModePassword{
    [self.passwordInputView.firstTF becomeFirstResponder];
    self.passwordInputView.firstLineView.backgroundColor = [UIColor skinColor];
    self.passwordInputView.secondLineView.backgroundColor = [UIColor lightGrayColor];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.passwordInputView setType:TextFieldTypeNoneIsSeePassword];
        self.passwordInputView.transform = CGAffineTransformMakeTranslation(-SWidth, 0);
        self.codeInputView.transform = CGAffineTransformMakeTranslation(-SWidth, 0);
    } completion:^(BOOL finished) {
        self.forgetButton.hidden = false;
    }];
    
}

#pragma mark 忘记密码
- (void)forgetButtonClick{
    [self dismissViewControllerAnimated:true completion:^{
        if (self.forgetBlock) {
            self.forgetBlock();
        }
    }];
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
    WeakObj(self);
    [KeyWindow ln_showLoadingHUD];
    if (self.forgetButton.hidden) {//代表验证码登录，无忘记密码
        [HQWYUser authenticationCodeLogin:self.codeInputView.secondTF.text mobile:self.codeInputView.firstTF.text serialNumber:self.serialNumber Completion:^(HQWYUser * _Nullable result, NSError * _Nullable error) {
            StrongObj(self);
            if (error) {
                [KeyWindow ln_hideProgressHUD:LNMBProgressHUDAnimationError message:error.userInfo[@"msg"]];
                return ;
            }
            [KeyWindow ln_hideProgressHUD];
            if (result){
                [HQWYUserSharedManager storeNeedStoredUserInfomation:result];
                [self dismissViewControllerAnimated:true completion:^{
                    self.loginBlock();
                }];
            }
        }];
    }else{
        [HQWYUser passwordLogin:self.passwordInputView.secondTF.text mobile:self.passwordInputView.firstTF.text Completion:^(HQWYUser * _Nullable result, NSError * _Nullable error){
            StrongObj(self);
            if (error) {
                [KeyWindow ln_hideProgressHUD:LNMBProgressHUDAnimationError message:error.userInfo[@"msg"]];
                return ;
            }
            [KeyWindow ln_hideProgressHUD];
            if (result){
                [HQWYUserSharedManager storeNeedStoredUserInfomation:result];
                [self dismissViewControllerAnimated:true completion:^{
                    self.loginBlock();
                }];
            }
        }];
    }
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
        if (textField == self.codeInputView.firstTF || textField == self.passwordInputView.firstTF) {
            //超过12位禁止输入
            if(range.location >= 12 || string.length>12 || (textField.text.length + string.length) >12) {
                return NO;
            }else if (textField.text.length>=12&&![string isEqualToString:@""]){
                return NO;
            }
        }
    
        if (self.forgetButton.hidden) {//代表验证码登录，无忘记密码
            if (textField == self.codeInputView.secondTF) {
                //超过6位禁止输入
                if(range.location >= 6 || string.length>6 || (textField.text.length + string.length) >6) {
                    return NO;
                }else if (textField.text.length>=6 && ![string isEqualToString:@""]){
                    return NO;
                }
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

# pragma mark pod 图形验证码
- (void)popImageCodeViewImageCodeStr:(NSString *)imagStr serialNumber:(NSString *)serialNumber{
    ImageCodeViewController *imageCodeVC = [ImageCodeViewController new];
    imageCodeVC.imageStr = imagStr;
    imageCodeVC.serialNumber = serialNumber;
    WeakObj(self);
    imageCodeVC.block = ^(NSString *imageCode, NSString *serialNumber) {
        StrongObj(self);
        [self validateImageCode:imageCode serialNumber:serialNumber];
    };
    imageCodeVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:imageCodeVC animated:NO completion:nil];
}

# pragma mark 获取图形验证码
- (void)getImageCode{
    WeakObj(self);
    [KeyWindow ln_showLoadingHUD];
    [AuthCodeModel requsetImageCodeCompletion:^(ImageCodeModel * _Nullable result, NSError * _Nullable error) {
        StrongObj(self);
        if (error) {
            [KeyWindow ln_hideProgressHUD:LNMBProgressHUDAnimationError message:error.userInfo[@"msg"]];
            return ;
        }
        [KeyWindow ln_hideProgressHUD];
        if (result.outputImage.length > 0) {
            //到图形验证码页面
            [self popImageCodeViewImageCodeStr:result.outputImage serialNumber:result.serialNumber];
        }
    }];
}

# pragma mark 校验图形验证码
- (void)validateImageCode:(NSString *)imageCode serialNumber:(NSString *)serialNumber{
    WeakObj(self);
    [KeyWindow ln_showLoadingHUD];
    [AuthCodeModel validateImageCode:imageCode serialNumber:serialNumber Completion:^(AuthCodeModel * _Nullable result, NSError * _Nullable error) {
        StrongObj(self);
        if (error) {
            [KeyWindow ln_hideProgressHUD:LNMBProgressHUDAnimationError message:error.userInfo[@"msg"]];
            return ;
        }
        [KeyWindow ln_hideProgressHUD];
        if (result.result) {
            //校验成功 再次发送短信验证码
            [self getSMSCode];
        }
    }];
}

# pragma mark 获取短信验证码
- (void)getSMSCode{
    [KeyWindow ln_showLoadingHUD];
    [AuthCodeModel requsetMobilePhoneCode:self.codeInputView.firstTF.text smsType:LoginType Completion:^(AuthCodeModel * _Nullable result, NSError * _Nullable error) {
        if (error) {
            [KeyWindow ln_hideProgressHUD:LNMBProgressHUDAnimationError message:error.userInfo[@"msg"]];
            if (error.code == 1013) {
                [self getImageCode];
            }
            return ;
        }
        [KeyWindow ln_hideProgressHUD];
        if (self.codeInputView.codeButton) {
            //倒计时
            [self.codeInputView.codeButton startTotalTime:60 title:@"获取验证码" waitingTitle:@"后重试"];
        }
        self.serialNumber = result.body;
    }];
}

#pragma mark 登录取消返回
- (void)closeButtonClick{
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end