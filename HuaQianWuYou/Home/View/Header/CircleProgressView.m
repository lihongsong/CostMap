//
//  CircleProgressView.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/17.
//  Copyright © 2018年 jason. All rights reserved.
//
#define CircleSpace 27
#import "CircleProgressView.h"
#import "Circle.h"

@interface CircleProgressView()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)Circle *circleView;
@property(nonatomic,assign)float time;
@end

@implementation CircleProgressView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    float circleWidth = (self.hj_width - CircleSpace * 5)/4.0;
    NSArray *arr = @[@"2015年",@"2016年",@"2017年",@"2018年"];
    NSArray *colorArr = @[[UIColor colorFromHexCode:@"#FC8E22"],[UIColor colorFromHexCode:@"#3389FF"],[UIColor colorFromHexCode:@"#FD6F93"],[UIColor colorFromHexCode:@"#B269FF"]];
    NSArray *stateArr = @[@"12次",@"8次",@"10次",@"2次"];
    NSArray *percentArr = @[@"0.75",@"0.5",@"0.625",@"0.125"];
    self.time = 0.0;
    for (int i = 0; i < 4; i++) {
        Circle *circleView = [[Circle alloc]initWithFrame:CGRectMake(CircleSpace + i * (CircleSpace + circleWidth), 10, circleWidth, circleWidth)];
        circleView.percent = [percentArr[i] floatValue];
        circleView.tag = 100 + i;
        circleView.width = 5;
        circleView.cycleBegColor = [UIColor sepreateColor];
        circleView.cycleUnfinishColor = colorArr[i];
        circleView.centerState = stateArr[i];
        circleView.stateLabel.textColor = colorArr[i];
        [self addSubview:circleView];
        
        UILabel *titleLabel = [ZYZControl createLabelWithFrame:CGRectMake(CircleSpace/2.0 + i * (CircleSpace + circleWidth), CGRectGetMaxY(circleView.frame) + 5, circleWidth + CircleSpace , 40) Font:[UIFont stateFont] Text:arr[i]];
        titleLabel.textColor = [UIColor colorFromHexCode:@"333333"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
    }
    return self;
}

-(void)setModel:(HomeDataModel *)model{
    //self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateValue) userInfo:nil repeats:nil];
        for (int i = 0; i < 4; i++) {
            Circle *v = (Circle*)[self viewWithTag:100 + i];
            NSLog(@"____%@",model.credictApplyRecode[i]);
            v.stateLabel.text = [NSString stringWithFormat:@"%@次", model.credictApplyRecode[i]];
        }
}

-(void)refreshData{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateValue) userInfo:nil repeats:false];
}

-(void)updateValue{
    self.time += 0.1;
    if (self.time >= 0.7) {
        self.timer = nil;
    }else{
        NSLog(@"%f",self.time);
        for (int i = 0; i < 4; i++) {
            Circle *v = (Circle*)[self viewWithTag:100 + i];
            v.percent = self.time;
        }
    }
}


@end
