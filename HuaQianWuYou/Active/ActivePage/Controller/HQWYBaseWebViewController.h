//
//  HQWYBaseWebViewController.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/9.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HJWebViewController.h"
#import "NavigationView.h"

@interface HQWYBaseWebViewController : HJWebViewController
- (void)initNavigation;
- (void)openTheAuthorizationOfLocation;
- (NSDictionary *)jsonDicFromString:(NSString *)string;

@end
