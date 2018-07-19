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

#define kLaunchSkipButtonW 60
#define kLaunchSkipButtonH 30
#define kLaunchSkipButtonSpace 15

@interface HQWYLaunchManager : NSObject
@property(nonatomic,strong)BasicDataModel *launchModel;

@property (nonatomic,strong)HJGuidePageViewController *guideVC;

- (void)showLanuchPageModel;
@end
