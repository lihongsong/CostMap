//
//  HQWYJavaScriptSourceHandler.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/30.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYJavaScriptBaseHandler.h"

@interface HQWYJavaScriptSourceHandler : HQWYJavaScriptBaseHandler
- (void)didReceiveMessage:(id)message hander:(HJResponseCallback)hander;
@end
