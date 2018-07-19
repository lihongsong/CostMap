//
//  CInvestigationThreeViewController.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CInvestigationThreeViewController.h"
#import "CInvestigationTwoViewController.h"

@interface CInvestigationThreeViewController ()

@end

@implementation CInvestigationThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstTF.placeholder = @"请输入公积金帐号";
    self.firstTF.keyboardType = UIKeyboardTypeNumberPad;
    self.firstTF.hj_maxLength = 12;

    self.secondTF.placeholder = @"请输入公积金用户名";
    self.secondTF.hj_maxLength = 12;
    self.secondTF.keyboardType = UIKeyboardTypeASCIICapable;
    self.thirdTF.placeholder = @"请输入公积金密码";
    self.thirdTF.secureTextEntry = YES;
    self.thirdTF.hj_maxLength = 15;
    self.thirdTF.keyboardType = UIKeyboardTypeASCIICapable;
    [self showThridTF];
    [self initLocationService];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bottomButtonAction {
    [super bottomButtonAction];
    if (StrIsEmpty(self.firstTF.text)) {
        [self setAlert:@"请输入公积金帐号"];
        return;
    }
    if (![self string:self.firstTF.text isValidWithRegex:@"^[0-1]\\d{11}|[0-1]\\d{8}$"]) {
        [self setAlert:@"请输入正确的公积金帐号"];
        return;
    }
    if (StrIsEmpty(self.secondTF.text)) {
        [self setAlert:@"请输入公积金用户名"];
        return;
    }
    if (![self string:self.secondTF.text isValidWithRegex:@"^[a-zA-Z0-9]{2,12}$"]) {
        [self setAlert:@"请输入正确的公积金用户名"];
        return;
    }
    if (StrIsEmpty(self.thirdTF.text)) {
        [self setAlert:@"请填写公积金密码"];
        return;
    }
    if (![self string:self.thirdTF.text isValidWithRegex:@"^[a-zA-Z0-9]{6,15}$"]) {
        [self setAlert:@"请输入正确的公积金密码"];
        return;
    }
    self.requestModel.accumulationFundAccount = self.firstTF.text;
    self.requestModel.accumulationFundPWD = self.thirdTF.text;
    CInvestigationTwoViewController *vc = [CInvestigationTwoViewController new];
    vc.requestModel = self.requestModel;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
