//
//  HomeDataModel+Service.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/21.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "HomeDataModel.h"

@interface HomeDataModel (Service)
+ (NSURLSessionDataTask *_Nullable)requestHomePageModelWithAccountName:(NSString *)accountName
                                                         Completion:(nullable void (^)(HomeDataModel *_Nullable result,
                                                                                       NSError *_Nullable error))completion;
@end
