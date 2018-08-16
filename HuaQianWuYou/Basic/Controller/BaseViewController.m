//
//  BaseViewController.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/4.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont NavigationTitleFont],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = HJHexColor(0xf2f2f2);
    
    [self setLelftNavigationItem:NO];
}


- (void)setLelftNavigationItem:(BOOL)hidden {
    if (!hidden) {
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        
        UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
        [button setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"nav_icon_back"] forState:UIControlStateHighlighted];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        [contentView addSubview:button];
        
        [button addTarget:self action:@selector(backPage) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
        self.navigationItem.leftBarButtonItem = barButtonItem;
    } else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
    }
}

- (void)setLelftNavigationItemWithImageName:(NSString *)imageName hidden:(BOOL)hidden {
    if (hidden) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
        return;
    }
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *button = [[UIButton alloc] initWithFrame:contentView.bounds];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [contentView addSubview:button];
    [button addTarget:self action:@selector(backPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:contentView];
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

-(void)backPage {
    [self.navigationController popViewControllerAnimated:YES];
}

- (DefaultView *)defaultView {
    if (!_defaultView) {
        _defaultView = [DefaultView new];
    }
    return _defaultView;
}

@end
