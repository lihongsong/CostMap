//
//  YosKeepAccountsChartLineSceneModel.h
//  YosKeepAccounts
//
//  Created by yoser on 2019/3/25.
//  Copyright © 2019 yoser. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YosKeepAccountsChartLineEntity;

@class RACSubject;

typedef NS_ENUM(NSInteger, YosKeepAccountsChartType) {
    YosKeepAccountsChartUnknow = 0,
    YosKeepAccountsChartDay = 1,
    YosKeepAccountsChartMonth = 2,
    YosKeepAccountsChartYear = 3,
};

NS_ASSUME_NONNULL_BEGIN

@interface YosKeepAccountsChartLineSceneModel : NSObject

@property (assign, nonatomic) CGFloat totalAccount;

@property (assign, nonatomic) YosKeepAccountsChartType type;

- (RACSubject *)yka_requestLineDataWithType:(YosKeepAccountsChartType)type;

@end

NS_ASSUME_NONNULL_END
