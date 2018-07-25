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
/**
 桥接管理器
 */
@property (strong, nonatomic)HJJSBridgeManager *manager;

- (void)initNavigation;
- (void)initRefreshView;
- (void)setWkwebviewGesture;
- (void)setWKWebViewInit;
- (void)openTheAuthorizationOfLocation;
- (NSDictionary *)jsonDicFromString:(NSString *)string;

@end
