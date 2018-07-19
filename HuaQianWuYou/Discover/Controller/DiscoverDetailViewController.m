//
//  DiscoverDetailViewController.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "DiscoverDetailViewController.h"
#import "DiscoverDetailTopView.h"
#import "DiscoverDetailModel.h"
#import "DiscoverDetailModel+Service.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DiscoverDetailViewController ()
@property(nonatomic, strong) UIScrollView *bgScrollView;
@property(nonatomic, strong) DiscoverDetailTopView *topView;
@property(nonatomic, strong) UITextView *articalView;
@property(nonatomic, strong) MASConstraint *articlViewHeight;
@property(nonatomic, strong) DiscoverDetailModel *dataModel;
@property(nonatomic, strong) UIImageView *themeImageView;
@end

@implementation DiscoverDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    [self requestData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpUI {
    self.title = @"发现";
    WeakObj(self);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont NavigationTitleFont], NSForegroundColorAttributeName: [UIColor blackColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];

    [_bgScrollView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.mas_equalTo(self.bgScrollView);
        make.size.mas_equalTo(CGSizeMake(SWidth, 120));
    }];
    
    [_bgScrollView addSubview:self.themeImageView];
    [self.themeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SWidth, 200));
        make.top.mas_equalTo(self.topView.mas_bottom);
    }];

    [_bgScrollView addSubview:self.articalView];
    [self.articalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgScrollView.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.top.mas_equalTo(self.themeImageView.mas_bottom);
    }];
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

- (void)requestData {
    [KeyWindow ln_showLoadingHUD];
    WeakObj(self);
    [DiscoverDetailModel requestDiscoverDetailModelWithArticalId:self.articalId
                                                      Completion:^(DiscoverDetailModel * _Nullable result, NSError * _Nullable error) {
                                                          StrongObj(self);
                                                          [KeyWindow ln_hideProgressHUD];
                                                          if (error) {
                                                             [KeyWindow ln_showToastHUD:error.userInfo[@"msg"]];
                                                              self.defaultView.hidden = NO;
                                                              return ;
                                                          }
                                                          if (result) {
                                                              self.defaultView.hidden = YES;
                                                              self.dataModel = result;
                                                          }
                                                      }];
}


#pragma - mark setter && getter

- (UIScrollView *)bgScrollView {
    if (!_bgScrollView) {
        _bgScrollView = [UIScrollView new];
    }
    return _bgScrollView;
}

- (DiscoverDetailTopView *)topView {
    if (!_topView) {
        _topView = [DiscoverDetailTopView new];
    }
    return _topView;
}

- (UIImageView *)themeImageView {
    if (!_themeImageView) {
        _themeImageView = [UIImageView new];
    }
    return _themeImageView;
}

- (UITextView *)articalView {
    if (!_articalView) {
        _articalView = [UITextView new];
        _articalView.editable = NO;
        _articalView.font = [UIFont systemFontOfSize:17];
        _articalView.scrollEnabled = NO;
    }
    return _articalView;
}

- (void)setDataModel:(DiscoverDetailModel *)dataModel {
    _dataModel = dataModel;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 15;
    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName: paragraphStyle
                                 };
    NSString *articalString = dataModel.content;
    self.articalView.attributedText = [[NSAttributedString alloc] initWithString:articalString
                                                                      attributes:attributes];
    [self.topView updataInfoWithModel:dataModel];
    [self.themeImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.thumb_img_path]];
}
@end
