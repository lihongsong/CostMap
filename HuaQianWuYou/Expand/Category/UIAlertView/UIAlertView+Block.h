//
//  UIAlertView+Block.h
//  PowerProject
//
//  Created by AndyMu on 16/1/19.
//  Copyright © 2016年 Pay&Wish. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertViewCallBackBlock)(NSInteger buttonIndex);

@interface UIAlertView (Block)<UIAlertViewDelegate>

@property (strong, nonatomic) UIAlertViewCallBackBlock alertViewCallBackBlock;

+ (void)alertWithCallBackBlock:(UIAlertViewCallBackBlock)alertViewCallBackBlock title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

@end
