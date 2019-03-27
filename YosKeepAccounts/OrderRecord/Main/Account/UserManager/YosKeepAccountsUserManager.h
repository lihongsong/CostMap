//
//  YosKeepAccountsUserManager.h
//  UserCenter
//
//  Created by luzhiyong on 16/6/7.
//  Copyright © 2016年 luzhiyong. All rights reserved.
//
/*!
 *  用户信息管理类
 */

#import <Foundation/Foundation.h>

@interface YosKeepAccountsUserManager : NSObject

+ (instancetype)shareInstance;

+ (void)autoLogin;

+ (NSString *)cookie;

@property (assign, nonatomic) BOOL logined;

@property (copy, nonatomic) NSString *passID;

@property (copy, nonatomic) NSString *phone;

@property (copy, nonatomic) NSString *email;

- (void)refresh;

- (void)logout;

@end
