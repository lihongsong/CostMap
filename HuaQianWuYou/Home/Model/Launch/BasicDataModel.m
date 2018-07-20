//
//  BasicDataModel.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "BasicDataModel.h"
#import "YYModel.h"

@implementation BasicDataModel

+ (NSDictionary*)modelCustomPropertyMapper {
    return @{
             @"productId": @"id",
             @"productName": @"description",
             };
}

+ (void)cacheToLoacl:(BasicDataModel *)model withType:(AdvertisingType)type{
    NSData *jsonData = [model yy_modelToJSONData];
    NSString  *key = [NSString stringWithFormat:@"dataList%ld",(long)type];
    UserDefaultSetObj(jsonData, key);
    if (type == AdvertisingTypeAlert) {
        UserDefaultSetObj([NSDate hj_stringWithDate:[NSDate date] format:@"yyyyMMdd"], @"advertisementDate");
    }
}

+ (BasicDataModel *)getCacheModel:(AdvertisingType)type{
    NSString  *key = [NSString stringWithFormat:@"dataList%ld",(long)type];
    NSData *jsonData = UserDefaultGetObj(key);
    return  [BasicDataModel yy_modelWithJSON:jsonData];
}

@end
