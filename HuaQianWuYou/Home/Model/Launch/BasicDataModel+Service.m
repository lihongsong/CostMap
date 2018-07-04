//
//  BasicDataModel+Service.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "BasicDataModel+Service.h"

@implementation BasicDataModel (Service)
+ (NSURLSessionDataTask *_Nullable)requestBasicData:(AdvertisingType)type Completion:(nullable void (^)(BasicDataModel *_Nullable result,
                                                                                 NSError *_Nullable error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"homeSet" forKey:@"a"];
    [dict setValue:@"hqwy" forKey:@"m"];
    [dict setValue:@"shell" forKey:@"c"];
    [dict setValue:[NSNumber numberWithInteger:type] forKey:@"type"];
    NSURLSessionDataTask *task = [self ln_requestModelAPI:@""
                                                   method:HTTP_POST
                                               parameters:dict
                                               completion:^(id _Nonnull responseObject, NSError *_Nonnull error) {
                                                   completion(responseObject, error);
                                                    BasicDataModel *_Nullable dataModel = (BasicDataModel *_Nullable)responseObject;
                                                   if (ObjIsNilOrNull(dataModel)  || ObjIsNilOrNull(dataModel.versionStamp)|| ArrIsEmpty(dataModel.acitveList)) {
                                                   }else{
                                                       if (type != AdvertisingTypeSuspensionWindow) {
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               [BasicDataModel cacheToLoacl:dataModel withType:type];
                                                           });
                                                       }
                                                   }
                                               }];
    return task;
}
@end
