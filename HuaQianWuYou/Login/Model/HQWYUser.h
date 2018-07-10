//
//  HQWYUser.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/10.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQWYUser : NSObject
@property(nonatomic,copy)NSString *redirectUrl;//老用户登录成功跳转Url
@property(nonatomic,copy)NSString *mobilephone;//用户手机号
//@property(nonatomic,copy)NSString *lastLogin;//用户最后登录时间
@property(nonatomic,copy)NSString *token;//用户令牌
@property(nonatomic,strong)NSNumber *restErrCnt;//当日登录剩余错误次数

@property(nonatomic, strong)NSNumber *userId;//用户ID
//@property(nonatomic, copy)NSString *userImagePath;//用户头像路径
//@property(nonatomic, assign)BOOL userImageSetted;//用户是否设置过头像
//@property (nonatomic, assign) BOOL asktoopen; //是否弹出产品确认弹窗 0：不弹 1：弹出
@end
