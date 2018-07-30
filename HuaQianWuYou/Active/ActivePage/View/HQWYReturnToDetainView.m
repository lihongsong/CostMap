//
//  HQWYReturnToDetainView.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/9.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYReturnToDetainView.h"
#import "ThirdPartWebVC.h"

@interface HQWYReturnToDetainView()

@property (nonatomic, strong) UIControl *overlayView;

@property (nonatomic, strong) UIView *hudView;
@property (nonatomic, strong) UIView *bgView;
@property(nonatomic,strong)UIButton *cancleButton;
@property(nonatomic,strong)UIButton *promptButton;
@end

@implementation HQWYReturnToDetainView
+ (HQWYReturnToDetainView *)sharedView {
    static dispatch_once_t once;
    static HQWYReturnToDetainView *sharedView;
    dispatch_once(&once, ^ { sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];});
    return sharedView;
}
#pragma mark - Show Methods

+ (void)showController:(ThirdPartWebVC *)vc {
    [self sharedView];
    [self sharedView].delegate = vc;
    [[self sharedView] updatePosition];
}

+ (void)countTime:(NSString *)time{
    [[self sharedView] setCountLabelTime:time];
}

- (void)setCountLabelTime:(NSString *)time{
    self.countTimeLabel.text = time;
}

-(void)updatePosition{
    self.bgView.userInteractionEnabled = YES;
    CGPoint center = CGPointMake((SWidth)/2,SHeight/2);
    self.hudView.center = center;
    [self setUpHUDUI];
    self.alpha = 1;
    self.userInteractionEnabled = false;
    self.isAccessibilityElement = YES;
    
    self.overlayView.userInteractionEnabled = YES;
    [self.overlayView.superview bringSubviewToFront:self.overlayView];
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            [window addSubview:self.overlayView];
            break;
        }
    }
    if(!self.superview){
        [self.overlayView addSubview:self];
    }
}

- (UIView *)bgView {
    if(!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor lightGrayColor];
        _bgView.alpha = 0.5;
    }
    if(!_bgView.superview){
        [self addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _bgView;
}

- (UIView *)hudView {
    if(!_hudView) {
        _hudView = [[UIView alloc] init];
        _hudView.userInteractionEnabled = YES;
        _hudView.backgroundColor = [UIColor whiteColor];
        _hudView.layer.cornerRadius = 6;
        _hudView.layer.masksToBounds = YES;
    }
    if(!_hudView.superview){
        [self addSubview:_hudView];
        [_hudView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY).offset(-0);
            make.left.mas_equalTo(self.mas_left).offset(15);
            make.right.mas_equalTo(self.mas_right).offset(-15);
            make.height.mas_equalTo(220);
        }];
    }
    return _hudView;
}

- (UIControl *)overlayView {
    if(!_overlayView) {
        _overlayView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayView.userInteractionEnabled = true;
        //_overlayView.backgroundColor = [UIColor clearColor];
        //[_overlayView addTarget:self action:@selector(overlayViewDidReceiveTouchEvent:forEvent:) forControlEvents:UIControlEventTouchDown];
    }
    return _overlayView;
}

+ (void)dismiss {
    [[self sharedView] dismiss];
}

- (void)dismiss {
    WeakObj(self)
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 0.8f, 0.8f);
                         self.hudView.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         if(self.alpha == 0.0f || self.hudView.alpha == 0.0f) {
                             self.alpha = 0.0f;
                             self.hudView.alpha = 0.0f;
                             [selfWeak.hudView removeFromSuperview];
                             selfWeak.hudView = nil;
                             
                             [selfWeak.overlayView removeFromSuperview];
                             selfWeak.overlayView = nil;
                         }
                     }];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
    return self;
}

-(void)setUpHUDUI{
    [self.hudView addSubview:self.cancleButton];
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.hudView.mas_right).mas_offset(-5);
        make.top.mas_equalTo(self.hudView.mas_top).mas_offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
    UILabel *topLabel = [[UILabel alloc]init];
    topLabel.text = @"下一笔钱马上来......";
    topLabel.font = [UIFont BigTitleFont];
    [self.hudView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(self.hudView.mas_centerX);
        make.right.mas_equalTo(self.cancleButton.mas_left).offset(0);
        make.top.mas_equalTo(self.hudView.mas_top).offset(30);
        
    }];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.textColor = [UIColor grayColor];
    [self.hudView addSubview:topLabel];
    
    [self.hudView addSubview:self.countTimeLabel];
    [self.countTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.hudView.mas_centerX);
        make.centerY.mas_equalTo(self.hudView.mas_centerY).offset(-10);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(70);
    }];
    UILabel *bigLabel = [[UILabel alloc]init];
     [self.hudView addSubview:bigLabel];
    [bigLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countTimeLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.hudView.mas_left).offset(15);
        make.right.mas_equalTo(self.hudView.mas_right).offset(-15);
        make.height.mas_equalTo(20);
    }];
    bigLabel.text = @"申请越多，成功率越高";
    bigLabel.font = [UIFont NormalSmallTitleFont];
    bigLabel.textColor = [UIColor grayColor];
    bigLabel.textAlignment = NSTextAlignmentCenter;
   
    [self.hudView addSubview:self.promptButton];
    [self.promptButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.hudView.mas_centerX);
        make.bottom.mas_equalTo(self.hudView.mas_bottom).mas_offset(-18);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    UIView *lineView =  [[UIView alloc]init];
    [self.hudView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.promptButton.mas_centerX).mas_offset(0);
        make.centerY.mas_equalTo(self.promptButton.mas_centerY).mas_offset(9);
        make.width.mas_equalTo(89);
        make.height.mas_equalTo(1);
    }];
    lineView.backgroundColor = [UIColor loginGrayColor];
    
}

-(UIButton *)cancleButton
{
    if (_cancleButton == nil) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleButton addTarget:self action:@selector(cancleButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_cancleButton setImage:[UIImage imageNamed:@"navbar_close"] forState:UIControlStateNormal];
    }
    return _cancleButton;
}

-(UIButton *)promptButton
{
    if (_promptButton == nil) {
        _promptButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_promptButton addTarget:self action:@selector(promptButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_promptButton setTitle:@"今日不再提示" forState:UIControlStateNormal];
        [_promptButton setTitleColor:[UIColor loginGrayColor] forState:UIControlStateNormal];
        _promptButton.titleLabel.font = [UIFont NormalSmallTitleFont];
    }
    return _promptButton;
}

-(UILabel *)countTimeLabel
{
    if (_countTimeLabel == nil) {
        _countTimeLabel = [[UILabel alloc]init];
        _countTimeLabel.font = [UIFont boldSystemFontOfSize:60];
        _countTimeLabel.textColor = [UIColor skinColor];
        _countTimeLabel.text = @"3";
        _countTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _countTimeLabel;
}

#pragma mark 取消点击
- (void)cancleButtonClick{
    [self eventId:HQWY_ThirdPart_AlertClose_click];
    if ([self.delegate respondsToSelector:@selector(cancleAlertClick)]) {
        [self.delegate cancleAlertClick];
    }
}

#pragma mark 今日不再提示点击事件
- (void)promptButtonClick{
    [self eventId:HQWY_ThirdPart_NoneAlert_click];
    if ([self.delegate respondsToSelector:@selector(nonePromptButtonClick)]) {
        [self.delegate nonePromptButtonClick];
    }
}

@end
