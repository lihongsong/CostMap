//
//  QBFeedbackModel+Service.m
//  WuYouQianBao
//
//  Created by jasonzhang on 2018/5/30.
//  Copyright © 2018年 jasonzhang. All rights reserved.
//

#import "QBFeedbackModel+Service.h"

@implementation QBFeedbackModel (Service)

+ (NSURLSessionDataTask *_Nullable)requestFeedbackWithAccount:(NSString *)account
                                                 adviceString:(NSString *)adviceString
                                                   Completion:(nullable void (^)(QBFeedbackModel *_Nullable result,
                                                                                 NSError *_Nullable error))completion {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:SafeStr(account) forKey:@"account"];
    [dict setValue:SafeStr(adviceString) forKey:@"adviceString"];
    [dict setValue:@"advice" forKey:@"a"];
    [dict setValue:@"hqwy" forKey:@"m"];
    [dict setValue:@"shell" forKey:@"c"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion([QBFeedbackModel new], nil);
    });
    
    return nil;
}
@end
