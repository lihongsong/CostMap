//
//  HQWYUserManager.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/10.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^LNUserManegerCallBack)(HQWYUser *userInfo);
@interface HQWYUserManager : NSObject
// 外部只读去userInfo信息  不让外部修改相关的数据
@property (nonatomic,strong,readonly) HQWYUser * userInfo;
@property(nonatomic,copy,readonly)NSString *userToken;

/**
 用户信用分
 */
@property (nonatomic, assign, readonly) NSInteger creditScore;

+ (instancetype)sharedInstance;


/**  只更新userInfo 不发送通知 不现实loading
 *  @param userInfo 回掉成功的数据信息
 */

-(void)freshUserInformation:(LNUserManegerCallBack)userInfo scene:(NSString *)scene;

/**  只更新userInfo 不发送通知
 *  @param showLoading 是否展示loading状体
 *  @param userInfo 回掉成功的数据信息
 */

-(void)freshUserInformation:(LNUserManegerCallBack)userInfo showLoading:(BOOL)showLoading scene:(NSString *)scene;



/** 更新userInfo 且需要发送通知
 *
 *  @param userInfo 回掉成功的数据信息
 *  @parma needNotif 是否需要通知
 */

-(void)freshUserInformation:(LNUserManegerCallBack)userInfo needNotification:(BOOL)needNotif scene:(NSString *)scene;
/** 更新userInfo 且需要发送通知
 *
 *  @param userInfo 回掉成功的数据信息
 *  @param showLoading 是否展示loading 状态
 *  @parma needNotif 是否需要通知
 */

-(void)freshUserInformation:(LNUserManegerCallBack)userInfo needNotification:(BOOL)needNotif showLoading:(BOOL)showLoading scene:(NSString *)scene;

// 更新userInfo 不发送请求 不发送通知
-(void)freshUserInformationWithoutRequst:(HQWYUser *)userInfo;


// 更新Userinfo 不需要发起请求
-(void)freshUserInformationWithoutRequst:(HQWYUser *)userInfo needNotification:(BOOL)needNotif;



/** 更新userInfo 且需要发送通知
 *
 *  @param userInfo 回掉成功的数据信息
 *  @parma needNotif 是否需要通知
 *  @parma storeToken 存储token信息
 */
-(void)freshUserInformationWithoutRequst:(HQWYUser *)userInfo needNotification:(BOOL)needNotif needStoreToken:(BOOL)storeToken;




-(void)storeUserMobilePhone:(NSString *)mobilePhone;

/**
 *  删除已归档的用户信息 model
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
 *  从UserDefault中获取用户上次登录成功的CustomerID
 *
 *  @return 上次登录的CustomerID
 */
+ (NSString *)lastUserCustomerID;

/**
 *  正则URL
 */
@property (nonatomic, copy) NSString *regularExpressionUrl;

@property (nonatomic, assign) BOOL showingTokenValidateAlertView;//是否弹出token失效的弹框


+ (void)handleInvalidateToken:(NSDictionary *)dict;

+ (void)configRiskManage;
@end
