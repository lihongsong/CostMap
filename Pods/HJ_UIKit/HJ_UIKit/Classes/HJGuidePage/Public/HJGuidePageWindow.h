//
//  HJGuidePageWindow.h
//  HJNetWorkingDemo
//
//  Created by Jack on 2017/12/15.
//  Copyright © 2017年 姜奎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJGuidePageViewController.h"
#import "HJGuidePageUtility.h"

@interface HJGuidePageWindow : UIWindow

/**
 HJ定制启动页视图

 @param make 定制视图Block，在内部可定制部分属性，详见 HJGuidePageViewController 控制器
 
 @return HJGuidePageViewController
 */
- (HJGuidePageViewController *)makeHJGuidePageWindow:(void(^)(HJGuidePageViewController *make))make;

/**
 高度自定义启动页视图

 @param vc 传入预定制启动视图，无需管理app首次启动状态
 @return 返回预定制的启动图，没啥用
 */
- (id)makeGuidePageWindowWithCustomVC:(UIViewController*)vc;


/**
 初始化 启动图控制Window

 @return 启动图控制Window
 */

/**
 初始化 启动图控制Window

 @param options 启动页显示状态
 @return window
 */
+ (HJGuidePageWindow *)sheareGuidePageWindow:(GuidePageAPPLaunchStateOptions)options;

/**
 启动页显示，无需手动加载
 */
+ (void)show;
/**
 启动页消失，自定义视图，消失时调用
 */
+ (void)dismiss;
@end
