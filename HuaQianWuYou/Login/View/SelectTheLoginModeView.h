//
//  SelectTheLoginModeView.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/4.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectTheLoginModeViewDelegate<NSObject>
- (void)selectTheLoginModeCode;//验证码登录
- (void)selectTheLoginModePassword;//密码登录
@end

@interface SelectTheLoginModeView : UIView
@property(nonatomic,weak)id<SelectTheLoginModeViewDelegate>delegate;
@end
