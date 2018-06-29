//
//  BaseViewController.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/4.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultView.h"

@interface BaseViewController : UIViewController
@property (nonatomic, strong) DefaultView *defaultView;
- (void)setLelftNavigationItem:(BOOL)hidden;
- (void)setLelftNavigationItemWithImageName:(NSString *)imageName hidden:(BOOL)hidden;
- (void)showAlertView;
@end
