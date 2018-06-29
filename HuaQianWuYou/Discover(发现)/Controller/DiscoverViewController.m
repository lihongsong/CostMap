//
//  DiscoverViewController.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/14.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "DiscoverViewController.h"
#import "TopBannerView.h"
#import "DiscoverTableViewCell.h"
#import "DiscoverDetailViewController.h"
#import "DiscoverTopBannerCell.h"
#import "DiscoverPageModel.h"
#import "DiscoverPageModel+Service.h"

@interface DiscoverViewController () <TopBannerViewProtocol, UITableViewDelegate, UITableViewDataSource, DiscoverTopBannerCellProtocol>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) DiscoverPageModel *dataModel;

@end

@implementation DiscoverViewController

#pragma - mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)requestData {
    WeakObj(self);
    [KeyWindow ln_showLoadingHUD];
    [DiscoverPageModel requestDiscoverPageModelCompletion:^(DiscoverPageModel *_Nullable result, NSError *_Nullable error) {
        StrongObj(self);
        [KeyWindow ln_hideProgressHUD];
        if (error) {
            [KeyWindow ln_showToastHUD:error.userInfo[@"msg"]];
            self.defaultView.hidden = NO;
            return;
        }
        if (result) {
            self.dataModel = result;
            [self.tableView reloadData];
            self.defaultView.hidden = YES;
        }
    }];
}

- (void)setUpUI {
    WeakObj(self);
    self.title = @"发现";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self setLelftNavigationItem:YES];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont NavigationTitleFont], NSForegroundColorAttributeName: [UIColor blackColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.view addSubview:self.defaultView];
    [self.defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    self.defaultView.hidden = YES;
    self.defaultView.reloadBlock = ^{
        StrongObj(self);
        [self requestData];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - mark setter && getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma - mark TopBannerViewProtocol

- (void)didSelected:(DiscoverTopBannerCell *)bannerView atIndex:(NSInteger)index {
    
    BannerModel *model = bannerView.bannerView.modelArray[index];
    DiscoverDetailViewController *vc = [DiscoverDetailViewController new];
    vc.articalId = model.articalId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma - mark UITableviewDelegate && UITableviewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModel.discoverList.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverTableViewCell"];
        if (!cell) {
            cell = [[DiscoverTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DiscoverTableViewCell"];
        }
        [cell updateCellModel:self.dataModel.discoverList[indexPath.row - 1]];
        return cell;
    } else {
        DiscoverTopBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverTopBannerCell"];
        if (!cell) {
            cell = [[DiscoverTopBannerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DiscoverTopBannerCell"];
        }
        cell.bannerViewDelegate = self;
        cell.bannerView.modelArray = self.dataModel.banner;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        return 100.0f;
    } else {
        return 200.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverDetailViewController *vc = [DiscoverDetailViewController new];
    NSInteger index = indexPath.row;
    index = index>=0?index:_dataModel.banner.count - 1;
    vc.articalId = self.dataModel.discoverList[index].articalId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.dataModel.discoverList.count > 0) {
        return 52.0f;
    } else {
        return 0.0001f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [UIView new];
    UIView *bgView = [UIView new];
    [footerView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SWidth);
         make.height.mas_equalTo(52);
        make.edges.mas_equalTo(0);
    }];
    bgView.backgroundColor = HJHexColor(0xf2f2f2);
    UILabel *tipLabel = [UILabel new];
    [footerView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(footerView);
//        make.width.height.mas_equalTo(70);
        make.top.mas_equalTo(bgView.mas_top).mas_offset(15);
        make.bottom.mas_equalTo(bgView.mas_bottom).mas_offset(-15);
    }];
    tipLabel.text = @"已经到底啦";
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.textColor = HJHexColor(0x999999);
    tipLabel.textAlignment = NSTextAlignmentCenter;
    UIView *leftLine = [UIView new];
    [bgView addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgView.mas_left).mas_offset(52);
        make.right.mas_equalTo(tipLabel.mas_left).mas_offset(-5);
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(bgView.mas_centerY);
    }];
    leftLine.backgroundColor = HJHexColor(0xe6e6e6);
    
    UIView *rightLine = [UIView new];
    [bgView addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgView.mas_centerY);
        make.right.mas_equalTo(bgView.mas_right).mas_offset(-52);
        make.left.mas_equalTo(tipLabel.mas_right).mas_offset(5);
        make.height.mas_equalTo(leftLine.mas_height);
    }];
    rightLine.backgroundColor = HJHexColor(0xe6e6e6);
    
    return footerView;
}

@end
