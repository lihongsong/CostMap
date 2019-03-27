//
//  YosKeepAccountsChartSceneModel.m
//  YosKeepAccounts
//
//  Created by yoser on 2019/3/25.
//  Copyright © 2019 yoser. All rights reserved.
//

#import "YosKeepAccountsChartLineSceneModel.h"
#import "YosKeepAccountsSQLManager.h"

@implementation YosKeepAccountsChartLineSceneModel

- (RACSubject *)yka_requestLineDataWithType:(YosKeepAccountsChartType)type {
    
    RACReplaySubject *subject = [RACReplaySubject new];
    
    NSString *year = @([[NSDate hj_getToday] hj_year]).stringValue;
    NSString *month = @([[NSDate hj_getToday] hj_month]).stringValue;
    
    [[YosKeepAccountsSQLManager share]
     searchData:kSQLTableName
     year:year
     month:type == YosKeepAccountsChartYear ? nil : month
     day:nil
     result:^(NSMutableArray<YosKeepAccountsOrderEntity *> *result, NSError *error) {
         if (error) {
             [subject sendError:error];
             return ;
         }
         
         [subject sendNext:result];
         [subject sendCompleted];
     }];
    
    return subject;
}

@end
