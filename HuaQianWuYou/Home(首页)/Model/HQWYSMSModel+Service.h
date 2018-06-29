//
//  InvestigationSMSModel+Service.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "HQWYSMSModel.h"

@interface HQWYSMSModel (Service)
+ (NSURLSessionDataTask *_Nullable)requestSMSCodeWithMobile:(NSString *)mobile
                                                 Completion:(nullable void (^)(id _Nullable result,
                                                                               NSError *_Nullable error))completion;
@end
