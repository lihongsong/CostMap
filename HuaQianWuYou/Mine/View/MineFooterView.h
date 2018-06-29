//
//  MineFooterView.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^logoutBlock)(void);

@interface MineFooterView : UIView

@property(nonatomic, strong) logoutBlock tapLogout;
@end
