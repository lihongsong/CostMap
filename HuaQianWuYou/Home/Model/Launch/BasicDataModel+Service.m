//
//  BasicDataModel+Service.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "BasicDataModel+Service.h"

@implementation BasicDataModel (Service)

    + (NSString *)ln_APIServer {
        return HQWY_PRODUCT_PATH;
    }

    +(NSURLSessionDataTask *)requestBasicData:(AdvertisingType)type productId:(NSNumber *)productId sort:(NSNumber *)sort Completion:(void (^)(BasicDataModel * _Nullable, NSError * _Nullable))completion{
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[NSNumber numberWithInt:type] forKey:@"category"];
        [dict setValue:productId ? productId : @0 forKey:@"pId"];
        [dict setValue:sort ? sort : @0 forKey:@"sort"];
        NSURLSessionDataTask *task = [self ln_requestModelAPI:AdvertisingInfo
                                                       method:HTTP_POST
                                                   parameters:dict
                                                   completion:^(id _Nonnull responseObject, NSError *_Nonnull error) {
                                                       completion(responseObject, error);
                                                       BasicDataModel *_Nullable dataModel = (BasicDataModel *_Nullable)responseObject;
                                                       if (ObjIsNilOrNull(dataModel)) {
                                                       }else{
                                                           NSLog(@"_______%ld",(long)type);
                                                           if (type == AdvertisingTypeAlert) {
                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                   [BasicDataModel cacheToLoacl:dataModel withType:type];
                                                               });
                                                           }
                                                       }
                                                   }];
        return task;
    }
@end
