//
//  HJGuidePageWindow.m
//  HJNetWorkingDemo
//
//  Created by Jack on 2017/12/15.
//  Copyright © 2017年 姜奎. All rights reserved.
//

#import "HJGuidePageWindow.h"

@interface HJGuidePageWindow ()
/**root*/
@property (nonatomic, strong) HJGuidePageViewController *guidePageViewController;
/**app启动状态*/
@property (nonatomic,assign) GuidePageAPPLaunchStateOptions options;
@end
@implementation HJGuidePageWindow

- (HJGuidePageViewController *)guidePageViewController{
    if (!_guidePageViewController) {
        _guidePageViewController = [HJGuidePageViewController new];
    }
    return _guidePageViewController;
}
- (HJGuidePageViewController *)makeHJGuidePageWindow:(void (^)(HJGuidePageViewController *make))make{
    self.rootViewController = self.guidePageViewController;
    make?make(self.guidePageViewController):1;
    [self.guidePageViewController reloadData];
    return self.guidePageViewController;
}
- (id)makeGuidePageWindowWithCustomVC:(UIViewController*)vc{
    self.rootViewController = vc;
    return vc;
}

static HJGuidePageWindow* guidePageWindow=nil;
+ (HJGuidePageWindow*)sheareGuidePageWindow:(GuidePageAPPLaunchStateOptions)options{
    if ((options & HJGetGuidePageAPPLaunchState())||(options & GuidePageAPPLaunchStateNormal)) {
        if (!guidePageWindow) {
            guidePageWindow.options = options;
            guidePageWindow = [[HJGuidePageWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
            guidePageWindow.backgroundColor = [UIColor clearColor];
            guidePageWindow.windowLevel = UIWindowLevelNormal;
            [UIApplication sharedApplication].delegate.window = guidePageWindow;
        }
    }
    return guidePageWindow;
}

+ (void)show{
    if (guidePageWindow) [guidePageWindow makeKeyAndVisible];
}
+ (void)dismiss{
    if (guidePageWindow) {
        dispatch_async(dispatch_get_main_queue(), ^{
            HJSetBoolFromUserDefaults(kGuidePageAppFirstInstall, YES);
            HJSetStrFromUserDefaults(kGuidePageAppLastVersion, HJGetAppVersonString());
        });
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kHJGuidePageWindowDidDismiss object:nil];
        [UIView animateWithDuration:0.25 animations:^{
            if (guidePageWindow.guidePageViewController&&guidePageWindow.guidePageViewController.animateFinishedBlock) {
                guidePageWindow.guidePageViewController.animateFinishedBlock(nil);
            }
            guidePageWindow.guidePageViewController = nil;
        }];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    self.rootViewController.view.frame = self.bounds;
}

@end
