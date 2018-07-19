//
//  CInvestigationModel.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CInvestigationModel : NSObject
@property (nonatomic, copy) NSString *checkResult;
@end

@interface CInvestigationRequestModel : NSObject

/**
 公积金账号
 */
@property (nonatomic, copy) NSString *accumulationFundAccount;

/**
 公积金密码
 */
@property (nonatomic, copy) NSString *accumulationFundPWD;

/**
 身份证号
 */
@property (nonatomic, copy) NSString *iDCard;

/**
 姓名
 */
@property (nonatomic, copy) NSString *name;

/**
 手机号
 */
@property (nonatomic, copy) NSString *phoneNumber;

/**
 运营商服务密码
 */
@property (nonatomic, copy) NSString *servicePassword;

/**
 短信验证码
 */
@property (nonatomic, copy) NSString *smsCode;
@end
