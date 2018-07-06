//
//  RightItemView.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftItemButton.h"
typedef NS_ENUM(NSInteger, LeftItemViewType) {
    LeftItemViewTypeLocationAndRecommendation = 100, //定位左 精准推荐右
    LeftItemViewTypeBack = 101,//返回按钮左，右无
    LeftItemViewTypeRecommendation = 200, //左无，精准推荐右
    LeftItemViewTypeBackAndRecommendation = 201,//左返回按钮，右精准推荐
    LeftItemViewTypeNone = 300, //无按钮
    LeftItemViewTypeNoneNavigation = 400,//无按钮
};

@protocol LeftItemViewDelegate<NSObject>
- (void)locationButtonClick;
- (void)webGoBack;
@end

@interface LeftItemView : UIView
@property (strong, nonatomic)LeftItemButton *leftItemButton;
@property(nonatomic,strong)id<LeftItemViewDelegate>delegate;

- (void)changeType:(NSInteger)type;

@end
