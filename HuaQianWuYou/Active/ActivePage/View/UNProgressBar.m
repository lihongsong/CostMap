//
//  UNProgressBar.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/8/6.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "UNProgressBar.h"
#import "UIView+ViewKit.h"

@implementation UNProgressBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.progressView];
    }
    return self;
}

- (void)progressUpdate:(CGFloat)progress {
    if (!self.isLoading) {
        return;
    }
    if (progress == 1) {
        if (self.frame.size.width > 0) {
            [self finishProgress];
        }
        
    } else {
        self.progress = progress;
        [self initProgressTimer];
        
    }
}

- (void)updateProgress:(CGFloat)progress {
    if (progress == 0) {
        [self deallocProgressTimer];
        [self.progressView setWidth:0];
    }
}

- (void)initProgressTimer {
    if (!self.progressTimer || ![self.progressTimer isValid]) {
        self.progressTimer = [NSTimer timerWithTimeInterval:.02 target:self selector:@selector(progressTimerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
        if ([_progressTimer isValid]) {
            [self.progressTimer fire];
        }
    }
}

- (void)finishProgress {
    [self deallocProgressTimer];
    NSTimeInterval inter = .2;
    if (self.progressView.width < self.bounds.size.width * 0.5) {
        inter = .3;
    }
    
    if (self.progressView.width > 0) {
        [UIView animateWithDuration:inter animations:^{
            [self.progressView setWidth:self.bounds.size.width]; //先滑倒最后再消失
        }                completion:^(BOOL finished) {
            [self cleanProgressWidth];
        }];
    }
}

- (void)cleanProgressWidth {
    [self.progressView setWidth:0];
}

- (void)deallocProgressTimer {
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

- (void)progressTimerAction:(NSTimer *)timer {
    if (!self.isLoading) {
        [self finishProgress];
        return;
    }
    CGFloat ProgressWidth = self.bounds.size.width * 0.005; //千分之五,4s钟走完
    CGFloat currentProgessWidth = self.progressView.width;
    CGFloat currentProgress = self.progressView.width / self.bounds.size.width;
    
    if (currentProgress < self.progress) {
        //当前的进度比真实进度慢，快速加载
        ProgressWidth = self.bounds.size.width * 0.01;
    }
    else {
        // NSLog(@"11111111111111");
    }
    if (currentProgessWidth < self.bounds.size.width * 0.98) {
        //到达99%的时候等待网页进度
        [self.progressView setWidth:currentProgessWidth + ProgressWidth];
    }
    else {
        if (!self.isLoading) {
            [self finishProgress];
        }
    }
}

#pragma mark - Getter

-(UIImageView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
        _progressView.backgroundColor = [UIColor skinColor];
    }
    return _progressView;
}
@end
