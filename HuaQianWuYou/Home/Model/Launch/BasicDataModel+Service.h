//
//  BasicDataModel+Service.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "BasicDataModel.h"
#define key @"versionStamp"

@interface BasicDataModel (Service)
    
    
/**
 获取广告信息

 @param type 广告类型
 @param productId 产品id 只有当type为20，需传值。当天第一次访问该接口，可不传，非第一次访问，传上一次该接口返回的id参数值
 @param sort 分类排序  只有当type为20，需传值。当天第一次访问该接口，传“0”，非第一次访问，传上一次该接口返回的sort参数值
 @param completion 完成回调
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *_Nullable)requestBasicData:(AdvertisingType)type
                                          productId:(NSNumber *)productId
                                               sort:(NSNumber *)sort
                                         Completion:(nullable void (^)(BasicDataModel *_Nullable result,
                                                                                 NSError *_Nullable error))completion;
@end
