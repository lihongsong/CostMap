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
#import "UIColor+YKATheme.h"

#define APP_PROJECTION_ID @"iossdktest"

@implementation AppDelegate (YKAUserCenter)

- (void)registerUserCenter {
    XZYConfigInstance.projectionID = APP_PROJECTION_ID;
    XZYConfigInstance.protocol = @"用户协议";
    XZYConfigInstance.statement = @"应用声明";
    XZYConfigInstance.showNavBackTitle = NO;
    XZYConfigInstance.navBackImage = [UIImage imageNamed:@"back"];
    XZYConfigInstance.allowTouristMode = YES;
    XZYConfigInstance.protocolType = ProtocolTypeDefault;
    XZYConfigInstance.protocolDefaultSelected = NO;
    XZYConfigInstance.logoImage = [UIImage imageNamed:@"logo"];
    XZYConfigInstance.normalColor = YosKeepAccountsThemeColor;
    XZYConfigInstance.highLightColor = YosKeepAccountsThemeColor;
    XZYConfigInstance.disableColor = UIColor.yka_unselected;
    XZYConfigInstance.navTitleColor = YosKeepAccountsThemeTitleColor;
    XZYConfigInstance.navBarTintColor = YosKeepAccountsThemeColor;
    XZYConfigInstance.navBackImage = [UIImage imageNamed:@"yka_navbar_back_02"];
    XZYConfigInstance.navBackHighlightImage = [UIImage imageNamed:@"yka_navbar_back_02"];
    XZYConfigInstance.showNavBackTitle = NO;
    XZYConfigInstance.navItemTitleColor = YosKeepAccountsThemeTitleColor;
    XZYConfigInstance.navItemTitleHighlightColor = YosKeepAccountsThemeTitleColor;
    [XZYUserCenter startWithConfigure:XZYConfigInstance];
    [YosKeepAccountsUserManager autoLogin];
    
}

@end
