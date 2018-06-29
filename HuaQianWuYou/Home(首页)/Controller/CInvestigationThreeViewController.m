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
    self.secondTF.placeholder = @"请输入公积金用户名";
    self.thirdTF.placeholder = @"请输入公积金密码";
    self.thirdTF.secureTextEntry = YES;
    self.thirdTF.keyboardType = UIKeyboardTypeASCIICapable;
    [self showThridTF];
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
    if (StrIsEmpty(self.secondTF.text)) {
        [self setAlert:@"请输入公积金用户名"];
        return;
    }
    if (StrIsEmpty(self.thirdTF.text)) {
        [self setAlert:@"请输入公积金密码"];
        return;
    }
    self.requestModel.accumulationFundAccount = self.firstTF.text;
    self.requestModel.accumulationFundPWD = self.thirdTF.text;
    CInvestigationTwoViewController *vc = [CInvestigationTwoViewController new];
    vc.requestModel = self.requestModel;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
