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

#pragma mark - UpdateUserInfoWithoutRequst

/**
 *  更新userInfo 不发送请求
 */
- (void)freshUserStatusWithoutRequst:(NSNumber *)status needNotification:(BOOL)needNotif;

/**
 *  更新userInfo 不发送请求 不发送通知
 */
- (void)freshUserInformationWithoutRequst:(HQWYUserBaseInfo *)userInfo;

/**
 *  更新Userinfo 不需要发起请求
 */
- (void)freshUserInformationWithoutRequst:(HQWYUserBaseInfo *)userInfo needNotification:(BOOL)needNotif;

#pragma mark--个人消息

/**
 更新未读消息和未读公告数
 */
- (void)updateMessageAndNews;
/**
 获取未读个人消息
 */
- (void)getUnreadMessage;

/**
 *  更新userInfo 且需要发送通知
 *
 *  @param userInfo 回调成功的数据信息
 *  @parma needNotif 是否需要通知
 *  @parma storeToken 存储token信息
 */
- (void)freshUserInformationWithoutRequst:(HQWYUserBaseInfo *)userInfo needNotification:(BOOL)needNotif needStoreToken:(BOOL)storeToken;

#pragma mark - UpdateUserInfoWithRequst

/**
 *  只更新userInfo 不发送通知 不现实loading
 *  @param userInfo 回调成功的数据信息
 */

- (void)freshUserInformation:(HQWYUserStatusCallBack)userInfo;

/**
 *  只更新userInfo 不发送通知
 *  @param showLoading 是否展示loading状体
 *  @param userInfo 回调成功的数据信息
 */

- (void)freshUserInformation:(HQWYUserStatusCallBack)userInfo showLoading:(BOOL)showLoading;

/**
 *  更新userInfo 且需要发送通知
 *
 *  @param userInfo 回调成功的数据信息
 *  @parma needNotif 是否需要通知
 */

- (void)freshUserInformation:(HQWYUserStatusCallBack)userInfo needNotification:(BOOL)needNotif;

/**
 *  更新userInfo 且需要发送通知
 *
 *  @param userInfo 回调成功的数据信息
 *  @param showLoading 是否展示loading 状态
 *  @parma needNotif 是否需要通知
 */

-(void)freshUserInformation:(HQWYUserStatusCallBack)userInfo needNotification:(BOOL)needNotif showLoading:(BOOL)showLoading;


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

/**
 *  判断用户是否曾经登录过
 */
+ (BOOL)hasAlreadySignedUp;

/**
 *  设置用户登录标记
 */
+ (void)setAlreadySignedUp;

+ (void)handleInvalidateToken:(NSDictionary *)dict;

@end
