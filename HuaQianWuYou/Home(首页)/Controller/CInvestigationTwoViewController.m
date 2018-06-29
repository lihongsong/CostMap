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
    if (StrIsEmpty(self.secondTF.text)) {
        [self setAlert:@"请输入社保密码"];
        return;
    }
    CInvestigationFiveViewController *vc = [CInvestigationFiveViewController new];
    vc.requestModel = self.requestModel;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
