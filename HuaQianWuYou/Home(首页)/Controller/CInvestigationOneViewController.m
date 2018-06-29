//
//  CInvestigationOneViewController.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CInvestigationOneViewController.h"
#import "CInvestigationThreeViewController.h"


@interface CInvestigationOneViewController ()

@end

@implementation CInvestigationOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstTF.placeholder = @"请输入姓名";
    self.firstTF.hj_maxLength = 30;
    self.secondTF.placeholder = @"请输入身份证号";
    self.secondTF.hj_maxLength = 18;
    self.secondTF.keyboardType = UIKeyboardTypeASCIICapable;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)bottomButtonAction {
    [super bottomButtonAction];
    if (StrIsEmpty(self.firstTF.text) || StrIsEmpty(self.secondTF.text)) {
        [self setAlert:@"请填写正确的姓名和身份证号"];
        return;
    }
    
    if (![self.secondTF.text hj_simpleVerifyIdentityCardNum]) {
        [self setAlert:@"请填写正确的身份证号"];
        return;
    }
    self.requestModel.name = self.firstTF.text;
    self.requestModel.iDCard = self.secondTF.text;
    CInvestigationThreeViewController *vc = [CInvestigationThreeViewController new];
    vc.requestModel = self.requestModel;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
