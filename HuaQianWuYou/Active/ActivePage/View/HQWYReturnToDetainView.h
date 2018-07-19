//
//  HQWYReturnToDetainView.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/9.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HQWYReturnToDetainViewDelegate<NSObject>

- (void)cancleAlertClick;

- (void)nonePromptButtonClick;
@end

@interface HQWYReturnToDetainView : UIView
@property(nonatomic,strong)UILabel *countTimeLabel;
@property(nonatomic,weak)id<HQWYReturnToDetainViewDelegate>delegate;
+ (HQWYReturnToDetainView *)sharedView;
+ (void)showController:(UIViewController*)vc;
+ (void)dismiss;
+ (void)countTime:(NSString *)time;
@end
