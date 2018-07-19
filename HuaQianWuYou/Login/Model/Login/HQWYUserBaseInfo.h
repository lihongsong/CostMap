//
//  HQWYUserBaseInfo.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQWYUserBaseInfo : NSObject
@property(nonatomic,copy)NSString *mobilephone; //用户手机号
//@property(nonatomic,copy)NSString *customerId;  //客户id
//@property(nonatomic,strong)NSNumber *status;    //用户状态
@property(nonatomic,copy)NSString *token;       //token
@property(nonatomic,copy)NSString *userId;      //用户ID
@property(nonatomic,copy)NSString *uuId;        //推送别名
@end
