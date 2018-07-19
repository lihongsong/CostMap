//
//  SetPasswordViewController.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetPasswordViewController : UIViewController

/* 验证码 */
@property (nonatomic, strong) NSString  *code;

/* 跳转类型 */
@property (nonatomic, strong) NSString  *jumpType;

/* 手机号 */
@property (nonatomic, strong) NSString  *mobilePhone;

/* 业务流水号 */
@property (nonatomic, strong) NSString  *serialNumber;




@end
