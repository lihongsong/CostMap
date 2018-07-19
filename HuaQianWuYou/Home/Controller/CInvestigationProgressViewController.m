//
//  CInvestigationProgressViewController.m
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "CInvestigationProgressViewController.h"
#import "Circle.h"
#import "CInvestigationModel.h"
#import "CInvestigationModel+Service.h"
#import "CInvestigationResultViewController.h"

@interface CInvestigationProgressViewController (){
    NSTimer *timer;
    float currentPercent;
}
@property(nonatomic, strong) Circle *circleProgressView;
@property(nonatomic, strong) UILabel *progressLabel;

@end

@implementation CInvestigationProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    WeakObj(self);
    self.title = @"查询中";
    [self.view addSubview:self.circleProgressView];
    [self.circleProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongObj(self);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(107.5);
        make.size.mas_equalTo(CGSizeMake(180, 180));
    }];
    
    [self.circleProgressView addSubview:self.progressLabel];
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.circleProgressView.center);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];

    UILabel *tipLabel = [UILabel new];
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(selfWeak.circleProgressView.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(21);
        make.centerX.mas_equalTo(selfWeak.view.mas_centerX);
    }];
    tipLabel.text = @"正在查询您的评分报告，请稍等片刻";
    tipLabel.textColor = HJHexColor(0x999999);
    tipLabel.font = [UIFont systemFontOfSize:15];
    [self.view layoutIfNeeded];
    currentPercent = 0.0;
    timer = [NSTimer timerWithTimeInterval:0.05
                                    target:self
                                  selector:@selector(animation)
                                  userInfo:nil
                                   repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer
                                 forMode:NSRunLoopCommonModes];
}

- (void)animation {
    currentPercent += 0.05;
    if (currentPercent >= 1) {
        [self->timer invalidate];
        currentPercent = 1;
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.accomplishBlock) {
                self.accomplishBlock();
            }
        }];
    }
    self.circleProgressView.percent = currentPercent;
    self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",currentPercent * 100];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (Circle *)circleProgressView {
    if (!_circleProgressView) {
        _circleProgressView = [Circle new];
        _circleProgressView.width = 9;
        _circleProgressView.cycleUnfinishColor = HJHexColor(0xFC8E22);
        _circleProgressView.cycleBegColor = HJHexColor(0xE6E6E6);
        _circleProgressView.cycleFinishColor = HJHexColor(0xFC8E22);
    }
    return _circleProgressView;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [UILabel new];
        _progressLabel.text = @"0.00%";
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.textColor = HJHexColor(0x999999);
    }
    return _progressLabel;
}

- (void)dealloc {
    self->timer = nil;
}

@end
