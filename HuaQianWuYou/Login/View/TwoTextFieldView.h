//
//  TwoTextFieldView.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/4.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, TextFieldType) {
    TextFieldTypeCode,//验证码
    TextFieldTypeIsSeePassword,//密码是否可见
    TextFieldTypeForget, //忘记密码
    TextFieldTypeNoneIsSeePassword,//没有密码是否可见
    TextFieldTypeModify//修改密码
};

@protocol TwoTextFieldViewDelegate<NSObject>
    - (void)getSMSCode;
@end

@interface TwoTextFieldView : UIView
@property(nonatomic,strong)UITextField  *firstTF;
@property(nonatomic,strong)UITextField  *secondTF;
@property(nonatomic,strong)UIButton *codeButton;//验证码
@property(nonatomic,strong)UIButton *eyeButton;//密码是否可见
@property(nonatomic,strong)UIView *firstLineView;
@property(nonatomic,strong)UIView *secondLineView;
@property(nonatomic,weak)id<TwoTextFieldViewDelegate>delegate;

- (void)setType:(TextFieldType)type;
@end
