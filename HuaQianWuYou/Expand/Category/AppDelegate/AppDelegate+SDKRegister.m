//
//  AppDelegate+SDKRegister.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/4.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "AppDelegate+SDKRegister.h"
#import <AppUpdate/XZYAppUpdate.h>

@implementation AppDelegate (SDKRegister)
/**
 公共强制升级SDK
 */
- (void)registerAppUpdate {

  [XZYAppUpdate startWithAppKey:Update_SDK_AppId
                      channelId:APP_ChannelId
              appUpdatePriority:AppUpdatePriorityDefault];
#ifdef DEBUG
    [XZYAppUpdate setDebug:YES];
#endif
}


- (void)checkUpdate {
  [XZYAppUpdate checkUpdateAtLaunch:nil];

}
@end
