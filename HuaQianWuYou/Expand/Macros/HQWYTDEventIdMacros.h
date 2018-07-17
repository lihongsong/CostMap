//
//  HQWYTDEventIdMacros.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/12.
//  Copyright © 2018年 2345. All rights reserved.
//

#ifndef HQWYTDEventIdMacros_h
#define HQWYTDEventIdMacros_h

// 广告位 +产品id
static NSString * const HQWY_StartApp_Advertisement_click = @"kp;w2;c";
// 跳过
static NSString * const HQWY_StartApp_Jump_click   = @"kp;w3";
// 验证码登录菜单
static NSString * const HQWY_Login_Code_click  = @"dlzc;yzmdl;w4";
// 获取验证码
static NSString * const HQWY_Login__GetCode_click   = @"dlzc;yzmdl;hqyzm;w5";
// 登录按钮
static NSString * const HQWY_Login_SignIn_click   = @"dlzc;yzmdl;dl;w6";
// 用户服务协议
static NSString * const HQWY_Login_Agreement_click = @"dlzc;yzmdl;fwxy;w7";
// 安全校验-确定（图形验证码）
static NSString * const HQWY_Login_ImageCode_click   = @"dlzc;aqjy;w8";
// 安全校验-关闭（图形验证码）
static NSString * const HQWY_Login_ImageCodeCheck_click   = @"dlzc;aqjy;w9";
// 密码登录菜单
static NSString * const HQWY_Login_Password_click  = @"dlzc;mmdl;w10";
// 登录按钮（密码登录）
static NSString * const HQWY_Login_PasswordLogin_click   = @"dlzc;mmdl;dl;w11";
// 用户服务协议
static NSString * const HQWY_Login_PasswordAgreement_click   = @"dlzc;mmdl;fwxy;w12";
// 忘记密码
static NSString * const HQWY_Login_ForgetPassword_click  = @"dlzc;mmdl;wjmm;w13";
// 登录注册-关闭
static NSString * const HQWY_Login_Close_click = @"dlzc;w14";

// 提示定位权限用途
static NSString * const HQWY_Location_Alert_click = @"qx;tsdw;w15";
// 定位被拒弹窗-去设置
static NSString * const HQWY_Location_Seting_click  = @"qx;dwbj;w16";
// 定位被拒弹窗-关闭
static NSString * const HQWY_Location_Close_click   = @"qx;dwbj;w17";

// 首页弹窗广告-点击 +产品id
static NSString * const HQWY_Home_Advertisement_click  = @"sy;tc;w25;c";
// 首页弹窗广告-关闭
static NSString * const HQWY_Home_AdvertiseClose_click = @"sy;tc;w26";

// 首页悬浮广告-点击 +产品id
static NSString * const HQWY_Home_AdverAlert_click = @"sy;xf;w37;c";
// 首页悬浮广告-关闭
static NSString * const HQWY_Home_AdverAlertClose_click = @"sy;xf;w38";
// 验手机号-获取验证码
static NSString * const HQWY_Fix_GetCode_click = @"xgmm;ysjh;hqyzm;w129";
// 验手机号-下一步
static NSString * const HQWY_Fix_Next_click = @"xgmm;ysjh;xyb;w130";
// 验手机号-返回
static NSString * const HQWY_Fix_Back_click     = @"xgmm;ysjh;fh;w131";

// 设置密码-确认
static NSString * const HQWY_Fix_Sure_click = @"xgmm;szmm;qr;w132";
// 设置密码-返回
static NSString * const HQWY_Fix_PasswordBack_click = @"xgmm;szmm;fh;w133";

// 返回
static NSString * const HQWY_ThirdPart_Back_click = @"zcy;fh;w148";

// 返回弹窗-关闭
static NSString * const HQWY_ThirdPart_AlertClose_click = @"zcy;fhtc;w149";
// 返回弹窗-今日不再提示
static NSString * const HQWY_ThirdPart_NoneAlert_click = @"zcy;fhtc;w150";

#endif /* HQWYTDEventIdMacros_h */
