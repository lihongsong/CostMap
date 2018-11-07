//
//  QBFeedbackModel+Service.h
//  WuYouQianBao
//
//  Created by jasonzhang on 2018/5/30.
//  Copyright © 2018年 jasonzhang. All rights reserved.
//

#import "QBFeedbackModel.h"

@interface QBFeedbackModel (Service)

+ (NSURLSessionDataTask *_Nullable)requestFeedbackWithAccount:(NSString *)account
                                                 adviceString:(NSString *)adviceString
                                                   Completion:(nullable void (^)(QBFeedbackModel *_Nullable result,
                                                                                 NSError *_Nullable error))completion;
@end
