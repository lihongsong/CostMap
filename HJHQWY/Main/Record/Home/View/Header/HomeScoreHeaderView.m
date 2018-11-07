//
//  HomeScoreHeaderView.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/15.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "HomeScoreHeaderView.h"
#import "ScoreProgressView.h"
#import "ZYZControl.h"

@interface HomeScoreHeaderView()
@property(nonatomic,strong)ScoreProgressView *scoreProgress;

@property(nonatomic,strong)UIButton *continueCheckButton;
@end

@implementation HomeScoreHeaderView
//代码创建初始化
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    UIImageView *headerBg = [[UIImageView alloc] initWithFrame:frame];
    headerBg.image = [UIImage imageNamed:@"home_head_bg"];
    [self addSubview:headerBg];
    [self setchushihua:frame];
    return  self;
}

- (void)setchushihua:(CGRect)frame{
    
    UIImageView *bgImageView = [[UIImageView alloc]init];
    bgImageView.frame = CGRectMake(self.scoreProgress.center.x - 124, 20, 248, 248);
    bgImageView.image = [UIImage imageNamed:@"bg_dial_scale"];
    [self addSubview:bgImageView];
    [self addSubview:self.scoreProgress];
    self.waveView = [[WangYiWave alloc]initWithFrame:CGRectMake(0, frame.size.height - 45, frame.size.width, 41)];
    self.waveView.speed = 2;
    self.waveView.waveHeight = 10;
    [self addSubview:self.waveView];
    UIImageView *animationBGImage = [ZYZControl createImageViewFrame:CGRectMake(0, frame.size.height - 22.5, frame.size.width, 23) imageName:@"home_bg_wave_mask"];
    [self addSubview:animationBGImage];
    [self.waveView wave];
    [self addSubview:self.continueCheckButton];
    self.continueCheckButton.hidden = true;
}

-(void)setProgress:(float)progress
{
    _progress = progress;
    self.scoreProgress.progress = progress;
}

-(void)setStatus:(NSString *)status{
    self.scoreProgress.statusLabel.text = status;
    _status = status;
}

-(void)setTime:(NSString *)time{
    self.scoreProgress.timeLabel.text = time;
    _time = time;
}

-(UIButton *)continueCheckButton{
    if(_continueCheckButton == nil){
        _continueCheckButton = [ZYZControl createButtonWithFrame:CGRectMake(SWidth - 100, 10, 110, 30) target:self SEL:@selector(checkReportClick) title:@"继续查询报告"];
        [_continueCheckButton setBackgroundImage:[UIImage imageNamed:@"home_my_report"] forState:UIControlStateNormal];
        [_continueCheckButton setImage:[UIImage imageNamed:@"public_arrow_03"] forState:UIControlStateNormal];
        [_continueCheckButton setImageEdgeInsets:UIEdgeInsetsMake(0, 87, 0, 0)];
        [_continueCheckButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 12)];
        _continueCheckButton.titleLabel.font = [UIFont stateFont];
    }
    return _continueCheckButton;
}

-(void)setIsCheckMyReport:(BOOL)isCheckMyReport{
    NSLog(@"%d",isCheckMyReport);
    self.continueCheckButton.hidden = !isCheckMyReport;
}

-(void)checkReportClick{
    if ([self.delegate respondsToSelector:@selector(continueCheckMyReport)]) {
        [self.delegate continueCheckMyReport];
    }
}

- (ScoreProgressView *)scoreProgress
{
    if (_scoreProgress  == nil) {
        _scoreProgress = [[ScoreProgressView alloc]initWithFrame:CGRectMake((SWidth - 240)/2.0, 22, 240, 155)];
        _scoreProgress.backgroundColor = [UIColor clearColor];
        ;
    }
    return _scoreProgress;
}

-(void)startAnimation{
    [self.scoreProgress start];
}

@end
