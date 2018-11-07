//
//  CircleProgressView.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDataModel.h"

@interface CircleProgressView : UIView
@property(nonatomic,strong) HomeDataModel *model;
@property(nonatomic,strong) NSTimer *timer;
-(void)refreshData;
@end
