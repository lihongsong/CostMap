//
//  HQWYLaunchManager.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/12.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYLaunchManager.h"

@interface HQWYLaunchManager()
@property(nonatomic,assign)BOOL hasShow;

@end

@implementation HQWYLaunchManager
- (void)showLanuchPageModel
{
    __block BOOL getFromNet = NO;
    [self getLocalLaunchModel];
    [BasicDataModel requestBasicData:AdvertisingTypeStartPage productId:nil sort:nil Completion:^(BasicDataModel * _Nullable result, NSError * _Nullable error) {
        if (error) {
            [error jk_errorMessage];
            return ;
        }
        if (ObjIsNilOrNull(lanuchPageModel)||[lanuchPageModel isKindOfClass:[NSArray class]]||ObjIsNilOrNull(lanuchPageModel.versionStamp)) {// 空对象为什么还会有值？
            
            return;
        }else{
            getFromNet = YES;
            self.launchModel = lanuchPageModel;
            [self saveLaunchModel];
        }
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.launchModel == nil) {// 第一次的情况
            [HJGuidePageWindow dismiss];
        }else{
            [self showCustomLaunchImage];
        }
    });
}

- (void)showCustomLaunchImage
{
    NSTimeInterval nowTime = [[NSDate date]timeIntervalSince1970]*1000;
    
    BOOL isStart = self.launchModel.startTime.integerValue < nowTime ? YES:NO;
    BOOL isEnd = self.launchModel.endTime.integerValue > nowTime ? NO:YES;
    
    if (isStart && isEnd == NO  && self.launchModel) {
        if (self.hasShow == NO) {
            self.hasShow = YES;
            self.guideVC.setTimer(self.launchModel.showTime.integerValue,0, @"s跳过",NO);
            WEAK_SELF
            self.guideVC.setBackGroundImage(self.launchModel.fileUrl, YES, NO, ^{
                STRONG_SELF
                if (_launchModel.openType.integerValue != 5) {// 为5的时候什么都不做
                    [JKActionHandle handleWithActionModel:self.launchModel];
                    [HJGuidePageWindow dismiss];
                }
            });
            [self.guideVC reloadData];
        }
    }else{
        [HJGuidePageWindow dismiss];
    }
}

- (void)getLocalLaunchModel
{
    NSData *launchData = [[NSUserDefaults standardUserDefaults]objectForKey:kLaunchModel];
    if (launchData) {
        self.launchModel =  [JKLaunchPageModel yy_modelWithJSON:launchData];
    }
}

- (void)saveLaunchModel
{
    NSData *launchData = self.launchModel.yy_modelToJSONData;
    [[NSUserDefaults standardUserDefaults]setObject:launchData forKey:kLaunchModel];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
@end
