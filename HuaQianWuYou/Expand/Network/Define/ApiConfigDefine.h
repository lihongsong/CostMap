//
//  ApiConfigDefine.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/8.
//  Copyright © 2018年 jason. All rights reserved.
//

#ifndef ApiConfigDefine_h
#define ApiConfigDefine_h

#ifdef DEBUG
#define HOST_PATH 
#define HOST_PATH
#else

#define HOST_PATH @"http://172.16.0.140:3022"

#endif

/**
 请求头基本信息
 */
#define REQUESTCOMMONHEADER @{@"content-Type": @"application/json"}

/**
 发现列表数据
 */
#define DISCOVER_LIST @"discover/discoverList"

#define Device_info @"/collect/deviceInfo"

//广告信息
#define AdvertisingInfo @"/product/ad/search"

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

#endif /* ApiConfigDefine_h */
