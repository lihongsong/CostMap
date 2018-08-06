//
//  UNProgressBar.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/8/6.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UNProgressBar : UIView
@property(nonatomic, assign) BOOL isLoading;
@property(nonatomic, assign) CGFloat progress;
@property(nonatomic, strong) NSTimer *progressTimer;
@property(nonatomic, strong) UIImageView *progressView;

- (void)progressUpdate:(CGFloat)progress;
- (void)updateProgress:(CGFloat)progress;
@end
