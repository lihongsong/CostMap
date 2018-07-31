//
//  ThirdPartWebVC.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/9.
//  Copyright © 2018年 2345. All rights reserved.
//


#import "HQWYBaseWebViewController.h"
#import "HQWYReturnToDetainView.h"

typedef void (^RightClickBlock)(void);

@interface ThirdPartWebVC : HQWYBaseWebViewController<HQWYReturnToDetainViewDelegate>
@property (nonatomic, strong) NSDictionary *navigationDic;
@property (nonatomic, copy) RightClickBlock rightBlock;
@end
