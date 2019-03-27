//
//  YosKeepAccountsMePresenter.m
//  YosKeepAccounts
//
//  Created by yoser on 2019/3/25.
//  Copyright © 2019 yoser. All rights reserved.
//

#import "YosKeepAccountsMePresenter.h"
#import "YosKeepAccountsSettingScene.h"
#import "YosKeepAccountsEditOrderPresenter.h"
#import "YosKeepAccountsTranstionAnimationPush.h"

@interface YosKeepAccountsMePresenter()<UINavigationControllerDelegate>

@end

@implementation YosKeepAccountsMePresenter

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setUpUI {
    
    self.navigationController.delegate = self;
    
    UIScrollView *scrollScene = [UIScrollView new];
    scrollScene.backgroundColor = [UIColor whiteColor];
    
    YosKeepAccountsSettingScene *settingScene = [YosKeepAccountsSettingScene settingScene];
    settingScene.superPresenter = self;
    settingScene.gotoSceneContoller = ^(UIViewController * _Nonnull viewController) {
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    };
    
    [scrollScene addSubview:settingScene];
    [self.view addSubview:scrollScene];
    
    [scrollScene mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        make.size.mas_equalTo(self.view);
    }];
    
    [settingScene mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        make.height.mas_equalTo(450);
        make.width.mas_equalTo(self.view);
    }];
}

#pragma mark -- UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if ([fromVC isKindOfClass:[YosKeepAccountsMePresenter class]] &&
        [toVC isKindOfClass:[YosKeepAccountsEditOrderPresenter class]] &&
        operation == UINavigationControllerOperationPush) {
        return [YosKeepAccountsTranstionAnimationPush new];
    } else {
        return nil;
    }
}

@end
