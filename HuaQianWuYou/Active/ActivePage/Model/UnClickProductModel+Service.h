//
//  UnClickProductModel+Service.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/11.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "UnClickProductModel.h"

@interface UnClickProductModel (Service)

/**
 未点击产*品接口
 
 @param category 类别
 @param mobilePhone 手机号
 @param completion <#completion description#>
 @return <#return value description#>
 */

+ (NSURLSessionDataTask *_Nullable)getUnClickProductList:(NSNumber *)category mobilePhone:(NSString*)mobilePhone Completion:(nullable void (^)(NSArray *_Nullable result,
                                                                         NSError *_Nullable error))completion;
@end
