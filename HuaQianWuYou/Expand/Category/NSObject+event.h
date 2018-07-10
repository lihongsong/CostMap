//
//  NSObject+event.h
//  JiKeLoan
//
//  Created by lhs7248 on 2017/4/10.
//  Copyright © 2017年 JiKeLoan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (event)

// eventId  事件的标示   eventLabel 是事件的描述
-(void)eventId:(NSString *)eventId;


-(void)eventId:(NSString *)eventId durationTime:(NSTimeInterval)time;

// 记录某个页面访问的开始， 建议在ViewController的viewDidAppear函数中调用
-(void)pageviewStartWithName:(NSString *)name;

// 记录某个页面访问的结束， 建议在ViewController的viewDidDisappear函数中调用
- (void)pageviewEndWithName:(NSString *)name;

@end
