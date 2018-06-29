//
//  HomeDataModel+Service.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/21.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "HomeDataModel+Service.h"
#import "NSObject+YYModel.h"

@implementation HomeDataModel (Service)
+ (NSURLSessionDataTask *_Nullable)requestHomePageModelWithAccountName:(NSString *)accountName
                                                         Completion:(nullable void (^)(HomeDataModel *_Nullable result,
                                                                                       NSError *_Nullable error))completion{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:accountName forKey:@"accountName"];
    [dict setValue:@"creditReport" forKey:@"a"];
    [dict setValue:@"hqwy" forKey:@"m"];
    [dict setValue:@"shell" forKey:@"c"];
    [dict setValue:accountName forKey:@"accountName"];
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
