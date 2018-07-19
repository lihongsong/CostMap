//
//  QBBasicConfigModel+Service.h
//  WuYouQianBao
//
//  Created by jasonzhang on 2018/6/5.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "BasicConfigModel.h"

@interface BasicConfigModel (Service)
+ (NSURLSessionDataTask *_Nullable)requestBasicConfigCompletion:(nullable void (^)(BasicConfigModel *_Nullable result,
                                                                                   NSError *_Nullable error))completion;
@end
