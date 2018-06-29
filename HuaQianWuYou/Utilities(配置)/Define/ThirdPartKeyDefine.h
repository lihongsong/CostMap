//
//  ThirdPartKeyDefine.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/8.
//  Copyright © 2018年 jason. All rights reserved.
//

#ifndef ThirdPartKeyDefine_h
#define ThirdPartKeyDefine_h

//待账号
// jpush key值
#define JPush_AppKey                @"dfdf3effe3ff3"
// jpush 应用程序下载渠道，为方便分渠道统计，具体值由你自行定义
#define JPush_Channel               @"Don‘t Worry about spending money"
//(默认值)表示采用的是开发证书，1 表示采用生产证书发布应用。
//注：此字段的值要与Build Settings的Code Signing配置的证书环境一致
#define isProduction                1

//目前用的 立即贷等账号
//Bugly相关
#define Bugly_AppId                 @"b543672dcd"
#define Bugly_AppKey                @"77617c80-399a-4394-8053-4eca3ec76e71"
// 测试环境的Debug统计
#define Bugly_AppIdDebug            @"83dfe4b7db"
#define Bugly_AppKeyDebug           @"d55b5747-8c73-4591-a9a7-2e769fe064c9"



#endif /* ThirdPartKeyDefine_h */
