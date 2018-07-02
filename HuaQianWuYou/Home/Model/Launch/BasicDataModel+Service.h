//
//  BasicDataModel+Service.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "BasicDataModel.h"
#define key @"versionStamp"

@interface BasicDataModel (Service)
+ (NSURLSessionDataTask *_Nullable)requestBasicData:(AdvertisingType)type Completion:(nullable void (^)(BasicDataModel *_Nullable result,
                                                                                 NSError *_Nullable error))completion;
@end
