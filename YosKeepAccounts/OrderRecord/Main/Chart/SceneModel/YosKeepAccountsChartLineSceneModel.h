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

typedef NS_ENUM(NSInteger, YosKeepAccountsChartLineType) {
    YosKeepAccountsChartLineUnknow = 0,
    YosKeepAccountsChartLineMonth = 1,
    YosKeepAccountsChartLineYear = 2,
};

NS_ASSUME_NONNULL_BEGIN

@interface YosKeepAccountsChartLineSceneModel : NSObject

@property (assign, nonatomic) CGFloat totalAccount;

@property (strong, nonatomic) NSArray <YosKeepAccountsChartLineEntity *> *lineEntitys;

@property (assign, nonatomic) YosKeepAccountsChartLineType type;

- (RACSubject *)yka_requestLineDataWithType:(YosKeepAccountsChartLineType)type;

@end

NS_ASSUME_NONNULL_END
