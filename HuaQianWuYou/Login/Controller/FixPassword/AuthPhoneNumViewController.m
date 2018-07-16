//
//  AuthPhoneNumViewController.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "AuthPhoneNumViewController.h"
#import "PasswordInputView.h"
#import "UIButton+EnlableColor.h"
//#import <HJCategories/NSString+HJNormalRegex.h>
#import "SetPasswordViewController.h"
#import "ImageCodeViewController.h"
#import "AuthCodeModel+Service.h"

#import "UIButton+Count.h"

@interface AuthPhoneNumViewController ()<PasswordInputViewDelegate>

@property (nonatomic ,strong) UIButton *nextButton;

/* 手机号 */
@property (nonatomic, copy) NSString  *phoneNum;

/* 验证码 */
@property (nonatomic, copy) NSString  *authCode;

/* 流水号 */
@property (nonatomic, copy) NSString  *serialNumber;

/* 发送验证码按钮 */
@property (nonatomic, strong) UIButton  *authCodeButton;


@end

@implementation AuthPhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证手机号";
self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    //[self setLelftNavigationItem:NO];
    // Do any additional setup after loading the view.
}

-(void)backPage {
    [self eventId:HQWY_Fix_Back_click];
    [self.navigationController popViewControllerAnimated:true];
}

- (void)setupUI{
    PasswordInputView *pasView = [PasswordInputView instance];
    pasView.delegate = self;
    pasView.type = PasswordInputTypeAuthPhoneNum;
    [self.view addSubview:pasView];
    [pasView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(47);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(122);
    }];
    
    [self.view addSubview:self.nextButton];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pasView.mas_bottom).mas_offset(78);
        make.left.right.equalTo(pasView);
        make.height.mas_equalTo(45);
    }];
    [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextButton enlableColor:[UIColor skinColor] disEnlableColor:[UIColor hj_colorWithHexString:@"D6D6D6"]];
    self.nextButton.enabled = NO;
}

# pragma mark 输入View 代理方法 输入就会调用

- (void)textFieldContentdidChangeValues:(NSString *)firstValue secondValue:(NSString *)secondValue{
    self.nextButton.enabled = (firstValue.length >0 && secondValue.length>0);
    self.phoneNum = firstValue;
    self.authCode = secondValue;
}

- (void)didSendAuthCodeAction:(UIButton *)sender{
    //点击发送验证码
    self.authCodeButton = sender;//发送验证码按钮
    [self getSMSCode];
}



# pragma mark pod 图形验证码
- (void)popImageCodeViewImageCodeStr:(NSString *)imagStr serialNumber:(NSString*)serialNumber{
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
    [ZYZMBProgressHUD showHUDAddedTo:self.view animated:true];
    [AuthCodeModel requsetImageCodeCompletion:^(ImageCodeModel * _Nullable result, NSError * _Nullable error) {
        [ZYZMBProgressHUD hideHUDForView:self.view animated:true];
        if (error) {
            [KeyWindow ln_showToastHUD:error.hqwy_errorMessage];
            return ;
        }
        if (result.outputImage.length > 0) {
            //到图形验证码页面
            [self popImageCodeViewImageCodeStr:result.outputImage serialNumber:result.serialNumber];
        }
    }];
}

# pragma mark 校验图形验证码
- (void)validateImageCode:(NSString *)imageCode serialNumber:(NSString *)serialNumber{
    [ZYZMBProgressHUD showHUDAddedTo:self.view animated:true];
    [AuthCodeModel validateImageCode:imageCode serialNumber:serialNumber Completion:^(AuthCodeModel * _Nullable result, NSError * _Nullable error) {
        [ZYZMBProgressHUD hideHUDForView:self.view animated:true];
        if (error) {
            [KeyWindow ln_showToastHUD:error.hqwy_errorMessage];
            return ;
        }
        if (result) {
            //校验成功 再次发送短信验证码
            [self getSMSCode];
        }
    }];
}

# pragma mark 获取短信验证码
- (void)getSMSCode{
    [ZYZMBProgressHUD showHUDAddedTo:self.view animated:true];
    [AuthCodeModel requsetMobilePhoneCode:self.phoneNum smsType:FixPassword Completion:^(AuthCodeModel * _Nullable result, NSError * _Nullable error) {
        [ZYZMBProgressHUD hideHUDForView:self.view animated:true];
        if (error) {
            if (error.code == 1013) {
                self.serialNumber = [NSString stringWithFormat:@"%@",result];
                 [self getImageCode];
            }else {
              [KeyWindow ln_showToastHUD:error.hqwy_errorMessage];
            }
            return ;
        }
        if (result) {
            /*如果发送成功 */
            if (self.authCodeButton) {
                //倒计时
                [self.authCodeButton startTotalTime:60 title:@"获取验证码" waitingTitle:@"后重试"];
            }
            self.serialNumber = [NSString stringWithFormat:@"%@",result] ;
        }
    }];
}

# pragma mark 校验短信验证码
- (void)validatePhoneNum{
    [ZYZMBProgressHUD showHUDAddedTo:self.view animated:true];
    [AuthCodeModel validateSMSCode:self.authCode mobilePhone:self.phoneNum smsType:FixPassword serialNumber:self.serialNumber Completion:^(AuthCodeModel * _Nullable result, NSError * _Nullable error) {
        [ZYZMBProgressHUD hideHUDForView:self.view animated:true];
        if (error) {
           [KeyWindow ln_showToastHUD:error.hqwy_errorMessage];
            return ;
        }
        //校验成功
        SetPasswordViewController *setPassword = [SetPasswordViewController new];
        setPassword.jumpType = @"1";
        setPassword.code = self.authCode;
        setPassword.mobilePhone = self.phoneNum;
        setPassword.serialNumber = self.serialNumber;
        [self.navigationController pushViewController:setPassword animated:YES];
    }];
}

- (void)nextAction:(UIButton *)sender{
    [self eventId:HQWY_Fix_Next_click];
    //校验是不是手机号
    if (![self.phoneNum hj_isMobileNumber]) {
        [KeyWindow ln_showToastHUD:@"手机号错误"];
        return;
    }
    [self validatePhoneNum];
}


- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.cornerRadius = 25;
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _nextButton;
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
