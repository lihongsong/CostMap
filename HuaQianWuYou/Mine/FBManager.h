//
//  FBManager.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBManager : NSObject

/**
 显示留言版

 @param frameVC 入口contoller
 */
+ (void)showFBViewController:(UIViewController *)frameVC;



/**
 FB配置
 */
+ (void)configFB;

@end
