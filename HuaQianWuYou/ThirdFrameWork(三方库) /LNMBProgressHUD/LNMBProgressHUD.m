//
//  LNMBProgressHUD.m
//  LottieDemo2
//
//  Created by terrywang on 2017/5/14.
//  Copyright © 2017年 terrywang. All rights reserved.
//

#import "LNMBProgressHUD.h"
#define LNTOAST_TAG 20179322

//static const CGFloat kLNHUDMinSizeWidth         = 100.0;
//static const CGFloat kLNHUDMinSizeHeight        = 100.0;
static const CGFloat kLNHUDHideDelay            = 2.0;

//static const CGFloat kLNHUDTimeOutHideDelay     = 120.0;

@interface LNMBProgressHUD () {
    NSInteger toastNumber;
    NSInteger loadingNumber;
}

@property (nonatomic, assign) LNMBProgressHUDAnimationType type;
@property (nonatomic, strong) dispatch_queue_t toastQueue;
@property (nonatomic, strong) dispatch_semaphore_t toastSema;
@property (nonatomic, strong) LNMBProgressHUD *loadingHud;

@end

@implementation LNMBProgressHUD

+ (instancetype)sharedManager {
    static LNMBProgressHUD *_shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[[self class] alloc] init];
        if (!_shareManager.toastQueue) {
            //创建 toast 显示队列，让当前屏幕只显示一个 toast，防止 toast 覆盖
            _shareManager.toastQueue =  dispatch_queue_create("toastSingal", DISPATCH_QUEUE_SERIAL);
            _shareManager.toastSema = dispatch_semaphore_create(0);
        }
    });
    
    return _shareManager;
}

#pragma create HUD
- (LNMBProgressHUD *)progressHUD:(UIView *)view type:(LNMBProgressHUDAnimationType)type {
    LNMBProgressHUD *hud = [LNMBProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    if (type == LNMBProgressHUDAnimationLoading || type == 0) {
        // Change the background view style and color.
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        if ([view isMemberOfClass:[UIView class]]) {
            hud.backgroundView.color = [UIColor colorWithWhite:0.0f alpha:0.0f];
        } else {
            hud.backgroundView.color = [UIColor colorWithWhite:0.0f alpha:0.3f];
        }
        
        // Change the bezelView view color.
        hud.bezelView.color = [UIColor blackColor];
    } else {
        //toast
        // Change the bezelView view color.
        hud.bezelView.color = [UIColor colorWithWhite:0.2f alpha:1.0f];
    }
    // Change the label and indicator color.
    hud.contentColor = [UIColor whiteColor];
    [hud.detailsLabel setFont:[UIFont systemFontOfSize:14.0]];
    return hud;
}

#pragma show loading
- (LNMBProgressHUD *)showLoadingHUD:(UIView *)view message:(NSString *)message {
    if (loadingNumber <= 0 || !_loadingHud) {
        loadingNumber = 0;
        _loadingHud = [self progressHUD:view type:LNMBProgressHUDAnimationLoading];
        [_loadingHud setMode:MBProgressHUDModeIndeterminate];
    }
    _loadingHud.userInteractionEnabled = YES;
    
    _loadingHud.hidden = toastNumber > 0;
    
    _loadingHud.detailsLabel.text = message;
    
    loadingNumber++;
    //    NSLog(@"---showLoadingHUD--loadingNumber------%ld",loadingNumber);
    __weak typeof(_loadingHud)weakLoadingHud = _loadingHud;
    weakLoadingHud.completionBlock = ^{
        if (loadingNumber <= 0) {
            loadingNumber = 0;
            _loadingHud = nil;
        }
    };
    return _loadingHud;
}

#pragma toast base on loadingHUD
- (void)hideLoadingHUD:(NSString *)message view:(UIView *)view {
    
    loadingNumber --;
    //    NSLog(@"---hideLoadingHUD--loadingNumber------%ld, message ===%@",loadingNumber, message);
    if (message) {
        if (loadingNumber <= 0) {
            [self hideLoadingHUD];
        } else {
            _loadingHud.hidden = YES;
        }
        [self showToastHUD:message view:view];
    } else {
        if (loadingNumber <= 0) {
            [self hideLoadingHUD];
        }
    }
}

#pragma hide loading
- (void)hideLoadingHUD {
    //    NSLog(@"hideLoadingHUD-----%ld", loadingNumber);
    loadingNumber --;
    if (loadingNumber <= 0) {
        [_loadingHud hideAnimated:YES];
    }
}

#pragma show toast

- (void)showToastHUD:(NSString *_Nonnull)message view:(UIView *)view {
    
    if (!message || [message length] == 0) {
        return;
    }
    if (_loadingHud) {
        //toast显示时，隐藏loadingHUD
        _loadingHud.hidden = YES;
    }
    
    LNMBProgressHUD *hud = nil;
    UIView *hudView = [view viewWithTag:LNTOAST_TAG];
    if ([hudView isKindOfClass:[LNMBProgressHUD class]]) {
        hud = (LNMBProgressHUD *)hudView;
    }
    
    if (hud && [hud.detailsLabel.text isEqualToString:message]) {
        //相同的toast不重复显示
        return;
    }
    //toast 显示计数加一
    toastNumber ++;
    dispatch_async(_toastQueue, ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            //创建 toastHUD
            LNMBProgressHUD *toastHud = [self progressHUD:view type:LNMBProgressHUDAnimationToast];
            toastHud.tag = LNTOAST_TAG;
            [toastHud setMode:MBProgressHUDModeText];
            toastHud.detailsLabel.text = message;
            toastHud.userInteractionEnabled = loadingNumber > 0;
            
            __weak typeof(toastHud)weakToastHud = toastHud;
            
            weakToastHud.completionBlock = ^{
                //toast 消失计数减一
                toastNumber --;
                if (toastNumber <= 0) {
                    toastNumber = 0;
                }
                if (loadingNumber > 0) {
                    //当前还有loading存在时，toast显示完成后，继续显示loading
                    _loadingHud.hidden = NO;
                }
                dispatch_semaphore_signal(_toastSema);
            };
            
            [toastHud hideAnimated:YES afterDelay:kLNHUDHideDelay];
        });
        dispatch_semaphore_wait(_toastSema, DISPATCH_TIME_FOREVER);
    });
}

@end

@implementation UIView (LNMBProgressHUD)

- (LNMBProgressHUD *)ln_showLoadingHUD {
    return [[LNMBProgressHUD sharedManager] showLoadingHUD:self message:nil];
}

- (LNMBProgressHUD *)ln_showLoadingHUD:(NSString *)message {
    return [[LNMBProgressHUD sharedManager] showLoadingHUD:self message:message];
}

- (void)ln_hideProgressHUD {
    [[LNMBProgressHUD sharedManager] hideLoadingHUD];
}

- (void)ln_showToastHUD:(NSString *)message {
    [[LNMBProgressHUD sharedManager] showToastHUD:message view:self];
}

- (void)ln_hideProgressHUD:(LNMBProgressHUDAnimationType)type message:(NSString *)message {
    [[LNMBProgressHUD sharedManager] hideLoadingHUD:message view:self];
}

@end
