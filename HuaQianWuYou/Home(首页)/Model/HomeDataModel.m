//
//  HomeDataModel.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "HomeDataModel.h"

@implementation HomeDataModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
             @"communicationActive": [CommunicationActiveModel class],
             @"credictCheckRecond": [CredictCheckRecondModel class],
             @"credictLendRecord": [CredictLendRecord class],
             @"credictUseRate": [NSString class],
             @"credictApplyRecode": [NSString class],
             @"communicationDistribution": [NSString class],
             };
}
@end

@implementation CommunicationActiveModel
@end

@implementation CredictCheckRecondModel
@end

@implementation CredictLendRecord
@end
