//
//  PasswordViewController.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PasswordType) {
    PasswordTypeSet,
    PasswordTypeCode
};
@interface PasswordViewController : UIViewController

/* 密码类型 设置 还是修改 */
@property (nonatomic, assign) PasswordType  type;


+ (instancetype)instance;
@end
