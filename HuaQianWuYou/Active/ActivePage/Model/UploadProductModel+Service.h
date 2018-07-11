//
//  UploadProductModel+Service.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/11.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "UploadProductModel.h"

@interface UploadProductModel (Service)
+ (NSURLSessionDataTask *_Nullable)uploadProduct:(NSNumber *)category mobilePhone:(NSString*)mobilePhone productID:(NSNumber *)productId Completion:(nullable void (^)(UploadProductModel *_Nullable result,
                                                                                                                                               NSError *_Nullable error))completion;
@end
