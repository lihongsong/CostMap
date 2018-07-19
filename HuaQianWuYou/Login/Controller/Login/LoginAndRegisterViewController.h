//
//  LoginViewController.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/4.
//  Copyright © 2018年 2345. All rights reserved.
//
typedef void (^loginFinishBlock)(void);
typedef void (^loginForgetBlock)(void);
typedef void (^loginOutBlock)(BOOL);
#import "BaseViewController.h"


@interface LoginAndRegisterViewController: BaseViewController
@property (nonatomic,copy)loginFinishBlock loginBlock;
@property (nonatomic,copy)loginForgetBlock forgetBlock;
@end
