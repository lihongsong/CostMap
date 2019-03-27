//
//  AppDelegate+YKAUserCenter.m
//  YosKeepAccounts
//
//  Created by yoser on 2019/3/27.
//  Copyright © 2019 yoser. All rights reserved.
//

#import "AppDelegate+YKAUserCenter.h"

#import <UserCenter/XZYUserCenterHeader.h>
#import "YosKeepAccountsUserManager.h"

#define APP_PROJECTION_ID @"iossdktest"

@implementation AppDelegate (YKAUserCenter)

- (void)registerUserCenter {
    XZYConfigInstance.projectionID = APP_PROJECTION_ID;
    XZYConfigInstance.protocol = @"用户协议";
    XZYConfigInstance.statement = @"应用声明";
    XZYConfigInstance.tencentAppID = @"100258531";
    XZYConfigInstance.showNavBackTitle = NO;
    XZYConfigInstance.navBackImage = [UIImage imageNamed:@"back"];
    XZYConfigInstance.allowTouristMode = YES;
    XZYConfigInstance.protocolType = ProtocolTypeDefault;
    XZYConfigInstance.protocolDefaultSelected = NO;
    XZYConfigInstance.logoImage = [UIImage imageNamed:@"logo"];
    XZYConfigInstance.remark = @"注：快修王提供来自合作电脑厂商的保内工单及个人客户报修的保外工单。登录后快修王会给您派单，现在是优惠期，快修王每单只收取1元信息费。";
    XZYConfigInstance.normalColor = YosKeepAccountsThemeColor;
    XZYConfigInstance.highLightColor = [UIColor colorWithHexValue:@"#4996ff"];
    XZYConfigInstance.disableColor = [UIColor colorWithHexValue:@"#bdbdbd"];
    XZYConfigInstance.navTitleColor = YosKeepAccountsThemeTitleColor;
    XZYConfigInstance.navBarTintColor = YosKeepAccountsThemeColor;
    XZYConfigInstance.navBackImage = [UIImage imageNamed:@"yka_navbar_back_02"];
    XZYConfigInstance.navBackHighlightImage = [UIImage imageNamed:@"navigation_back_button_highlight"];
    XZYConfigInstance.showNavBackTitle = NO;
    XZYConfigInstance.navItemTitleColor = YosKeepAccountsThemeTitleColor;
    XZYConfigInstance.navItemTitleHighlightColor = [UIColor colorWithHexValue:@"#a6a7b1"];
    [XZYUserCenter startWithConfigure:XZYConfigInstance];
    [YosKeepAccountsUserManager autoLogin];
    
}

@end
