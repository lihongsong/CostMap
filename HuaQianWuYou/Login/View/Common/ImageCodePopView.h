//
//  ImageCodeView.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/6.
//  Copyright © 2018年 2345. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCodePopView : UIView
@property (weak, nonatomic) IBOutlet UITextField *imageCodeInputLable;
@property (weak, nonatomic) IBOutlet UIImageView *codeImageVIew;
@property (weak, nonatomic) IBOutlet UIButton *canceButton;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (nonatomic ,copy) NSString *base64ImageStr;
@end
