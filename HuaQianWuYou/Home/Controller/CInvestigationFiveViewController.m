//
//  CInvestigationFiveViewController.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/23.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CInvestigationFiveViewController.h"
#import "CInvestigationFourViewController.h"

@interface CInvestigationFiveViewController ()

@end

@implementation CInvestigationFiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstTF.placeholder = @"请输入手机号";
    self.firstTF.keyboardType = UIKeyboardTypeNumberPad;
    self.firstTF.hj_maxLength = 11;
    self.secondTF.placeholder = @"请输入运营商查询密码";
    self.secondTF.secureTextEntry = YES;
    self.secondTF.keyboardType = UIKeyboardTypeNumberPad;
    self.secondTF.hj_maxLength = 6;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bottomButtonAction {
    [super bottomButtonAction];
    if (StrIsEmpty(self.firstTF.text)) {
        [self setAlert:@"请输入手机号"];
        return;
    }
    if (![self.firstTF.text hj_isMobileNumber]) {
        [self setAlert:@"请输入正确手机号"];
        return;
    }
    if (StrIsEmpty(self.secondTF.text)) {
        [self setAlert:@"请输入运营商查询密码"];
        return;
    }
    if (self.secondTF.text.length != 6) {
      [self setAlert:@"请输入正确的运营商查询密码"];
      return;
    }
    self.requestModel.servicePassword = self.secondTF.text;
    CInvestigationFourViewController *vc = [CInvestigationFourViewController new];
    vc.requestModel = self.requestModel;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
