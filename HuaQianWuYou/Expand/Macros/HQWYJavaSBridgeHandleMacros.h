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
 异常监控
 */
static NSString * const kAppUrlExceptionMonitor = @"appUrlExceptionMonitor";

/*!
 图片资源
 */
static NSString * const kAppGetImageSource = @"appGetImageSource";

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
 获取用户需要登录
 */
static NSString * const kAppNeedLogin = @"appNeedUserLogin";

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
 显示首页弹窗广告
 */
static NSString * const kAppShowHomeAdvertiseAlert = @"appShowHomeAdvertiseAlert";

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

/*!
  打开意见反馈SDK
 */
static NSString * const kAppOpenSDK = @"appOpenFeedback";

/*!
 关闭 loading
 */
static NSString * const kAppDismissLoading = @"appDismissLoadingDialog";

/*!
 打开 loading
 */
static NSString * const kAppShowLoading = @"appShowLoadingDialog";


/*!
 清除用户信息
 */
static NSString * const kAppClearUser = @"appClearUser";

/*!
 h5调用原生toast
 */
static NSString * const kAppToastMessage = @"appToastMessage";
/*
 退出web
 */
static NSString * const kAppCloseWebview = @"appCloseWebview";

/*!
 设置底部颜色
 */
static NSString * const kAppSetBottomStyle = @"appSetBottomStyle";

#endif /* HQWYJavaSBridgeHandleMacros_h */
