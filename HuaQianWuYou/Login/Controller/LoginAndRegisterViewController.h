//
//  LoginViewController.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/4.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^loginFinishBlock) (void);

@interface LoginAndRegisterViewController: BaseViewController
@property (nonatomic,copy)loginFinishBlock loginBlock;
@end
