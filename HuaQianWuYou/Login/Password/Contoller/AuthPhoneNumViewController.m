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
#import <HJCategories/NSString+HJNormalRegex.h>
#import "SetPasswordViewController.h"
#import "ImageCodeViewController.h"
#import "AuthCodeModel+Service.h"
@interface AuthPhoneNumViewController ()<PasswordInputViewDelegate>

@property (nonatomic ,strong) UIButton *nextButton;

/* 手机号 */
@property (nonatomic, copy) NSString  *phoneNum;

/* 验证码 */
@property (nonatomic, copy) NSString  *authCode;


@end

@implementation AuthPhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证手机号";
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    // Do any additional setup after loading the view.
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

- (void)textFieldContentdidChangeValues:(NSString *)firstValue secondValue:(NSString *)secondValue{
    self.nextButton.enabled = (firstValue.length >0 && secondValue.length>0);
    self.phoneNum = firstValue;
    self.authCode = secondValue;
}


- (void)didSendAuthCode{
    //已经点击发送验证码
    
    [self getSMSCode];

    
}

# pragma mark pod 图形验证码
- (void)popImageCodeView{
    ImageCodeViewController *imageCodeVC = [ImageCodeViewController new];
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
    
}

# pragma mark 校验图形验证码
- (void)validateImageCode:(NSString *)imageCode serialNumber:(NSString *)serialNumber{
    [AuthCodeModel validateImageCode:imageCode serialNumber:serialNumber Completion:^(AuthCodeModel * _Nullable result, NSError * _Nullable error) {
        
    }];
}

# pragma mark 获取短信验证码
- (void)getSMSCode{
    
    [AuthCodeModel requsetMobilePhoneCode:self.phoneNum smsType:self.authCode Completion:^(AuthCodeModel * _Nullable result, NSError * _Nullable error) {
        
    }];
}

# pragma mark 校验手机号
- (void)validatePhoneNum{}





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


- (void)nextAction:(UIButton *)sender{
    //校验是不是手机号
    if (![self.phoneNum hj_isMobileNumber]) {
        [KeyWindow ln_showToastHUD:@"手机号错误"];
        return;
    }
    SetPasswordViewController *setPassword = [SetPasswordViewController new];
    [self.navigationController pushViewController:setPassword animated:YES];
    
    
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
