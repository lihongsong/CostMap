//
//  YosKeepAccountChartPresenter.m
//  YosKeepAccounts
//
//  Created by yoser on 2019/3/25.
//  Copyright © 2019 yoser. All rights reserved.
//

#import "YosKeepAccountChartPresenter.h"
#import "YosKeepAccountsChartBrokenLineScene.h"
#import "YosKeepAccountsChartLineSceneModel.h"

@interface YosKeepAccountChartPresenter ()

@property (strong, nonatomic) YosKeepAccountsChartLineSceneModel *viewModel;

@property (strong, nonatomic) YosKeepAccountsChartBrokenLineScene *chartLineScene;

@end

@implementation YosKeepAccountChartPresenter

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    [self setUpRAC];
}

- (void)setUpRAC {
    
    _viewModel = [YosKeepAccountsChartLineSceneModel new];
    _viewModel.type = YosKeepAccountsChartLineYear;
    
    WEAK_SELF
    [RACObserve(_viewModel, lineEntitys) subscribeNext:^(NSArray <YosKeepAccountsChartLineEntity *> *entitys) {
        STRONG_SELF
        self.chartLineScene.entitys = entitys;
    }];
}

- (void)setUpUI {
    
    [self.view addSubview:self.chartLineScene];
    
    [self.chartLineScene mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

- (YosKeepAccountsChartBrokenLineScene *)chartLineScene {
    if (!_chartLineScene) {
        _chartLineScene = [YosKeepAccountsChartBrokenLineScene new];
    }
    return _chartLineScene;
}


@end
