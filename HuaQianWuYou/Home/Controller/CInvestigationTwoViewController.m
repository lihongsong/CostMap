//
//  CInvestigationTwoViewController.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CInvestigationTwoViewController.h"
#import "CInvestigationFiveViewController.h"

@interface CInvestigationTwoViewController ()

@end

@implementation CInvestigationTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstTF.placeholder = @"请输入社保用户名";
    self.firstTF.keyboardType = UIKeyboardTypeASCIICapable;
    self.firstTF.hj_maxLength = 20;
    self.secondTF.placeholder = @"请输入社保密码";
    self.secondTF.secureTextEntry = YES;
    self.secondTF.keyboardType = UIKeyboardTypeASCIICapable;
    self.secondTF.hj_maxLength = 20;
    [self initLocationService];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bottomButtonAction {

    [super bottomButtonAction];
    if (StrIsEmpty(self.firstTF.text)) {
        [self setAlert:@"请输入社保用户名"];
        return;
    }

    if (![self string:self.firstTF.text isValidWithRegex:@"^[a-zA-Z][a-zA-Z0-9]{3,19}$"]) {
        [self setAlert:@"请输入正确的社保用户名"];
        return;
    }
    if (StrIsEmpty(self.secondTF.text)) {
        [self setAlert:@"请输入社保密码"];
        return;
    }
    if (![self string:self.secondTF.text isValidWithRegex:@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$"]) {
        [self setAlert:@"请输入正确的社保密码"];
        return;
    }
    CInvestigationFiveViewController *vc = [CInvestigationFiveViewController new];
    vc.requestModel = self.requestModel;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
