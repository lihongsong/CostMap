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
    XZYConfigInstance.protocol = [self privateProtocol];
    XZYConfigInstance.protocolName = @"章鱼记账隐私协议";
    XZYConfigInstance.statementName = @"章鱼记账用户服务协议";
    XZYConfigInstance.statement = [self serviceProtocol];
    XZYConfigInstance.showBondTipsLable = NO;
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
    XZYConfigInstance.navItemTitleHighlightColor = YosKeepAccountsThemeTitleColor;
    XZYConfigInstance.showNavBackTitle = NO;
    XZYConfigInstance.navItemTitleColor = YosKeepAccountsThemeTitleColor;
    [XZYUserCenter startWithConfigure:XZYConfigInstance];
    [YosKeepAccountsUserManager autoLogin];
}

- (NSString *)serviceProtocol {
    return [self localProtocolWithFileName:@"服务条款协议.txt"];
}

- (NSString *)privateProtocol {
    return [self localProtocolWithFileName:@"隐私协议.txt"];
}

- (NSString *)localProtocolWithFileName:(NSString *)fileName {
    
    NSError *error;
    
    NSString *protocolPath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
    NSString *protocol = [NSString stringWithContentsOfFile:protocolPath
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
    if (error) {
        return @"";
    }
    
    return protocol;
}

@end
