//
//  LoginInfoModel.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCachedUserLoginModel @"kCachedUserLoginModel"
@class LoginUserInfoModel;

@interface LoginInfoModel : NSObject
@property(nonatomic, strong) LoginUserInfoModel *userInfo;

@end

@interface LoginUserInfoModel : NSObject<NSCoding>

/**
 年龄
 */
@property(nonatomic, copy) NSString *age;

/**
 车辆情况
 */
@property(nonatomic, copy) NSString *carSituation;

/**
 渠道id
 */
@property(nonatomic, copy) NSString *channelId;

/**
 省-市  mock=上海市-上海市
 */
@property(nonatomic, copy) NSString *city;

/**
 cookie
 */
@property(nonatomic, copy) NSString *cookie;

/**
 
 */
//@property(nonatomic, copy) NSString *creditCard;

/**
 教育情况
 */
@property(nonatomic, copy) NSString *education;

/**
 最高额
 */
@property(nonatomic, copy) NSString *highestEndureAmount;

/**
 身份证号
 */
@property(nonatomic, copy) NSString *identity;

/**
 是否是注册【1：是0：否】
 */
@property(nonatomic, copy) NSString *isReg;

/**
 电话号码
 */
@property(nonatomic, copy) NSString *mobile;

/**
 月收入
 */
@property(nonatomic, copy) NSString *monthlyWages;

/**
 其他系统用户
 */
@property(nonatomic, copy) NSString *otherUser;

/**
 缴纳社保
 */
@property(nonatomic, copy) NSString *paySocialSecurity;

/**
 职业
 */
@property(nonatomic, copy) NSString *profession;

/**
 UID
 */
@property(nonatomic, copy) NSString *uid;

/**
 用户姓名昵称
 */
@property(nonatomic, copy) NSString *username;

/**
 工作年限
 */
@property(nonatomic, copy) NSString *workingLife;

+ (LoginUserInfoModel *)cachedLoginModel;

+ (void)cacheLoginModel:(LoginUserInfoModel *)userLoginModel;

//保存用户名和密码
+ (void)cacheUserName:(NSString *)userName password:(NSString *)password;

//是否记住密码 1代表记住密码  0代表  不记住密码
+ (void)cacheRememberPassword:(NSString *)isRemember;
@end
