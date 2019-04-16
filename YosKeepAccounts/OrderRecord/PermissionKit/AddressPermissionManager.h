//
//  AddressPermissionManager.h
//  YosKeepAccounts
//
//  Created by shenz on 2019/4/16.
//  Copyright © 2019年 yoser. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressPermissionManager : NSObject
//请求通讯录权限
+ (instancetype)sharedInstance;
- (void)requestContactPermission;
@end

NS_ASSUME_NONNULL_END
