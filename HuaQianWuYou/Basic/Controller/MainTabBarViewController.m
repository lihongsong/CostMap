//
//  MainTabBarViewController.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/3.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "DiscoverViewController.h"
@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createControllers];
    [self createTabBarUI];
}

-(void)createControllers
{
    HomeViewController *LVC = [[HomeViewController alloc]init];
    BaseNavigationController *hNC = [[BaseNavigationController alloc]initWithRootViewController:LVC ];
    hNC.navigationBar.barTintColor = [UIColor skinColor];
    hNC.navigationBar.translucent = NO;
    
    DiscoverViewController *dVC = [[DiscoverViewController alloc]init];
    BaseNavigationController *dNC = [[BaseNavigationController alloc]initWithRootViewController:dVC];
    dNC.navigationBar.barTintColor = [UIColor skinColor];
    dNC.navigationBar.translucent = NO;
    
    MineViewController * mVC = [[MineViewController alloc] init];
    BaseNavigationController *mNC = [[BaseNavigationController alloc]initWithRootViewController:mVC];
    mNC.navigationBar.barTintColor = [UIColor skinColor];
    mNC.navigationBar.translucent = NO;
    
    [mNC.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont NavigationTitleFont]}];
    
    self.viewControllers = @[hNC,dNC,mNC];
    
}

-(void)createTabBarUI
{
    NSArray *titleArr = @[@"首页",@"发现",@"我的"];
    NSMutableArray *imageArr = [[NSMutableArray alloc]init];
    NSMutableArray *imageSelectArr = [[NSMutableArray alloc]init];
    [imageArr addObjectsFromArray:@[@"bottombar_home_normal",@"bottombar_discover_normal",@"bottombar_mine_normal"]];
    [imageSelectArr addObjectsFromArray:@[@"bottombar_home_selected",@"bottombar_discover_selected",@"bottombar_mine_selected"]];
    
    for (int i = 0; i < self.tabBar.items.count; i++) {
        UITabBarItem *item = self.tabBar.items[i];
        item.title = titleArr[i];
        item.image = [[UIImage imageNamed:imageArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:imageSelectArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont tabBarFont],
                                                        NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
