//
//  HQWYUserStatusManager.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQWYUserBaseInfo.h"

#define HQWYUserStatusSharedManager [HQWYUserStatusManager sharedInstance]

typedef void (^HQWYUserStatusCallBack)(HQWYUserBaseInfo *userInfo);

@interface HQWYUserStatusManager : NSObject

/// 正则URL
@property (nonatomic, copy) NSString *regularExpressionUrl;
/// 是否弹出token失效的弹框
@property (nonatomic, assign) BOOL showingTokenValidateAlertView;

#pragma mark - Persistence
@property (nonatomic, copy, readonly) NSString *token;

/// 用户基本信息
@property (nonatomic, strong, readonly) HQWYUserBaseInfo *userBaseInfo;
@property (nonatomic, copy) NSString* tempMobilePhone;

+ (instancetype)sharedInstance;

/**
 获取未读个人消息
 */
- (void)getUnreadMessage;

#pragma mark - Public Method

/**
 删除持久化、实例、等用户信息
 */
- (void)deleteUserInfo;

/**
 存储用户手机号
 */
-(void)storeUserMobilePhone:(NSString *)mobilePhone;

/**
 用户上次使用的手机号
 */
+ (NSString *)lastLoginMobilePhone;

/**
 用户是否已经登录
 */
+ (BOOL)hasAlreadyLoggedIn;

///**
// *  判断用户是否曾经登录过
// */
//+ (BOOL)hasAlreadySignedUp;
//
///**
// *  设置用户登录标记
// */
//+ (void)setAlreadySignedUp;


+ (void)handleInvalidateToken:(NSDictionary *)dict;

@end
