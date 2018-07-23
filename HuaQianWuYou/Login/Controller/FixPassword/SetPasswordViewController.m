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
//#import <HJCategories/NSString+HJNormalRegex.h>
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
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont NavigationTitleFont],NSForegroundColorAttributeName:[UIColor bigTitleBlackColor]}];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI{
    PasswordInputView *pasView = [PasswordInputView instance];
    pasView.delegate = self;
    pasView.type = PasswordInputTypeSet;
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
    [self.nextButton hj_setBackgroundColor:[UIColor buttonGrayColor] forState:UIControlStateNormal];
    [self.nextButton hj_setBackgroundColor:[UIColor skinColor] forState:UIControlStateSelected];
}

# pragma mark 输入View 代理方法 输入就会调用

- (void)textFieldContentdidChangeValues:(NSString *)firstValue secondValue:(NSString *)secondValue{
    self.nextButton.selected = (firstValue.length >=6 && secondValue.length>=6);
    self.password = firstValue;
    self.surePassword = secondValue;
}

# pragma mark 确定下一步

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.frame = CGRectMake(10, 400, [UIScreen mainScreen].bounds.size.width-20, 50);
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.cornerRadius = 25;
        [_nextButton setTitleColor:[UIColor whiteButtonTitleColor] forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _nextButton;
}

-(void)backPage {
    [self eventId:HQWY_Fix_PasswordBack_click];
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (void)nextAction:(UIButton *)sender{
    [self eventId:HQWY_Fix_Sure_click];
    if (!(self.password.length > 5) || !(self.password.length < 21)) {
        [KeyWindow ln_showToastHUD:@"密码输入格式错误"];
        return;

    }
    if (![self.password isEqualToString:self.surePassword]) {
        [KeyWindow ln_showToastHUD:@"两次输入的密码不相同，请检查"];
        return;
    }
    WeakObj(self);
    [ZYZMBProgressHUD showHUDAddedTo:self.view animated:true];
    [ChangePasswordModel changePasswordCode:self.code passWord:self.surePassword mobilePhone:self.mobilePhone serialNumber:self.serialNumber Completion:^(ChangePasswordModel * _Nullable result, NSError * _Nullable error) {
        StrongObj(self);
        [ZYZMBProgressHUD hideHUDForView:self.view animated:true];
        if (error) {
            [KeyWindow ln_showToastHUD:error.hqwy_errorMessage];
            return ;
        }
            [KeyWindow ln_hideProgressHUD:LNMBProgressHUDAnimationOK message:@"密码修改成功"];
            [HQWYUserSharedManager storeNeedStoredUserInfomation:result];
            self.finishblock();
            [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
