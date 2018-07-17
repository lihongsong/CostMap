//
//  HQWYUser.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/10.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQWYUser : NSObject
@property(nonatomic,copy)NSString * mobilePhone;//用户手机号
//FIXME:review respDateTime是什么？
@property(nonatomic,copy)NSString *respDateTime;//响应时间
@property(nonatomic,copy)NSString *token;//用户令牌
//@property(nonatomic, strong)NSNumber *userId;//用户ID
@end
