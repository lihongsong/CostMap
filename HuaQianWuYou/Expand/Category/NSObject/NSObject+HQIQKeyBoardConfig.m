//
//  NSObject+HQIQKeyBoardConfig.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "NSObject+HQIQKeyBoardConfig.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@implementation NSObject (HQIQKeyBoardConfig)
+ (void)load {
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
@end
