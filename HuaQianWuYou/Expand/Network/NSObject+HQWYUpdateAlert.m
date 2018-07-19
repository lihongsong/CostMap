//
//  NSObject+HQWYUpdateAlert.m
//  JiKeLoan
//
//  Created by terrywang on 2017/5/22.
//  Copyright © 2017年 JiKeLoan. All rights reserved.
//

#import "NSObject+HQWYUpdateAlert.h"
//#import "HQWYToolManager.h"

@implementation NSObject (HQWYUpdateAlert)
/*
- (void)HQWY_showUpdateAlert:(NSDictionary *)dict {
    if (!dict || [dict[@"url"] length] == 0
        || [dict[@"message"] length] == 0) {
        return;
    }
    
    if (![HQWYToolManager sharedInstance].showingUpdateAlertView) {
        [self eventId:@"FUpdateAlert_Show"];
        NSString *urlString = dict[@"url"];

        HJAlertView *alertView = [[HJAlertView alloc] initWithTitle:nil message:dict[@"message"] cancelButtonTitle:@"暂不升级" confirmButtonTitle:@"立即升级" cancelBlock:^{
            
        } confirmBlock:^{
            //点击立即升级按钮
            [self eventId:@"FUpdateAlert_UpgradeNow_Click"];
            if (urlString) {
                NSURL *url = [NSURL URLWithString:urlString];
                if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                    [[UIApplication sharedApplication] openURL:url options:@{}
                                             completionHandler:^(BOOL success) {
                                             }];
                } else {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        }];
        [alertView show];
//        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
//
//            NSString *urlString = dict[@"url"];
//
//            if (buttonIndex == 1) {
//                //点击立即升级按钮
//                [self eventId:@"FUpdateAlert_UpgradeNow_Click"];
//                if (urlString) {
//                    NSURL *url = [NSURL URLWithString:urlString];
//                    if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
//                        [[UIApplication sharedApplication] openURL:url options:@{}
//                                                 completionHandler:^(BOOL success) {
//
//                                                 }];
//                    } else {
//                        [[UIApplication sharedApplication] openURL:url];
//                    }
//                }
//            } else {
//                //点击暂不升级按钮
//                [self eventId:@"FUpdateAlert_NotUpgraded_Click"];
//            }
//            [HQWYToolManager sharedInstance].showingUpdateAlertView = NO;
//        } title:nil message:dict[@"message"] cancelButtonName:@"暂不升级" otherButtonTitles:@"立即升级", nil];
        
        [HQWYToolManager sharedInstance].showingUpdateAlertView = YES;
    }
}
*/


@end
