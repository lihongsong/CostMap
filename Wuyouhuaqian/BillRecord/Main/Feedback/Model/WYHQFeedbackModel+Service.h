//
//  WYHQFeedbackModel+Service.h
//  WuYouQianBao
//
//  Created by jasonzhang on 2018/5/30.
//  Copyright © 2018年 jasonzhang. All rights reserved.
//

#import "WYHQFeedbackModel.h"

@interface WYHQFeedbackModel (Service)

+ (NSURLSessionDataTask *_Nullable)requestFeedbackWithAccount:(NSString *)account
                                                 adviceString:(NSString *)adviceString
                                                   Completion:(nullable void (^)(WYHQFeedbackModel *_Nullable result,
                                                                                 NSError *_Nullable error))completion;
@end
