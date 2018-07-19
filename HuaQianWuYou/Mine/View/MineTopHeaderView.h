//
//  MineTopHeaderView.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QBMineHeaderViewDelegate<NSObject>
- (void)mineHeaderClick;
@end

typedef void(^LoginBtnBlock)(void);

@interface MineTopHeaderView : UIView
@property(nonatomic, assign) BOOL isUserLogin;
@property(nonatomic, strong) LoginBtnBlock loginBlock;
@property(nonatomic, strong) UIButton *headButton;
@property(nonatomic,retain)id<QBMineHeaderViewDelegate>delegate;
@end
