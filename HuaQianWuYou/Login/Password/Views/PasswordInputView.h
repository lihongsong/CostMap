//
//  PasswordInputView.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/5.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PasswordInputType){
    /*设置密码*/
    PasswordInputTypeSet,
    /*验证手机号*/
    PasswordInputTypeAuthPhoneNum
    
};

@protocol PasswordInputViewDelegate <NSObject>
- (void)textFieldContentdidChangeValues:(NSString *)firstValue
                            secondValue:(NSString *)secondValue;
@optional
- (void)didSendAuthCode;
@end

@interface PasswordInputView : UIView

@property (nonatomic ,assign) PasswordInputType type;

@property (nonatomic ,weak) id<PasswordInputViewDelegate> delegate;

+ (instancetype)instance;

@end
