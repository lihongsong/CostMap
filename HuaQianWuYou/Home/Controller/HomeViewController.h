//
//  HomeViewController.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/9.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BackBlock)(void);
@interface HomeViewController : BaseViewController
@property(nonatomic,assign)BOOL isCheckMyReport;
@property(nonatomic,strong)BackBlock backBlock;
@end
