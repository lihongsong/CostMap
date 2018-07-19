//
//  LaunchViewController.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/6/5.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AccomplishBlock)(NSString *exampleCreditScore);

@interface LaunchViewController : BaseViewController
@property(nonatomic, strong) AccomplishBlock accomplishBlock;
@end
