//
//  DiscoverDetailModel+Service.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "DiscoverDetailModel+Service.h"

@implementation DiscoverDetailModel (Service)
+ (NSURLSessionDataTask *_Nullable)requestDiscoverDetailModelWithArticalId:(NSString *)articalId
                                                                Completion:(nullable void (^)(DiscoverDetailModel *_Nullable result, NSError *_Nullable error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"articleDetail" forKey:@"a"];
    [dict setValue:@"hqwy" forKey:@"m"];
    [dict setValue:@"shell" forKey:@"c"];
    [dict setValue:articalId forKey:@"id"];
    NSURLSessionDataTask *task = [self ln_requestAPI:@""
                                              method:HTTP_GET
                                          parameters:dict
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                                 
                                                 completion(responseObject, nil);
                                             } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                 completion(nil,error);
                                             }];
    
    return task;
}
@end
