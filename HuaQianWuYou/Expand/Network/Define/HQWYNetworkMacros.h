//
//  HQWYNetworkMacros.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/10.
//  Copyright © 2018年 2345. All rights reserved.
//

#ifndef HQWYNetworkMacros_h
#define HQWYNetworkMacros_h

#import "HQWYNetSetting.h"

#pragma mark - HOST

#ifdef DEBUG

//#define HQWY_HOST_PATH @"http://172.17.16.115:10024"
//#define HQWY_HOST_PATH @"http://dev-static.huaqianwy.com/mem"

#define HQWY_MEMBER_HOST_PATH [HQWYNetSetting memberPath]
#define HQWY_PRODUCT_PATH     [HQWYNetSetting productPath]
#define HQWY_HQWYV1_PATH       [HQWYNetSetting hqwyV1Path]

#else

#define HQWY_MEMBER_HOST_PATH   @"https://static.huaqianwy.com/mem"
#define HQWY_PRODUCT_PATH       @"https://static.huaqianwy.com/api"
#define HQWY_HQWYV1_PATH         @"http://appjieqian.2345.com/index.php"

#endif

#pragma mark - API接口域名


/*********************************webView的URL******************************/
#pragma mark - WebViewUrl

#ifdef DEBUG

#import "HQWYWebViewURLDebugMacros.h"

//http://172.17.16.79:8088/#/home
//http://172.17.106.138:8088/#/citylist
//http://t1-static.huaqianwy.com/hqwy/dist/#/home
//http://www.baidu.com
//http://t1-static.huaqianwy.com/hqwy/dist/#/home
#else

#import "HQWYWebViewURLReleaseMacros.h"

#endif


#pragma mark - 注册登录和获取个人信息接口

#define APPGetConfig @"/config/getConfig"

#define Device_info @"/collect/deviceInfo"

//广告信息
#define AdvertisingInfo @"/product/advertising/searchfgggg"

//修改密码
#define ChangePassword @"/user/pwdchg"

//发送短信验证码
#define SMS_SEND @"/sms/verification/send"

//校验短信验证码
#define SMS_Validate @"/sms/code/verify"
//获取图形验证
#define IMAGE_CODE @"/login/getImageCode"

//校验图形验证
#define ValidateImageCode @"/login/validateImageCode"

//返回挽留推荐
#define LN_POST_ReturnToDetain_PATH         @"/product/retain"

//产品上报
#define LN_POST_ProductUpload_PATH         @"/product/click/report"

//用户验证码登录
#define LN_POST_LOGIN_PATH              @"/user/login/code"

//用户密码登录
#define LN_POST_PASSWORD_LOGIN_PATH              @"/user/login/password"

#define LN_POST_LOGIN_OUT_PATH @"/user/logout"


#endif /* HQWYNetworkMacros_h */
