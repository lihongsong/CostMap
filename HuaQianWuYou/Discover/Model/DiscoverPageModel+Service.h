//
//  DiscoverPageModel+Service.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/21.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "DiscoverPageModel.h"

@interface DiscoverPageModel (Service)

+ (NSURLSessionDataTask *_Nullable)requestDiscoverPageModelCompletion:(nullable void (^)(DiscoverPageModel *_Nullable result, NSError *_Nullable error))completion;
@end
