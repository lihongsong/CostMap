//
//  FBManager.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/2.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "FBManager.h"
#import "FBFeedbackViewController.h"
#import <Feedback/FBFeedbackHeader.h>

@implementation FBManager

+ (void)configFB{
    XZYFBConfigInstance.secretKeyStr = MessageBoard_SecretKey;
    XZYFBConfigInstance.projectionID = MessageBoard_Id;
    XZYFBConfigInstance.groupQQ = nil;
    XZYFBConfigInstance.wechatPublicNumber = nil;
    XZYFBConfigInstance.normalColor = [UIColor hj_colorWithHexString:@"#ff6a45"];
    XZYFBConfigInstance.highLightColor = [UIColor hj_colorWithHexString:@"#ff6a45"];
    XZYFBConfigInstance.disableColor = [UIColor hj_colorWithHexString:@"#ff6a45"];
    XZYFBConfigInstance.leaveWordDefaultValue = @"感谢您的留言";
    XZYFBConfigInstance.contactDefaultValue = @"留下联系方式帮助更快联系到您";
    XZYFBConfigInstance.navItemTitleColor = [UIColor hj_colorWithHexString:@"#ff6a45"];
    XZYFBConfigInstance.navItemTitleHighlightColor = [UIColor hj_colorWithHexString:@"#ff6a45"];
    XZYFBConfigInstance.wordLimitColor = [UIColor hj_colorWithHexString:@"#ff6a45"];
    XZYFBConfigInstance.navBackImage = [UIImage imageNamed:@"nav_icon_back"];
}

+ (void)showFBViewController:(UIViewController *)frameVC{
    
    FBFeedbackViewController *controller = [[FBFeedbackViewController alloc] init];
    if (frameVC.navigationController != nil) {
        [frameVC.navigationController pushViewController:controller animated:YES];
    }
    else{
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        [frameVC presentViewController:nav animated:NO completion:nil];
    }
}

@end