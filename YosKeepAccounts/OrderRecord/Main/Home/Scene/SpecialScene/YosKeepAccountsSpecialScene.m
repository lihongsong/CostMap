//
//  YosKeepAccountsSpecialScene.m
//  YosKeepAccounts
//
//  Created by yoser on 2019/3/25.
//  Copyright © 2019 yoser. All rights reserved.
//

#import "YosKeepAccountsSpecialScene.h"
#import "YosKeepAccountsRightItemButton.h"
#import "YosKeepAccountsLeftItemButton.h"
#import "YosKeepAccountsApplyRecordCell.h"
#import "YosKeepAccountsCredictUsingRateCell.h"
#import "YosKeepAccountsHomeBaseListCell.h"
#import "YosKeepAccountsCircleProgressScene.h"
#import "YosKeepAccountsCircle.h"
#import "YosKeepAccountsWaveAnimationScene.h"
#import "YosKeepAccountsCircleIndicatorScene.h"
#import "YosKeepAccountsWangYiWave.h"
#import "YosKeepAccountsCircleIndicatorScene.h"
#import "YosKeepAccountsNameHeaderScene.h"
#import "YosKeepAccountsScoreProgressScene.h"
#import "YosKeepAccountsBaseChartScene.h"
#import "YosKeepAccountsGradientCompareBarScene.h"
#import "YosKeepAccountsAreaSplineChartScene.h"
#import "YosKeepAccountsAreaSplineCompareScene.h"

@implementation YosKeepAccountsSpecialScene

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:[YosKeepAccountsLeftItemButton new]];
        [self addSubview:[YosKeepAccountsRightItemButton new]];
        [self addSubview:[YosKeepAccountsApplyRecordCell new]];
        [self addSubview:[YosKeepAccountsCredictUsingRateCell new]];
        [self addSubview:[YosKeepAccountsHomeBaseListCell new]];
        [self addSubview:[YosKeepAccountsCircleProgressScene new]];
        [self addSubview:[YosKeepAccountsCircle new]];
        [self addSubview:[YosKeepAccountsWaveAnimationScene new]];
        [self addSubview:[YosKeepAccountsCircleIndicatorScene new]];
        [self addSubview:[YosKeepAccountsWangYiWave new]];
        [self addSubview:[YosKeepAccountsNameHeaderScene new]];
        [self addSubview:[YosKeepAccountsScoreProgressScene new]];
        [self addSubview:[YosKeepAccountsBaseChartScene new]];
        [self addSubview:[YosKeepAccountsGradientCompareBarScene new]];
        [self addSubview:[YosKeepAccountsAreaSplineChartScene new]];
        [self addSubview:[YosKeepAccountsAreaSplineCompareScene new]];
        
        self.hidden = YES;
    }
    return self;
}

@end
