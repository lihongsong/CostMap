//
//  AuthCodeModel.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/6.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, GetCodeType) {
    GetCodeTypeLogin = 21,//登录注册获取验证码
    GetCodeTypeFixPassword = 31,//修改密码获取验证码
};


//短信验证码Model
@interface AuthCodeModel : NSObject

///* 流水号 */
//@property (nonatomic, strong) NSString  *body;
//
///* 校验图形验证码结果result */
//@property (nonatomic, assign) BOOL  result;

@end

