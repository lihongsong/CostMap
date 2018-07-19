//
//  ActiveViewController.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/6/29.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYBaseWebViewController.h"
typedef void (^SignFinishBlock)(void);
@interface ActiveViewController : HQWYBaseWebViewController 

/** 给JS发送通用数据 */
- (void)sendMessageToJS:(id)message;

- (void)showPopView;

@end
