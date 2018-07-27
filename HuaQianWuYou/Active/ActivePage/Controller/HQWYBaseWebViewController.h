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
/**
 是否显示web加载失败toast，第一次不显示
 */
@property(nonatomic,assign) BOOL isShowFailToast;

- (void)initNavigation;
- (void)initRefreshView;
- (void)setWkwebviewGesture;
- (void)setWKWebViewInit;
- (void)openTheAuthorizationOfLocation;
- (void)getResoponseCode:(NSURL *)URL;
- (NSDictionary *)jsonDicFromString:(NSString *)string;
- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL;
@end
