//
//  HQWYBaseWebViewController.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/9.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HJWebViewController.h"
#import "NavigationView.h"
#import "UNProgressBar.h"

typedef void (^SignFinishBlock)(void);

@interface HQWYBaseWebViewController : HJWebViewController
/**
 进度条
 */
@property (nonatomic, strong) UNProgressBar *progressBar;
/**
 桥接管理器
 */
@property (strong, nonatomic)HJJSBridgeManager *manager;
/**
 是否显示web加载失败toast，第一次不显示
 */
@property(nonatomic,assign) BOOL isShowFailToast;

- (void)initNavigation;
- (void)initProgressView;
- (void)initRefreshView;
- (void)setWkwebviewGesture;
- (void)setWKWebViewInit;
- (void)openTheAuthorizationOfLocation;
- (void)getResoponseCode:(NSURL *)URL;
#pragma mark 登录
- (void)presentNative:(loginFinshBlock)block;
- (void)registerStaticHander;
    
- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL;
@end
