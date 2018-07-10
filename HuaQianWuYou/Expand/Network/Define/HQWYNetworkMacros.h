//
//  HQWYNetworkMacros.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/10.
//  Copyright © 2018年 2345. All rights reserved.
//

#ifndef HQWYNetworkMacros_h
#define HQWYNetworkMacros_h

#pragma mark - 接口验证用户名密码
#define BaseAuthenticationUserName  @"suixindai"
#define BaseAuthenticationPassword  @"1qaz!@#$"

#pragma mark - API接口域名

/*
 Debug 和 Pre 环境API地址的选择使用说明
 注意第一次运行app时，[[NSUserDefaults standardUserDefaults] stringForKey:@"debug_url_perference_Multi"]获取为空。
 所以debug_url_perference_Multi 对应的默认值为次test环境地址，可到settings.bundle查看
 输入框的优先级高于选择的
 
 ---------------线上环境-----------------------------测试环境--------------------------并行环境---------------
 |WS:   https://wsdaikuan.2345.com      |  http://test-open.ezloan.cn  |  http://bxcs-ws.ezloan.cn         |
 |PC:   http://daikuan.2345.com         |  http://test-www.ezloan.cn   |  http://bxcs-guanwang.ezloan.cn   |
 |M:    https://mdaikuan.2345.com       |  http://test-m.ezloan.cn     |  http://bxcs-mguanwang.ezloan.cn  |
 |MA:   https://managerdaikuan.2345.com |  http://quest.2345.com:12345 |                                   |
 ---------------------------------------------------------------------------------------------------------
 ----------------T1环境------------------------------T2环境---------------------------T3环境-----------------
 |WS:   http://172.16.0.141:3022        |  http://172.16.0.143:3022     |  http://172.16.0.145:3022       |
 |PC:   http://172.16.23.XXX:3010/b2b2p-frontend-v2                                                       |
 |M:    http://172.16.23.XXX:3015/b2b2p-mobile-frontend                                                   |
 |MA:   http://172.16.0.56:12345                                                                          |
 ---------------------------------------------------------------------------------------------------------
 ----------------------------------------------------Pre环境-----------------------------------------------
 |WS:   https://pre-wsdaikuan.2345.com/b2b2p-ws                                                           |
 ---------------------------------------------------------------------------------------------------------
 */

/*********************************域名定义********************************/
#if defined (DebugNet) || defined (PreNet)

// 老系统测试环境
#define HOST_URL ([[NSUserDefaults standardUserDefaults] stringForKey:@"debug_url_perference_TextField"].length)?[[NSUserDefaults standardUserDefaults] stringForKey:@"debug_url_perference_TextField"]:([[NSUserDefaults standardUserDefaults] stringForKey:@"debug_url_perference_Multi"]?:@"http://172.16.0.140:3022")

#define WS_BASE_URL  [HOST_URL stringByAppendingString:@"/b2b2p-ws/"]

#define PC_BASE_URL  [HOST_URL isEqualToString:@"http://v7799.com"]?@"http://daikuan.2345.com/":([HOST_URL isEqualToString:@"https://pre-wsdaikuan.2345.com"]?[HOST_URL stringByAppendingString:@"/b2b2p-frontend-v2/"]:[HOST_URL stringByAppendingString:@"/b2b2p-frontend-v2/"])

#define M_BASE_URL   [HOST_URL isEqualToString:@"http://v7799.com"]?@"http://mdaikuan.2345.com/":([HOST_URL isEqualToString:@"https://pre-wsdaikuan.2345.com"]?[HOST_URL stringByAppendingString:@"/b2b2p-mobile-frontend/"]:[HOST_URL stringByAppendingString:@"/b2b2p-mobile-frontend/"])

#define MA_BASE_URL  [HOST_URL isEqualToString:@"http://v7799.com"]?@"http://managerdaikuan.2345.com/":@"http://quest.2345.com:12345/"

// 风控环境可配置
#define RISK_BASE_URL ([[NSUserDefaults standardUserDefaults] stringForKey:@"riskSDK_debug_host"].length)?[[NSUserDefaults standardUserDefaults] stringForKey:@"riskSDK_debug_host"]: @"http://t1-wsdaikuan.2345.com/b2b2p-ws/"

#define RISK_VIP_BASE_URL ([[NSUserDefaults standardUserDefaults] stringForKey:@"riskvipSDK_debug_host"].length)?[[NSUserDefaults standardUserDefaults] stringForKey:@"riskvipSDK_debug_host"]: @"http://172.16.0.141:10019/"

// 白名单测试环境
#define HOST_WHITE_URL ([[NSUserDefaults standardUserDefaults] stringForKey:@"debug_vip_url_perference_TextField"].length)?[[NSUserDefaults standardUserDefaults] stringForKey:@"debug_vip_url_perference_TextField"]:([[NSUserDefaults standardUserDefaults] stringForKey:@"debug_vip_url_perference_Multi"]?:@"http://172.16.0.141:10014")

#define WS_BASE_WHITE_URL  [HOST_WHITE_URL stringByAppendingString:@"/gateway/"]

#endif

/**********************************准生产环境********************************/
#ifdef DebugNet

//花钱无忧 域名 待修改
#define LN_BASE_URL     WS_BASE_URL

/***********************************pre环境*********************************/

#elif defined PreNet

//花钱无忧 域名  待修改
#define LN_BASE_URL     WS_BASE_URL

/***********************************生产环境*********************************/

#else

//花钱无忧域名    待修改
#define LN_BASE_URL                @"http://v7799.com/b2b2p-ws/"

//vip风控环境 待修改
#define RISK_VIP_BASE_URL          @"https://riskdaikuan.2345.com/"

//风控环境 待修改
#define RISK_BASE_URL              @"http://v7799.com/b2b2p-ws/"

#endif


/*********************************webView的URL******************************/
#pragma mark - WebViewUrl

#if defined (DebugNet) || defined (PreNet)

#import "HQWYWebViewURLDebugMacros.h"

#else

#import "HQWYWebViewURLReleaseMacros.h"

#endif


#pragma mark - 注册登录和获取个人信息接口

//用户登录
#define LN_POST_LOGIN_PATH              @"api/v5_7_5/login"
//获取用户信息
#define LN_POST_RETRIEVEUSER_PATH       @"api/v5_7_5/secure/retrieveUser"

//获取用户信息
#define LN_POST_ELECTRONIC_PATH       @"api/v5_2/secure/bosh/getElectronicAccount"

#pragma mark - 是否有新版本更新接口
//应用更新提示
#define LN_GET_APP_UPDATE_PATH              @"api/v4/version"

//提交修改手机号
#define LN_POST_CHANGE_PHONE_PATH               @"api/v5/secure/changephone/change"
//获取图片验证码
#define LN_POST_GET_IMAGECODE_PATH              @"api/v4/captcha"


#pragma mark - 意见反馈
//意见反馈
#define LN_POST_FEEDBACK_PATH         @"api/v2/feedback"


#pragma mark - 上传用户头像
//上传用户头像
#define LN_POST_AVATAR_PATH           @"api/v4/setUserImage"


#pragma mark - 上传设备信息
//上传设备信息
#define LN_POST_SENDDECIVE_PATH       @"api/plus/sendDeviceInfo"


#pragma mark - 设置别名
//设置推送别名
#define LN_POST_SET_ALIAS_PATH        @"api/v4/setAlias"


#pragma mark -上传用户相关的数据信息

#define LN_POST_USER_UBT_PATH          @"api/v5/report/update"

// 上传设备信息
#define LN_POST_SEND_DEVICE_INFO @"api/v6/sendDeviceInfo"

//获取注册验证码
#define LN_POST_GET_LOGIN_CODE   @"api/v5_9_1/login/getCode"
//用户登录
#define LN_POST_LOGIN_WITH_CODE  @"api/v5_9_1/login"
//设置登录密码
#define LN_POST_SET_PASSWORD     @"api/v5_9_1/login/setPassword"

// 获取首页热门产品列表
#define LN_GET_PRODUCTGUIDE_PATH            @"/api/guide/getProductGuide"

//获取公告列表
#define IL_POST_PERSON_PUBLIC_MESSAGE_PATH         @"/manage/queryAnnouncements"
//首页公告
#define IL_POST_PUBLIC_MESSAGE @"manage/announcement"
// 活动弹窗
#define IL_POST_HOME_ACTIVITY @"/manage/homePopUp"
//获取启动页信息
#define IL_POST_LAUNCH_PAGE @"/manage/launchPage"


#endif /* HQWYNetworkMacros_h */
