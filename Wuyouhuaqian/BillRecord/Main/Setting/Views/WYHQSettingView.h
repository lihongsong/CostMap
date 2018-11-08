//
//  WYHQSettingView.h
//  Wuyouhuaqian
//
//  Created by sunhw on 2018/11/8.
//  Copyright © 2018 yoser. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^WYHQSettingViewGotoVC)(UIViewController *);

@interface WYHQSettingView : UIView

+ (void)showSettingViewOnSuperViewController:(UIViewController *)superVC gotoVCHandler:(WYHQSettingViewGotoVC)gotoVC;

@property (nonatomic, copy, nullable) WYHQSettingViewGotoVC gotoViewContoller;
@property (nonatomic, weak) UIViewController *superViewController;

@end

NS_ASSUME_NONNULL_END
