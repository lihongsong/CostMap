//
//  MineViewController.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/9.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "MineTopHeaderView.h"
#import "MineNoticeView.h"
#import "MineFooterView.h"
#import "FeedbackViewController.h"
#import "AboutUsViewController.h"
#import "CInvestigationOneViewController.h"
#import "CInvestigationProgressViewController.h"
#import "LoginViewController.h"
#import "LoginInfoModel.h"

@interface MineViewController () <UITableViewDelegate, UITableViewDataSource, MineTableViewCellDelegate> {
    CGFloat footerHeight;
}
@property(nonatomic, strong) UITableView *tableview;
@property(nonatomic, strong) MineTopHeaderView *topHeaderView;
@property(nonatomic, strong) NSArray *showDataArray;

@end

@implementation MineViewController

#pragma - mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    LoginUserInfoModel *loginModel = [LoginUserInfoModel cachedLoginModel];
    if (loginModel) {
        [self updateLoginStatus:YES];
    } else {
        [self updateLoginStatus:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)setUpUI {
    WeakObj(self);
    footerHeight = 0.00001f;
    self.topHeaderView = [MineTopHeaderView new];
    [self.view addSubview:self.topHeaderView];
    self.topHeaderView.loginBlock = ^{
        StrongObj(self);
        [self login];
    };
    [self.topHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.top.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SWidth, 160));
    }];
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.top.mas_equalTo(self.topHeaderView.mas_bottom);
        make.left.right.bottom.centerX.mas_equalTo(self.view);
    }];
}

- (void)updateLoginStatus:(BOOL)isLogin {
    self.topHeaderView.isUserLogin = isLogin;
    footerHeight = isLogin ? 70.0f : 0.00001f;
    [self.tableview reloadData];
}

#pragma - mark setter && getter

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorColor = HJHexColor(0xF2F2F2);
    }
    return _tableview;
}

#pragma - mark UITableViewDataSource && Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0.0001f;
            break;
        case 1:
            return 36.5;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0.00001f;
            break;
        case 1:
            return footerHeight;
            break;
        default:
            return 0.00001f;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell"];
    if (!cell) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineTableViewCell"];
    }
    cell.delegate = self;
    [cell updateCellInfo:self.showDataArray[indexPath.section][indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        MineNoticeView *noticeView = [MineNoticeView new];
        return noticeView;
    } else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0: {
                LoginUserInfoModel *userInfo = [LoginUserInfoModel cachedLoginModel];
                if (!userInfo) {
                    LoginViewController *loginvc = [LoginViewController new];
                    [self.navigationController pushViewController:loginvc animated:YES];
                } else {
                    FeedbackViewController *vc = [FeedbackViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
                break;
            case 1: {
                AboutUsViewController *vc = [AboutUsViewController new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        MineFooterView *footerView = [MineFooterView new];
        WeakObj(self);
        footerView.tapLogout = ^() {
            StrongObj(self);
            [self logOut];
        };
        return footerView;
    } else {
        return 0;
    }
}


- (NSArray *)showDataArray {
    return @[@[@{
            @"logo": @"mine_fingerprint",
            @"itemName": @"安全访问",
            @"celltType": @2,
    }],
            @[@{
                    @"logo": @"mine_feedback",
                    @"itemName": @"意见反馈",
            },
                    @{
                            @"logo": @"mine_about",
                            @"itemName": @"关于我们",
                    }]];
}

#pragma - mark MineTableViewCellDelegate

- (void)MineTableViewCellDidTapSwitch:(UISwitch *)switchView {
    BOOL isOn = switchView.on;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:isOn forKey:@"kCachedTouchIdStatus"];
    [userDefault synchronize];
}

#pragma - mark 退出登录

- (void)logOut {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"是否要退出当前帐号？"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *_Nonnull action) {
                                                        NSLog(@"点击退出了");
                                                        [LoginUserInfoModel cacheLoginModel:nil];
                                                        [self updateLoginStatus:NO];
                                                    }];
    [alert addAction:cancel];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)login {
    LoginViewController *loginVC = [LoginViewController new];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}
@end
