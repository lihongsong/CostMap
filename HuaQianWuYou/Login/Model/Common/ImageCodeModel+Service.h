//
//  ImageCodeModel+Service.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/16.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "ImageCodeModel.h"

@interface ImageCodeModel (Service)
/**
 获取图形验证
 
 @param completion <#completion description#>
 @return <#return value description#>
 */
+ (NSURLSessionDataTask *_Nullable)requsetImageCodeCompletion:(nullable void (^)(ImageCodeModel *_Nullable result,NSError *_Nullable error))completion;
@end
