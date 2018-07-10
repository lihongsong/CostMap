//
//  AppDelegate.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/3.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SharedAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

@end

