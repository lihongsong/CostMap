//
//  MineTopHeaderView.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginBtnBlock)(void);

@interface MineTopHeaderView : UIView
@property(nonatomic, assign) BOOL isUserLogin;
@property(nonatomic, strong) LoginBtnBlock loginBlock;
@end
