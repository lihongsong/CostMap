//
//  FeedbackModel+Service.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/23.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "FeedbackModel.h"

@interface FeedbackModel (Service)
+ (NSURLSessionDataTask *_Nullable)requestFeedbackWithAccount:(NSString *_Nullable)account
                                                 adviceString:(NSString *_Nullable)adviceString
                                                   Completion:(nullable void (^)(FeedbackModel *_Nullable result,
                                                                                 NSError *_Nullable error))completion;
@end
