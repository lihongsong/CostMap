//
//  HomeViewController.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/9.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "HomeViewController.h"
#import "CircleIndicatorView.h"
#import "HomeScoreHeaderView.h"
#import "HomeBaseTableViewCell.h"
#import "HomeDataModel.h"
#import "NameHeaderView.h"
#import "AreaSplineChartView.h"
#import "GradientCompareBarView.h"
#import "CircleProgressView.h"
#import "CredictUsingRateCell.h"
#import "ApplyRecordCell.h"
#import "LoamLendRecordCell.h"
#import "CInvestigationOneViewController.h"
#import "HomeDataModel.h"
#import "HomeDataModel+Service.h"
#import "LoginInfoModel.h"
#import "LoginViewController.h"

#define leftSpace 63     // 圆环拒左边距离
#define HeaderHeight  280    // header 高度
#define HomeTabBarHeight (self.isCheckMyReport == true ? 0 : TabBarHeight)
#define FooterHeight (self.isCheckMyReport == true ?0 : 48)

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate,HomeScoreHeaderViewDelegate>
@property(nonatomic,strong)BaseTableView *homeTB;
@property(nonatomic,strong)HomeScoreHeaderView *headerView;
@property(nonatomic,strong)NameHeaderView *nameHeader;

@property(nonatomic,strong)UIButton *footerButton;

@property(nonatomic,strong)HomeDataModel *dataModel;
@property(nonatomic,strong)LoginUserInfoModel *userInfo;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.isCheckMyReport) {
        self.navigationItem.title = @"我的报告";
    } else {
        self.navigationItem.title = @"示例报告";
    }
    self.view.backgroundColor = [UIColor homeBGColor];
    self.userInfo = [LoginUserInfoModel cachedLoginModel];
    [self createHomeUI];
    [self setLelftNavigationItem:YES];
    if (!self.userInfo) {
        self.headerView.progress = 0.5;
        [self.headerView startAnimation];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}

-(void)createHomeUI{
    self.homeTB = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SWidth, SHeight - HomeTabBarHeight - NavigationHeight - FooterHeight) style:UITableViewStyleGrouped];
    self.homeTB.delegate = self;
    self.homeTB.dataSource = self;
    self.homeTB.tableHeaderView = self.headerView;
    self.homeTB.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.homeTB.backgroundColor = [UIColor homeBGColor];
    self.homeTB.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.homeTB];
    if (FooterHeight == 48) {
        self.footerButton = [ZYZControl createButtonWithFrame:CGRectMake(0, CGRectGetMaxY(self.homeTB.frame), SWidth, FooterHeight) target:self SEL:@selector(footerClick) title:@"查看我的报告"];
        self.footerButton.titleLabel.font = [UIFont navigationRightFont];
        [self.footerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //self.footerButton.backgroundColor = [UIColor skinColor];
        [self.footerButton setBackgroundImage:[UIImage imageNamed:@"home_btn_pop"] forState:UIControlStateNormal];
       [self.footerButton setBackgroundImage:[UIImage imageNamed:@"home_btn_pop"] forState:UIControlStateHighlighted];
        [self.view addSubview:self.footerButton];
    }
    self.homeTB.sectionFooterHeight = 0.01;
    self.homeTB.sectionHeaderHeight = 0.01;
}

-(HomeScoreHeaderView*)headerView
{
    if (_headerView  == nil) {
        _headerView = [[HomeScoreHeaderView alloc]initWithFrame:CGRectMake(0, 0, SWidth, HeaderHeight)];
        _headerView.delegate = self;
        _headerView.progress = 0.5;
        _headerView.isCheckMyReport = self.isCheckMyReport;
    }
    return _headerView;
}

- (NameHeaderView *)nameHeader
{
    if (_nameHeader  == nil) {
        _nameHeader = [[NameHeaderView alloc]initWithFrame:CGRectMake(0, 0, SWidth, 80)];
        _nameHeader.backgroundColor = [UIColor colorFromHexCode:@"#f9f9f9"];
        ;
    }
    return _nameHeader;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.isCheckMyReport) {
        [self setLelftNavigationItemWithImageName:@"public_back_01_" hidden:NO];
    } else {
        [self setLelftNavigationItem:!self.isCheckMyReport];
    }

    self.navigationController.navigationBar.barTintColor = [UIColor skinColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont NavigationTitleFont], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.userInfo = [LoginUserInfoModel cachedLoginModel];
    //self.headerView.waveView.timer.paused = false;

    if (self.userInfo) {
        [self requestData];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)requestData {
    WeakObj(self);
    [KeyWindow ln_showLoadingHUD];
    NSString *mobile = @"";
    if (self.userInfo != nil) {
        mobile = self.userInfo.mobile;
    }
    [HomeDataModel requestHomePageModelWithAccountName:mobile
                                            Completion:^(HomeDataModel * _Nullable result, NSError * _Nullable error) {
                                                StrongObj(self);
                                                [KeyWindow ln_hideProgressHUD];
                                                if (error) {
                                                    [KeyWindow ln_showToastHUD:error.userInfo[@"msg"]];
                                                    self.headerView.progress = 0.5;
                                                    [self.headerView startAnimation];
                                                    [self.homeTB reloadData];
                                                    return ;
                                                }
                                                self.dataModel = result;
                                                NSLog(@"%@",result);
                                                [self loadUIData];
                                                [self.homeTB reloadData];
                                            }];
}

-(void)loadUIData{
    if (self.isCheckMyReport && [self.dataModel.credictUseRate count] > 0) {
        self.headerView.progress = self.dataModel.creditScore.integerValue/100.0;
        self.headerView.time = [NSString stringWithFormat:@"评估时间:%@",self.dataModel.evaluationTime];
        self.headerView.status = self.dataModel.creditStatus;
        if(self.userInfo.username.length > 0){
            self.nameHeader.nameLabel.text = [NSString stringWithFormat:@"Hi, %@ 先生",self.userInfo.username];
        }else{
            self.nameHeader.nameLabel.text = [NSString stringWithFormat:@"Hi, %@",self.userInfo.mobile];
        }
        [self.headerView startAnimation];
    }else{
        self.headerView.progress = 0.5;
        [self.headerView startAnimation];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 370;
    }else if(indexPath.row == 1){
        return CircleCellHeight;
    }else if(indexPath.row == 2){
        return 395;
    }else if(indexPath.row == 3){
        return 395;
    }
    return 385;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.dataModel != nil &&[self.dataModel.credictUseRate count] > 0) {
        self.nameHeader.exampleImage.hidden = true;
    }else{
        self.nameHeader.exampleImage.hidden = false;
    }
    return self.nameHeader;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        static NSString *cellID = @"CredictUsingRateCellIdentity";
        CredictUsingRateCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[CredictUsingRateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell config:self.dataModel example:self.isCheckMyReport withType:(cellType)indexPath.row];
        return cell;
    }else if (indexPath.row == 1){
        static NSString *cellID = @"applyRecordCellIdentity";
        ApplyRecordCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ApplyRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell config:self.dataModel example:self.isCheckMyReport withType:(cellType)indexPath.row];
        return cell;
    }else if (indexPath.row == 2){
        static NSString *cellID = @"LoamLendRecordCellIdentity";
        LoamLendRecordCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[LoamLendRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell config:self.dataModel example:self.isCheckMyReport withType:(cellType)indexPath.row];
        return cell;
    }else{
        static NSString *cellID = @"HomeTableViewCellIdentity";
        HomeBaseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[HomeBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell config:self.dataModel example:self.isCheckMyReport withType:(cellType)indexPath.row];
        return cell;
    }
    
//    else{
//        while ([cell.contentView.subviews lastObject] != nil) {
//            NSLog(@"_____%@",[cell.contentView.subviews lastObject]);
//            [[cell.contentView.subviews lastObject] removeFromSuperview];
//        }
//    }
}

-(void)footerClick{
    NSLog(@"_____%@",self.dataModel);
    if (self.userInfo != nil) {
        if ([self.dataModel.credictUseRate count] > 0) {
            HomeViewController *myReportVC = [[HomeViewController alloc]init];
            myReportVC.isCheckMyReport = true;
            myReportVC.backBlock = ^{
                self.isCheckMyReport = false;
            };
            myReportVC.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:myReportVC animated:true];
        }else{
            CInvestigationOneViewController *continueCheckReportVC = [CInvestigationOneViewController new];
            continueCheckReportVC.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:continueCheckReportVC animated:YES];
        }
    }else{
        LoginViewController *logVC = [LoginViewController new];
        logVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:logVC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    //self.headerView.waveView.timer.paused = true;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //self.headerView.waveView.timer.paused = true;
}

#pragma mark HomeScoreHeaderViewDelegate
-(void)continueCheckMyReport{
    CInvestigationOneViewController *continueCheckReportVC = [CInvestigationOneViewController new];
    [self.navigationController pushViewController:continueCheckReportVC animated:YES];
}

-(void)backPage {
    self.backBlock();
    [self.navigationController popViewControllerAnimated:YES];
}

@end
