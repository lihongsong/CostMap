//
//  BasicDataProtocol.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BasicDataProtocol <NSObject>
@required
@property(nonatomic,strong)NSNumber *openType;
@property(nonatomic,copy)NSString *redirectUrl;
@property(nonatomic,assign)BOOL needLogin;
@property(nonatomic,copy)NSString *action;
@end
