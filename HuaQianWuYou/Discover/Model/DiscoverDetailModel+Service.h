//
//  DiscoverDetailModel+Service.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "DiscoverDetailModel.h"

@interface DiscoverDetailModel (Service)
+ (NSURLSessionDataTask *_Nullable)requestDiscoverDetailModelWithArticalId:(NSString *_Nullable)articalId
                                                                Completion:(nullable void (^)(DiscoverDetailModel *_Nullable result, NSError *_Nullable error))completion;
@end
