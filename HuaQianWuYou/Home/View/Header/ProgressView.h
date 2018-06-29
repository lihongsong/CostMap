//
//  ProgressView.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/15.
//  Copyright © 2018年 jason. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ProgressView : UIView
//中心点坐标
@property(nonatomic)CGPoint point;
//半径，底层半径，上层半径，中间层半径
@property(nonatomic)float bj;
//线的宽度
@property(nonatomic)float zj_kd;
//终点
@property(nonatomic)float z1;

//渐变层坐标大小
@property(nonatomic)CGRect rect1,rect2;

@property(nonatomic)float z;

@property(nonatomic)CAGradientLayer * gradientlayer1,*gradientlayer2;

@property(nonatomic)CALayer * layer_d;

@property(nonatomic)CAShapeLayer * shapelayer;

@property(nonatomic)NSArray * array1,*array2;

@property(nonatomic)UIBezierPath * apath;

@property(nonatomic,strong)UIView *bgView;

@property(nonatomic)CABasicAnimation *animation;
@property (nonatomic)float toValue;//好信分比例
@property(nonatomic,assign)CGAffineTransform lastTransform;
-(void)startAnimaition;
@end
