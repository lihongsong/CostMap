//
//  AuthPhoneNumViewController.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FixPWDBlock)(void);
//typedef NS_ENUM(NSInteger,PopControllerType) {
//    PopControllerTypeLogin = 21;
//    
//};

@interface AuthPhoneNumViewController : BaseViewController
@property(nonatomic,copy)FixPWDBlock finishblock;
@end
