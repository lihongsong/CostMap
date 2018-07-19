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
    [BasicDataModel requestBasicData:AdvertisingTypeStartPage productId:self.launchModel.productId sort:self.launchModel.sort Completion:^(BasicDataModel * _Nullable result, NSError * _Nullable error) {
        if (error) {
            [HJGuidePageWindow dismiss];
            return ;
        }
        BasicDataModel *lanuchPageModel = result;
        if (ObjIsNilOrNull(lanuchPageModel)) {// 空对象为什么还会有值？
            [HJGuidePageWindow dismiss];
            return;
        }else{
            getFromNet = YES;
            self.launchModel = lanuchPageModel;
            [self showCustomLaunchImage:self.launchModel fromVC:self.rootViewController];
            [BasicDataModel cacheToLoacl:self.launchModel withType:AdvertisingTypeStartPage];
            return;
        }
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.launchModel == nil) {// 第一次的情况
            [HJGuidePageWindow dismiss];
        }else{
            
        }
    });
}

- (void)showCustomLaunchImage:(BasicDataModel*)model fromVC:(UIViewController*)vc
{
            self.guideVC.setTimer(3,0, @"s跳过",NO);
            WeakObj(self)
    self.guideVC.setBackGroundImage(self.launchModel.imgUrl, YES, NO, ^{
                //StrongObj(self)
                [HQWYActionHandler handleWithActionModel:model fromVC:vc];
                    [HJGuidePageWindow dismiss];
            });
            [self.guideVC reloadData];
}
@end
