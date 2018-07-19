//
//  Circle.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Circle : UIView
//中间文字
@property (assign,nonatomic)NSString* centerState;
// 中心颜色
@property (strong,nonatomic)UIColor* centerColor;
// 圆环背景颜色
@property (strong,nonatomic)UIColor* cycleBegColor;
// 圆环颜色
@property (strong,nonatomic)UIColor* cycleFinishColor;

@property (strong,nonatomic)UIColor* cycleUnfinishColor;
// 百分比数值
@property (assign,nonatomic)float percent;
//  圆环宽度
@property (assign,nonatomic)float width;
@property(nonatomic,strong)UILabel *stateLabel;
@end
