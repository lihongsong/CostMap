//
//  CostMapChartSceneModel.m
//  CostMap
//
//

#import "CostMapChartLineSceneModel.h"
#import "CostMapSQLManager.h"

@implementation CostMapChartLineSceneModel

- (RACSubject *)yka_requestLineDataWithType:(CostMapChartType)type {
    
    RACReplaySubject *subject = [RACReplaySubject new];
    
    NSString *year = @([[NSDate hj_getToday] hj_year]).stringValue;
    NSString *month = @([[NSDate hj_getToday] hj_month]).stringValue;
    
    [[CostMapSQLManager share]
     searchData:kSQLTableName
     year:year
     month:type == CostMapChartYear ? nil : month
     day:nil
     result:^(NSMutableArray<CostMapOrderEntity *> *result, NSError *error) {
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
