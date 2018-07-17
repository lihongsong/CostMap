//
//  HQWYActionHandler.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/12.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQWYActionHandlerProtocol.h"
/**
 Description
 
 @param isHandle isHandle description
 */
typedef void(^HQWYActionHandleBlock)(BOOL isHandle);

/**
 跳转
 */

@interface HQWYActionHandler : NSObject

/**
 必须要有tabBar
 */
+ (void)handleWithActionModel:(id<HQWYActionHandlerProtocol>)launchModel;

@end
