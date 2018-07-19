//
//  NSObject+HQWYResponseCode.h
//  HuaQianWuYou
//
//  Created by terrywang on 2018/7/11.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HQWYRESPONSECODE) {
    HQWYRESPONSECODE_DYNAMIC_LIMIT_FAIL             = 1013, //获取验证码次数超限，弹图形验证码
    HQWYRESPONSECODE_ERROR_PARAM                    = 1002, //传入参数校验失败
    HQWYRESPONSECODE_FAIL                           = 1001, //失败!
    HQWYRESPONSECODE_ILLEGAL_REQUEST                = 1003, //非法请求
    HQWYRESPONSECODE_MOBILE_PHONE_SMS_TYPR_ERROR    = 1012, //短信类型参数校验失败
    HQWYRESPONSECODE_MOBILE_PHONE_VALIDIATION_FAILURE = 1011,//手机号校验失败
    HQWYRESPONSECODE_NONE_CURRENT_USER              = 1006, //用户名不存在,请联系系统管理员!
    HQWYRESPONSECODE_SUCC                           = 1000, //成功!
    HQWYRESPONSECODE_UCENTER_INVALID_MSG            = 1007, //互*金后台验证失效!
    HQWYRESPONSECODE_UCENTER_LOGIN_TIMEOUT          = 1008, //登录超时或未登录!
    HQWYRESPONSECODE_UN_AUTHORIZATION               = 1004, //非授权访问
    HQWYRESPONSECODE_VERIFY_CODE_FAILURE            = 1014,  //短信验证码校验失败
    HQWYRESPONSECODE_EXIST_THRITY_DAYS_RECORD       = 1015,  //存在30天内的数据
    HQWYRESPONSECODE_DYNAMIC_LIMIT_MOBILE_FAIL      = 1017,  //获取验证码次数超限,请1小时后再试（手机，透传直接提示用户
    HQWYRESPONSECODE_DYNAMIC_LIMIT_IP_FAIL          = 1018,  //获取验证码次数超限（IP，弹图形验证码）
    HQWYRESPONSECODE_HEADER_PARAM_ERROR             = 1019,  //packageName或os头参数有误
    HQWYRESPONSECODE_IMAGE_CODE_INPUT_FAIL          = 1100,  //图形验证码输入错误
    HQWYRESPONSECODE_UNKNOW                         = 88888  //未知
};


@interface NSObject (HQWYResponseCode)

//- (HQWYRESPONSECODE)responseIntegerCode:(NSString *)respCode;

@end
