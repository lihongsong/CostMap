//
//  NSObject+HQWYResponseCode.m
//  HuaQianWuYou
//
//  Created by terrywang on 2018/7/11.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "NSObject+HQWYResponseCode.h"

// 1004 token 校验失败文言
static NSString *const kHQWYTokenInvalid = @"登录失效";

//响应返回参数key
static NSString *const kHQWYErrorRespCodeKey      = @"respCode";
//响应返回参数key
static NSString *const kHQWYRespMsgKey      = @"respMsg";


@implementation NSObject (HQWYResponseCode)


- (NSString *)responseMessage:(NSDictionary<NSErrorUserInfoKey, id> *) userInfo{
    if ([NSString stringWithFormat:@"%@", userInfo[kHQWYErrorRespCodeKey]].integerValue == HQWYRESPONSECODE_UN_AUTHORIZATION){
        return kHQWYTokenInvalid;
    }else{
        return userInfo[kHQWYRespMsgKey];
    }

//    if ([respCode isEqualToString:@"SUCC"]) {
//        return HQWYRESPONSECODE_SUCC;
//    }
//
//    if ([respCode isEqualToString:@"DYNAMIC_LIMIT_FAIL"]) {
//        return HQWYRESPONSECODE_DYNAMIC_LIMIT_FAIL;
//    }
//
//    if ([respCode isEqualToString:@"ERROR_PARAM"]) {
//        return HQWYRESPONSECODE_ERROR_PARAM;
//    }
//
//    if ([respCode isEqualToString:@"ILLEGAL_REQUEST"]) {
//        return HQWYRESPONSECODE_ILLEGAL_REQUEST;
//    }
//
//    if ([respCode isEqualToString:@"MOBILE_PHONE_SMS_TYPR_ERROR"]) {
//        return HQWYRESPONSECODE_MOBILE_PHONE_SMS_TYPR_ERROR;
//    }
//
//    if ([respCode isEqualToString:@"MOBILE_PHONE_VALIDIATION_FAILURE"]) {
//        return HQWYRESPONSECODE_MOBILE_PHONE_VALIDIATION_FAILURE;
//    }
//
//    if ([respCode isEqualToString:@"NONE_CURRENT_USER"]) {
//        return HQWYRESPONSECODE_NONE_CURRENT_USER;
//    }
//    if ([respCode isEqualToString:@"UCENTER_INVALID_MSG"]) {
//        return HQWYRESPONSECODE_UCENTER_INVALID_MSG;
//    }
//    if ([respCode isEqualToString:@"UCENTER_LOGIN_TIMEOUT"]) {
//        return HQWYRESPONSECODE_UCENTER_LOGIN_TIMEOUT;
//    }
//    if ([respCode isEqualToString:@"UN_AUTHORIZATION"]) {
//        return HQWYRESPONSECODE_UN_AUTHORIZATION;
//    }
//    if ([respCode isEqualToString:@"VERIFY_CODE_FAILURE"]) {
//        return HQWYRESPONSECODE_VERIFY_CODE_FAILURE;
//    }
//    return HQWYRESPONSECODE_FAIL;
}


@end
