//
//  HQWYLaunchManager.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/12.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQWYLaunchManager : NSObject
@property(nonatomic,strong)JKLaunchPageModel *launchModel;

@property(nonatomic,copy)DefaultBlock callBack;

@property (nonatomic,strong)HJGuidePageViewController *guideVC;

- (void)showLanuchPageModel;
@end
