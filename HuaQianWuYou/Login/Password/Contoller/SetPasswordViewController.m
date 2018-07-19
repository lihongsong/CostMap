//
//  SetPasswordViewController.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "PasswordInputView.h"
#import "UIButton+EnlableColor.h"
#import <HJCategories/NSString+HJNormalRegex.h>
#import "ChangePasswordModel+Service.h"
@interface SetPasswordViewController ()<PasswordInputViewDelegate>
@property (nonatomic ,strong) UIButton *nextButton;

/* 设置密码 */
@property (nonatomic, copy) NSString  *password;

/* 确认密码 */
@property (nonatomic, copy) NSString  *surePassword;


@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置密码";
    self.navigationController.navigationBar.translucent = NO;
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
    [self.nextButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.nextButton enlableColor:[UIColor skinColor] disEnlableColor:[UIColor hj_colorWithHexString:@"D6D6D6"]];
    self.nextButton.enabled = NO;
}

- (void)textFieldContentdidChangeValues:(NSString *)firstValue secondValue:(NSString *)secondValue{
    self.nextButton.enabled = (firstValue.length >6 && secondValue.length>6);
    self.password = firstValue;
    self.surePassword = secondValue;
}


- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.frame = CGRectMake(10, 400, [UIScreen mainScreen].bounds.size.width-20, 50);
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.cornerRadius = 25;
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _nextButton;
}

- (void)nextAction:(UIButton *)sender{
    
//    if (![self.password hj_isValidWithMinLenth:6 maxLenth:20 containChinese:NO containDigtal:YES containLetter:YES containOtherCharacter:nil firstCannotBeDigtal:YES]) {
//        [KeyWindow ln_showToastHUD:@"请输入6～20位数字或字母密码"];
//    }
    if (![self.password isEqualToString:self.surePassword]) {
        [KeyWindow ln_showToastHUD:@"两次输入的密码不相同，请检查"];
        return;
    }
    [KeyWindow ln_showLoadingHUD];
    [ChangePasswordModel changePasswordCode:self.code jumpType:self.jumpType passWord:self.surePassword mobilePhone:self.mobilePhone serialNumber:self.serialNumber Completion:^(ChangePasswordModel * _Nullable result, NSError * _Nullable error) {
        [KeyWindow ln_hideProgressHUD];
        if (error) {
            return;
        }
        //存手机号和token逻辑
        [KeyWindow ln_showToastHUD:@"密码修改成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
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
