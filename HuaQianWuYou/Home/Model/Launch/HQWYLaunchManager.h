//
//  HQWYLaunchManager.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/12.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicDataModel.h"
#import "HJGuidePageViewController.h"

@interface HQWYLaunchManager : NSObject
@property(nonatomic,strong)BasicDataModel *launchModel;

@property (nonatomic,strong)HJGuidePageViewController *guideVC;
@property(nonatomic,strong)UIViewController *rootViewController;// guide window 所以无法获取原来window，没法实现在原来基础上跳转活动web页，传root替代
- (void)showLanuchPageModel;
@end
