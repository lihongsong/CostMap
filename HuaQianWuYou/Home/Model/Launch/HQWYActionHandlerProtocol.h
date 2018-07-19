//
//  HQWYActionHandlerProtocol.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/12.
//  Copyright © 2018年 2345. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol HQWYActionHandlerProtocol <NSObject>

@required

@property (nonatomic, copy) NSString  *address;

/* 产品名称 */
@property (nonatomic, copy) NSString  *productName;

/* 产品id */
@property (nonatomic, strong) NSNumber  *productId;

//@property(nonatomic,strong)NSNumber *openType;
//@property(nonatomic,copy)NSString *redirectUrl;
//@property(nonatomic,assign)BOOL needLogin;
//@property(nonatomic,copy)NSString *action;

@end
