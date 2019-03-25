//
//  YosKeepAccountsMePresenter.m
//  YosKeepAccounts
//
//  Created by yoser on 2019/3/25.
//  Copyright © 2019 yoser. All rights reserved.
//

#import "YosKeepAccountsMePresenter.h"

#import "YosKeepAccountsSettingScene.h"

@implementation YosKeepAccountsMePresenter

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
}

- (void)setUpUI {
    
    YosKeepAccountsSettingScene *settingScene = [YosKeepAccountsSettingScene settingScene];
    settingScene.superPresenter = self;
    settingScene.gotoSceneContoller = ^(UIViewController * _Nonnull viewController) {
        [self.navigationController pushViewController:viewController animated:YES];
    };
    [self.view addSubview:settingScene];
    
    [settingScene mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

@end
