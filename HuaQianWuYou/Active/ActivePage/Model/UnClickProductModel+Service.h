//
//  UnClickProductModel+Service.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/11.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "UnClickProductModel.h"

@interface UnClickProductModel (Service)
+ (NSURLSessionDataTask *_Nullable)getUnClickProductList:(NSNumber *)category mobilePhone:(NSString*)mobilePhone Completion:(nullable void (^)(UnClickProductModel *_Nullable result,
                                                                         NSError *_Nullable error))completion;
@end