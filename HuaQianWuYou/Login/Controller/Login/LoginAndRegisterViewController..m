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
#import "ImageCodeModel.h"
#import "ImageCodeModel+Service.h"
#import "ThirdPartWebVC.h"

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
    self.serialNumber = @"";
}
- (void)setUpUi{
    [self.view addSubview:self.closeButton];
    
    SelectTheLoginModeView *selectHeader = [[SelectTheLoginModeView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.closeButton.frame),SWidth, 100)];
    selectHeader.delegate = self;
    [self.view addSubview:selectHeader];
    
    [self.view addSubview:self.codeInputView];
    [self.codeInputView.firstTF becomeFirstResponder];
    self.codeInputView.secondTF.hj_maxLength = 6;
    [self.view addSubview:self.passwordInputView];
    self.passwordInputView.secondTF.hj_maxLength = 20;
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
        _codeInputView.delegate = self;
        _codeInputView.firstTF.delegate = self;
        _codeInputView.firstTF.text = [HQWYUserManager lastLoginMobilePhone];
        _codeInputView.secondTF.delegate = self;
        [_codeInputView setType:TextFieldTypeCode];
    }
    return _codeInputView;
}

- (TwoTextFieldView *)passwordInputView{
    if (!_passwordInputView) {
        _passwordInputView = [[TwoTextFieldView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.codeInputView.frame), self.codeInputView.hj_y, SWidth, 125)];
        _passwordInputView.delegate = self;
        _passwordInputView.firstTF.delegate = self;
        _passwordInputView.firstTF.text = [HQWYUserManager lastLoginMobilePhone];
        _passwordInputView.firstTF.secureTextEntry = true;
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
    [self eventId:HQWY_Login_ForgetPassword_click];
    [self dismissViewControllerAnimated:true completion:^{
        if (self.forgetBlock) {
            self.forgetBlock();
        }
    }];
}

#pragma mark 登录事件
- (void)loginButtonClick{
    self.loginButton.userInteractionEnabled = false;
    //FIXME:review 这里的if else 太深了，要调整
    WeakObj(self);
    if (self.forgetButton.hidden) {//代表验证码登录，无忘记密码
        [self eventId:HQWY_Login_SignIn_click];
        if (![self.codeInputView.firstTF.text hj_isMobileNumber]) {
            [self addAlertView:@"请输入有效手机号" block:^{
                selfWeak.loginButton.userInteractionEnabled = true;
            }];
            return;
        }
        if ([self.codeInputView.secondTF.text length] < 6){
            [self addAlertView:@"请输入正确的验证码" block:^{
                selfWeak.loginButton.userInteractionEnabled = true;
                return;
            }];
            return;
        }
        [self requestLogin];
    }else{
        [self eventId:HQWY_Login_PasswordLogin_click];
        if (!([self.passwordInputView.firstTF.text length] > 0)) {
            [self addAlertView:@"请输入手机号" block:^{
                selfWeak.loginButton.userInteractionEnabled = true;
            }];
            return ;
        }
        if (!([self.passwordInputView.secondTF.text length] > 0)) {
            [self addAlertView:@"请输入密码" block:^{
                selfWeak.loginButton.userInteractionEnabled = true;
            }];
            return;
        }
        if ([self.passwordInputView.firstTF.text hj_isMobileNumber]) {
            [self requestLogin];
        }else{
            [self addAlertView:@"手机号格式不正确" block:^{
                selfWeak.loginButton.userInteractionEnabled = true;
            }];
            return;
        }
    }
    
}

#pragma mark 请求登录
- (void)requestLogin{
    WeakObj(self);
    
    [KeyWindow ln_showLoadingHUD];
    //FIXME:review if else 中一部分内容是一样的，抽出来共用

    if (self.forgetButton.hidden) {//代表验证码登录，无忘记密码
        [HQWYUser authenticationCodeLogin:self.codeInputView.secondTF.text mobile:self.codeInputView.firstTF.text serialNumber:self.serialNumber registerType:RegisterTypeHQWYApp Completion:^(HQWYUser * _Nullable result, NSError * _Nullable error) {
            StrongObj(self);
            self.loginButton.userInteractionEnabled = true;

            if (error) {
                [KeyWindow ln_hideProgressHUD:LNMBProgressHUDAnimationError
                                    message:error.hqwy_errorMessage];
                return ;
            } else {
                [KeyWindow ln_hideProgressHUD];
            }
            if (result){
                [HQWYUserSharedManager storeNeedStoredUserInfomation:result];
                [self dismissViewControllerAnimated:true completion:^{
                    if(self.loginBlock){
                        self.loginBlock();
                    }
                }];
            }
        }];
    }else{
        [HQWYUser passwordLogin:self.passwordInputView.secondTF.text mobile:self.passwordInputView.firstTF.text Completion:^(HQWYUser * _Nullable result, NSError * _Nullable error){
            StrongObj(self);
            self.loginButton.userInteractionEnabled = true;
            if (error) {
                [KeyWindow ln_hideProgressHUD:LNMBProgressHUDAnimationError
                                      message:error.hqwy_errorMessage];
                return ;
            } else {
                [KeyWindow ln_hideProgressHUD];
            }
            if (result){
                [HQWYUserSharedManager storeNeedStoredUserInfomation:result];
                [self dismissViewControllerAnimated:true completion:^{
                    if(self.loginBlock){
                        self.loginBlock();
                    }
                }];
            }
        }];
    }
}

#pragma mark 协议点击事件
- (void)agrementClick{
    if (self.forgetButton.hidden ) {
        [self eventId:HQWY_Login_Agreement_click];
    }else{
        [self eventId:HQWY_Login_PasswordAgreement_click];
    }
    ThirdPartWebVC *webView = [ThirdPartWebVC new];
    [webView loadURLString:AGGREMENT_PATH];
    [self presentViewController:webView animated:true completion:^{
        
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //FIXME:review 这里的if else 太深了，要调整
    //FIXME:review 这里的重复代码较多，可以优化
     if (self.forgetButton.hidden) {//代表验证码登录，无忘记密码
         if ([textField isEqual:self.codeInputView.firstTF]) {
             self.codeInputView.firstLineView.backgroundColor = [UIColor skinColor];
              self.codeInputView.secondLineView.backgroundColor = [UIColor lightGrayColor];
         }else if([textField isEqual:self.codeInputView.secondTF]){
             self.codeInputView.firstLineView.backgroundColor = [UIColor lightGrayColor];
             self.codeInputView.secondLineView.backgroundColor = [UIColor skinColor];
         }
     }else{
         if ([textField isEqual:self.passwordInputView.firstTF]) {
              self.passwordInputView.firstLineView.backgroundColor = [UIColor skinColor];
             self.passwordInputView.secondLineView.backgroundColor = [UIColor lightGrayColor];
         }else if([textField isEqual:self.passwordInputView.secondTF]){
              self.passwordInputView.firstLineView.backgroundColor = [UIColor lightGrayColor];
             self.passwordInputView.secondLineView.backgroundColor = [UIColor skinColor];
         }
     }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //FIXME:review textField 的长度限制方法，在我们分类里面已有，UITextField+HJInputLimit 中
    if (self.forgetButton.hidden) {//代表验证码登录，无忘记密码
        if ([textField isEqual:self.codeInputView.firstTF]) {
            if (textField.text.length == 10) {
                self.codeInputView.codeButton.selected = true;
                if (self.codeInputView.secondTF.text.length == 6) {
                    self.loginButton.backgroundColor = [UIColor skinColor];
                    
                }
            }else{
             self.codeInputView.codeButton.selected = false;
                self.loginButton.backgroundColor = [UIColor lightGrayColor];
            }
        }else{
            if (textField.text.length == 5 && self.codeInputView.firstTF.text.length == 11) {
                self.loginButton.backgroundColor = [UIColor skinColor];
            }else{
                self.loginButton.backgroundColor = [UIColor lightGrayColor];
            }
        }
    }else{
        if ([textField isEqual:self.passwordInputView.firstTF]) {
            if (textField.text.length == 10 && [self.passwordInputView.secondTF.text length] >= 6) {
                self.loginButton.backgroundColor = [UIColor skinColor];
            }else{
                self.loginButton.backgroundColor = [UIColor lightGrayColor];
            }
        }else{
            if (textField.text.length >= 5 && self.passwordInputView.firstTF.text.length == 11) {
                self.loginButton.backgroundColor = [UIColor skinColor];
            }else{
                self.loginButton.backgroundColor = [UIColor lightGrayColor];
            }
        }
    }
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
   
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
    
    //FIXME:review 这个请求图形验证码的逻辑在三个类中都有，可以抽离
    [ImageCodeModel requsetImageCodeCompletion:^(ImageCodeModel * _Nullable result, NSError * _Nullable error) {
        StrongObj(self);
        
        
        if (error) {
            [KeyWindow ln_hideProgressHUD:LNMBProgressHUDAnimationError
                                  message:error.hqwy_errorMessage];
            return ;
        } else {
            [KeyWindow ln_hideProgressHUD];
        }
        if(result){
            if (result.outputImage.length > 0) {
                //到图形验证码页面
                [self popImageCodeViewImageCodeStr:result.outputImage serialNumber:result.serialNumber];
            }
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
            [KeyWindow ln_hideProgressHUD:LNMBProgressHUDAnimationError
                                  message:error.hqwy_errorMessage];
            [self getImageCode];
            return ;
        } else {
            [KeyWindow ln_hideProgressHUD];
        }
            //校验成功 再次发送短信验证码
            [self getSMSCode];
    }];
}

# pragma mark 获取短信验证码
- (void)getSMSCode{

    if (![self.codeInputView.firstTF.text hj_isMobileNumber]) {
        [KeyWindow ln_showToastHUD:@"请输入有效手机号"];
        return;
    }
    [KeyWindow ln_showLoadingHUD];
    //FIXME:review LoginType 用枚举定义
    [AuthCodeModel requsetMobilePhoneCode:self.codeInputView.firstTF.text smsType:LoginType Completion:^(AuthCodeModel * _Nullable result, NSError * _Nullable error) {
        NSLog(@"____%ld",(long)error.hqwy_respCode);
        //NSLog(@"____%@",error.hqwy_errorMessage);
        if (error) {
            if (error.code == 1013) {
                [KeyWindow ln_hideProgressHUD];
                self.serialNumber = [NSString stringWithFormat:@"%@", result];
                [self getImageCode];
            }else{
               [KeyWindow ln_hideProgressHUD:LNMBProgressHUDAnimationError
                                     message:error.hqwy_errorMessage];
            }
            return ;
        } else {
            [KeyWindow ln_hideProgressHUD];
        }
        if (self.codeInputView.codeButton) {
            //倒计时
            [self.codeInputView.codeButton startTotalTime:60 title:@"获取验证码" waitingTitle:@"后重试"];
        }
        NSLog(@")_____%@",result);
        if (result) {
            self.serialNumber = [NSString stringWithFormat:@"%@", result];
        }
    }];
}

#pragma mark 登录取消返回
- (void)closeButtonClick{
    [self eventId:HQWY_Login_Close_click];
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
