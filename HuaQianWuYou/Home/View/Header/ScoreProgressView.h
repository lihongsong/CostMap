//
//  ScoreProgressView.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/15.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"

@interface ScoreProgressView : UIView

//线的宽度
@property(nonatomic)float kd;
//zhi
@property(nonatomic)float z;

//@property(nonatomic)yuan2_sc * sc;

@property(nonatomic)ProgressView * zj;
//状况
@property (nonatomic,strong)UILabel *statusLabel;
//评估时间
@property (nonatomic,strong)UILabel *timeLabel;

@property (nonatomic)float progress;
-(void)start;
@end
