//
//  HQWYUserManager.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/10.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQWYUser.h"
#define HQWYUserSharedManager [HQWYUserManager sharedInstance]

typedef void(^LNUserManegerCallBack)(HQWYUser *userInfo);
@interface HQWYUserManager : NSObject
// 外部只读去userInfo信息  不让外部修改相关的数据
@property (nonatomic,strong,readonly) HQWYUser * userInfo;
@property(nonatomic,copy,readonly)NSString *userToken;

+ (instancetype)sharedInstance;

- (void)storeNeedStoredUserInfomation:(HQWYUser *)userInfo;

-(void)storeUserMobilePhone:(NSString *)mobilePhone;

/**
 *  删除用户信息 model
 */
- (void)deleteUserInfo;

/**
 *  判断用户是否已经登录
 *
 *  @return YES:已登录; NO:未登录.
 */
+ (BOOL)hasAlreadyLoggedIn;

/**
 *  从UserDefault中获取用户上次登录成功的手机号码
 *
 *  @return 上次登录的手机号码
 */
+ (NSString *)lastLoginMobilePhone;

/**
 *  从UserDefault中获取用户登录成功的手机号码
 *
 *  @return 登录的手机号码
 */
+ (NSString *)loginMobilePhone;

/**
 *  从UserDefault中获取用户上次登录成功的CustomerID
 *
 *  @return 上次登录的CustomerID
 */
//+ (NSString *)lastUserCustomerID;

@property (nonatomic, assign) BOOL showingTokenValidateAlertView;//是否弹出token失效的弹框


//+ (void)handleInvalidateToken:(NSDictionary *)dict;

@end
