//
//  LNMBProgressHUD.h
//  LottieDemo2
//
//  Created by terrywang on 2017/5/14.
//  Copyright © 2017年 terrywang. All rights reserved.
//

#import "MBProgressHUD.h"

typedef NS_ENUM (NSInteger, LNMBProgressHUDAnimationType) {
    LNMBProgressHUDAnimationLoading = 1,
    LNMBProgressHUDAnimationOK      = 2,
    LNMBProgressHUDAnimationError   = 3,
    LNMBProgressHUDAnimationToast   = 4
};

NS_ASSUME_NONNULL_BEGIN
@interface LNMBProgressHUD : MBProgressHUD
@end

@interface UIView (LNMBProgressHUD)

- (void)ln_showToastHUD:(NSString * _Nonnull)message;
- (LNMBProgressHUD *)ln_showLoadingHUD;
- (LNMBProgressHUD *)ln_showLoadingHUD:(NSString * _Nullable)message;

- (void)ln_hideProgressHUD;
- (void)ln_hideProgressHUD:(LNMBProgressHUDAnimationType)type
                   message:(NSString * _Nullable)message;

@end
NS_ASSUME_NONNULL_END
