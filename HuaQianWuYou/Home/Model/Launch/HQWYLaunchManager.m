//
//  HQWYLaunchManager.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/12.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYLaunchManager.h"
#import "HJGuidePageWindow.h"
#import "BasicDataModel+Service.h"
#import "HQWYActionHandler.h"
@interface HQWYLaunchManager()

@end

@implementation HQWYLaunchManager
- (void)showLanuchPageModel
{
    __block BOOL getFromNet = NO;
   self.launchModel = [BasicDataModel getCacheModel:AdvertisingTypeStartPage];
    [BasicDataModel requestBasicData:AdvertisingTypeStartPage productId:self.launchModel.AdvertisingVO.productId sort:self.launchModel.AdvertisingVO.sort Completion:^(BasicDataModel * _Nullable result, NSError * _Nullable error) {
        if (error) {
            return ;
        }
        BasicDataModel *lanuchPageModel = result;
        if (ObjIsNilOrNull(lanuchPageModel)||ObjIsNilOrNull(lanuchPageModel.AdvertisingVO)) {// 空对象为什么还会有值？
            return;
        }else{
            getFromNet = YES;
            self.launchModel = lanuchPageModel;
            [BasicDataModel cacheToLoacl:self.launchModel withType:AdvertisingTypeStartPage];
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
            self.guideVC.setTimer(3,0, @"s跳过",NO);
            WeakObj(self)
    self.guideVC.setBackGroundImage(self.launchModel.AdvertisingVO.imgUrl, YES, NO, ^{
                StrongObj(self)
                [HQWYActionHandler handleWithActionModel:self.launchModel.AdvertisingVO];
                    [HJGuidePageWindow dismiss];
            });
            [self.guideVC reloadData];
}
@end
