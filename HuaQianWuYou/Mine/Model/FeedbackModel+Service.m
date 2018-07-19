//
//  FeedbackModel+Service.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/23.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "FeedbackModel+Service.h"

@implementation FeedbackModel (Service)
+ (NSURLSessionDataTask *_Nullable)requestFeedbackWithAccount:(NSString *)account
                                                 adviceString:(NSString *)adviceString
                                                   Completion:(nullable void (^)(FeedbackModel *_Nullable result,
                                                                             NSError *_Nullable error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:SafeStr(account) forKey:@"account"];
    [dict setValue:SafeStr(adviceString) forKey:@"adviceString"];
    [dict setValue:@"advice" forKey:@"a"];
    [dict setValue:@"hqwy" forKey:@"m"];
    [dict setValue:@"shell" forKey:@"c"];
    NSURLSessionDataTask *task = [self ln_requestAPI:@""
                                              method:HTTP_POST
                                          parameters:dict
                                             success:^(NSURLSessionDataTask *_Nonnull task, id _Nonnull responseObject) {
                                                 completion(responseObject, nil);
                                             } failure:^(NSURLSessionDataTask *_Nonnull task, NSError *_Nonnull error) {
                                                 completion(nil, error);
                                             }];
    return task;
}
@end
