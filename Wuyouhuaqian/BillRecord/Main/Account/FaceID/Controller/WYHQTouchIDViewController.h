//
//  TouchIDViewController.h
// WuYouQianBao
//
//  Created by jasonzhang on 2018/5/22.
//  Copyright © 2018年 jasonzhang. All rights reserved.
//

#import "WYHQBaseViewController.h"

@interface WYHQTouchIDViewController : WYHQBaseViewController

//验证通过和失败回调
@property (nonatomic,copy) void(^rootStartVC)(BOOL isCheckPass);

@end
