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







//返回挽留推荐
#define LN_POST_ReturnToDetain_PATH         @"/product/retain"

//产品上报
#define LN_POST_ProductUpload_PATH         @"/product/click/report"


#endif /* HQWYNetworkMacros_h */
