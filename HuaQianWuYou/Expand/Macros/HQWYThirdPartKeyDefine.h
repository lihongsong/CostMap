//
//  ThirdPartKeyDefine.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/8.
//  Copyright © 2018年 jason. All rights reserved.
//

#ifndef ThirdPartKeyDefine_h
#define ThirdPartKeyDefine_h

// app ID(RN约定)
#define APP_ID @"111"
// app的渠道id
#define APP_ChannelId @"bx-ioshqwy_fr_gyq"

//待账号
// jpush key值
#define JPush_AppKey              @"d13190ffaafa7ef2a730cac8"
// jpush 应用程序下载渠道，为方便分渠道统计，具体值由你自行定义

//(默认值)表示采用的是开发证书，1 表示采用生产证书发布应用。
//注：此字段的值要与Build Settings的Code Signing配置的证书环境一致

//百度地图
#define Baidu_AppKey @"3nOIiqTdyBEQycGng1zhUzzgU6xRWNrB"

// 移动武林绑
#define MobClick_ProjectName  @"jieqian_ios"
#define MobClick_AppKey   @"8289c4204c5e7cddb30a14a4d2f7c72d"

// TalkingData
#if defined (DEBUG)
#define TalkingData_AppId       @"4844CC0DF8C842AE9B34EC0EFAC7682D"
#else
#define TalkingData_AppId       @"AC95102F0E334875B02D2CDA50822E02"
#endif

//意见反馈
#define MessageBoard_SecretKey @"87b38eba12ff2c9dcd09e8d35ec7b697";
#define MessageBoard_Id @"30";

//公共强制升级SDK
#define Update_SDK_AppId @"bd5d7524662dbbaeb0de4621469e18d9"

#if defined (DEBUG)
#define Bugly_AppIdDebug @"5a71ccc8-3006-4e7f-a51f-1b14eb941f7f"
#else
#define Bugly_AppId @"0f87d85-3a93-4596-b60f-5b6e77685175"
#endif



#endif /* ThirdPartKeyDefine_h */
