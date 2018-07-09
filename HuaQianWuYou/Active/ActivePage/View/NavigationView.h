//
//  NavigationView.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/6.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftItemButton.h"

@protocol NavigationViewDelegate<NSObject>
@optional
- (void)locationButtonClick;
- (void)webGoBack;
- (void)rightButtonItemClick;
@end

@interface NavigationView : UIView
@property (strong, nonatomic)LeftItemButton *leftItemButton;
@property(nonatomic,strong)id<NavigationViewDelegate>delegate;

- (void)changeNavigationType:(NSDictionary *)typeDic;

@end
