//
//  ImageCodeViewController.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/6.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^sureBlock)(NSString *imageCode,NSString *serialNumber);

@interface ImageCodeViewController : UIViewController

/* 确定block */
@property (nonatomic, copy) sureBlock  block;

/* 图片 */
@property (nonatomic, copy) NSString  *imageStr;

/* serialNumber */
@property (nonatomic, copy) NSString  *serialNumber;

@end
