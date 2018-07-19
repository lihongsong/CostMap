//
//  HomeScoreHeaderView.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/15.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "waveAnimationView.h"
#import "WangYiWave.h"
@protocol HomeScoreHeaderViewDelegate<NSObject>
-(void)continueCheckMyReport;
@end

@interface HomeScoreHeaderView : UIView
@property(nonatomic,assign)BOOL isCheckMyReport;
@property(nonatomic,weak)id<HomeScoreHeaderViewDelegate> delegate;
@property(nonatomic,strong)WangYiWave *waveView;
@property (nonatomic)float progress;
//状况
@property (nonatomic,assign)NSString *status;
//评估时间
@property (nonatomic,assign)NSString *time;
-(void)startAnimation;
@end
