//
//  SetPasswordViewController.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FixPWDBlock)(void);

@interface SetPasswordViewController : BaseViewController

/* 验证码 */
@property (nonatomic, strong) NSString  *code;


/* 手机号 */
@property (nonatomic, strong) NSString  *mobilePhone;

/* 业务流水号 */
@property (nonatomic, strong) NSString  *serialNumber;

@property(nonatomic,copy)FixPWDBlock finishblock;

@end
