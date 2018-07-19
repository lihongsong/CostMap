//
//  NSObject+HQWYUpdateAlert.h
//  JiKeLoan
//
//  Created by terrywang on 2017/5/22.
//  Copyright © 2017年 JiKeLoan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HQWYUpdateAlert)
/**
 强制升级弹层服务端控制
 
 @param messageDic url , content
 */
- (void)HQWY_showUpdateAlert:(NSDictionary *)dict;
@end
