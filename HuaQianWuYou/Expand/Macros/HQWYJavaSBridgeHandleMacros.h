//
//  HQWYJavaSBridgeHandleMacros.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#ifndef HQWYJavaSBridgeHandleMacros_h
#define HQWYJavaSBridgeHandleMacros_h
/*!
 app打开原生页面
 */
static NSString * const kAppOpenNative = @"appOpenNative";

/*!
 app埋点
 */
static NSString * const kAppExecStatistic = @"appExecStatistic";

/*!
 给用户成长体系发送数据
 */
static NSString * const kAppGetAjaxHeader = @"appGetAjaxHeader";

/*!
 app页面返回
 */
static NSString * const kAppExecBack = @"appExecBack";

/*!
 获取productID
 */
static NSString * const kAppGetProductId = @"appGetProductId";

/*!
 获取微信是否安装
 */
static NSString * const kAppGetWXAppInstalled = @"appGetWXAppInstalled";

/*!
 获取ChannelID
 */
static NSString * const kAppGetChannel = @"appGetChannel";

/*!
 获取app版本
 */
static NSString * const kAppGetVersion = @"appGetVersion";

/*!
 获取bundleID
 */
static NSString * const kAppGetBundleId = @"appGetBundleId";

/*!
 获取用户token
 */
static NSString * const kAppGetUserToken = @"appGetUserToken";

/*!
 获取用户唯一id
 */
static NSString * const kAppGetUserId = @"appGetUserId";

/*!
 获取手机号
 */
static NSString * const kAppGetMobilephone = @"appGetMobilephone";

/*!
 获取用户是否登录
 */
static NSString * const kAppIsLogin = @"appIsLogin";

/*!
 获取设备类型 (iOS/Android)
 */
static NSString * const kAppGetDeviceType = @"appGetDeviceType";

/*!
 获取设备唯一标识
 */
static NSString * const kAppGetDeviceUID = @"appGetDeviceUID";

/*!
 打开webView
 */
static NSString * const kAppOpenWebview = @"appOpenWebview";

/*!
 给JS发送通用数据
 */
static NSString * const kJSReceiveAppData = @"jsReceiveAppData";

/*!
 页面加载
 */
static NSString * const kWebViewDidLoad = @"webViewDidLoad";

/*!
 页面将要显示
 */
static NSString * const kWebViewWillAppear = @"webViewWillAppear";

/*!
 页面已经显示
 */
static NSString * const kWebViewDidAppear = @"webViewDidAppear";

/*!
 页面将要消失
 */
static NSString * const kWebViewWillDisappear = @"webViewWillDisappear";

/*!
 页面已经消失
 */
static NSString * const kWebViewDidDisappear = @"webViewDidDisappear";

/*!
 H5获取城市
 */
static NSString * const kAppGetLocationCity = @"appGetLocationCity";


/*!
 H5调用定位
 */
static NSString * const kAppExecLocation = @"appExecLocation";

/*!
 获取导航栏样式
 */
static NSString * const kAppGetNavigationBarStatus = @"appSetNavigationBar";

/*!
 获取更新内容
 */
static NSString * const kAppCheckUpdate = @"appCheckUpdate";

/*!
 安全退出
 */
static NSString * const kAppExecLogout = @"appExecLogout";


#endif /* HQWYJavaSBridgeHandleMacros_h */
