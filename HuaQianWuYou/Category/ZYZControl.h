//
//  ZYZControl.h
//  SmartCar
//
//  Created by AsiaZhang on 16/4/28.
//  Copyright © 2016年 ZhiQiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYZControl : NSObject

#pragma mark 创建View
+(UIView*)createViewWithFrame:(CGRect)frame;
#pragma mark 创建label
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(UIFont *)font Text:(NSString*)text;
#pragma mark 创建button
+(UIButton*)createButtonWithFrame:(CGRect)frame target:(id)target SEL:(SEL)method title:(NSString*)title;
#pragma mark 创建imageView
+(UIImageView*)createImageViewFrame:(CGRect)frame imageName:(NSString*)imageName;
#pragma mark 创建textField
+(UITextField*)createTextFieldFrame:(CGRect)frame Font:(UIFont *)font textColor:(UIColor*)color leftImageName:(NSString*)leftImageName rightImageName:(NSString*)rightImageName bgImageName:(NSString*)bgImageName placeHolder:(NSString*)placeHolder sucureTextEntry:(BOOL)isOpen;
#pragma mark 创建textView
+(UITextView*)createTextViewFrame:(CGRect)frame Font:(UIFont *)font textColor:(UIColor*)color Text:(NSString*)text;
@end
