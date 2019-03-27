//
//  YosKeepAccountsUserManager.m
//  UserCenter
//
//  Created by luzhiyong on 16/6/7.
//  Copyright © 2016年 luzhiyong. All rights reserved.
//

#import "YosKeepAccountsUserManager.h"
#import <UserCenter/XZYUserCenterHeader.h>

@implementation YosKeepAccountsUserManager

static YosKeepAccountsUserManager *manager;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [YosKeepAccountsUserManager new];
        manager.logined = NO;
    });
    return manager;
}

+ (void)autoLogin {
    //用户自动登录
    [XZYUserCenterNetwork autoLogInWithCookie:[YosKeepAccountsUserManager cookie] succeed:^(NSDictionary *responseDict) {
        if (((NSString *)responseDict[@"code"]).integerValue == LoginStatusSuccess) {
            NSDictionary *dict = responseDict[@"data"];
            XZYUserInfoInstance.cookie = dict[@"I"];
            [XZYUserCenterNetwork getUserInfoWithCookie:XZYUserInfoInstance.cookie Succeed:^(NSDictionary *resDict) {
                // 状态码验证
                if (((NSString *)resDict[@"code"]).integerValue == LoginStatusSuccess) {
                    [XZYUserInfoInstance setInfo:resDict[@"data"]];
                    //保存用户信息
                    [YosKeepAccountsUserManager saveUserInfo];
                }
            }failed:^(NSString *err) {
                
            }];
        }
    } failed:^(NSString *error) {
        
    }];
}

+ (NSString *)cookie {
    return [[YosKeepAccountsUserManager userInfo] objectForKey:@"cookie"];
}

+ (void)saveUserInfo {
    NSString *passid = @"";
    NSString *username = @"";
    NSString *phone = @"";
    NSString *email = @"";
    NSString *cookie = @"";
    
    if (XZYUserInfoInstance.passid && ![XZYUserInfoInstance.passid isEqual:[NSNull null]]) {
        passid = XZYUserInfoInstance.passid;
    }
    
    if (XZYUserInfoInstance.username && ![XZYUserInfoInstance.username isEqual:[NSNull null]]) {
        username = XZYUserInfoInstance.username;
    }
    if (XZYUserInfoInstance.phone && ![XZYUserInfoInstance.phone isEqual:[NSNull null]]) {
        phone = XZYUserInfoInstance.phone;
    }
    if (XZYUserInfoInstance.email && ![XZYUserInfoInstance.email isEqual:[NSNull null]]) {
        email = XZYUserInfoInstance.email;
    }
    if (XZYUserInfoInstance.cookie && ![XZYUserInfoInstance.cookie isEqual:[NSNull null]]) {
        cookie = XZYUserInfoInstance.cookie;
    }
    NSDictionary *userInfo = @{@"passid":passid,
                               @"username":username,
                               @"phone":phone,
                               @"email":email,
                               @"cookie":cookie};
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [YosKeepAccountsUserManager shareInstance].passID = passid;
    [YosKeepAccountsUserManager shareInstance].phone = phone;
    [YosKeepAccountsUserManager shareInstance].email = email;
    [YosKeepAccountsUserManager shareInstance].logined = YES;
}

+ (NSDictionary *)userInfo {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
}

- (void)refresh {
    
    NSString *passid = @"";
    NSString *username = @"";
    NSString *phone = @"";
    NSString *email = @"";
    
    if (XZYUserInfoInstance.passid && ![XZYUserInfoInstance.passid isEqual:[NSNull null]]) {
        passid = XZYUserInfoInstance.passid;
    }
    
    if (XZYUserInfoInstance.username && ![XZYUserInfoInstance.username isEqual:[NSNull null]]) {
        username = XZYUserInfoInstance.username;
    }
    if (XZYUserInfoInstance.phone && ![XZYUserInfoInstance.phone isEqual:[NSNull null]]) {
        phone = XZYUserInfoInstance.phone;
    }
    if (XZYUserInfoInstance.email && ![XZYUserInfoInstance.email isEqual:[NSNull null]]) {
        email = XZYUserInfoInstance.email;
    }
    [YosKeepAccountsUserManager shareInstance].passID = passid;
    [YosKeepAccountsUserManager shareInstance].phone = phone;
    [YosKeepAccountsUserManager shareInstance].email = email;
    [YosKeepAccountsUserManager shareInstance].logined = YES;
}

- (void)logout {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.passID = nil;
    self.phone = nil;
    self.email = nil;
    self.logined = NO;
}

@end
