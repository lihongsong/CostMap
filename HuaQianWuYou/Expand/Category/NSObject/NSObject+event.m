//
//  NSObject+event.m
//  JiKeLoan
//
//  Created by lhs7248 on 2017/4/10.
//  Copyright © 2017年 JiKeLoan. All rights reserved.
//

#import "NSObject+event.h"

#import <RCMobClick/RCMobClick.h>
#import "TalkingData.h"

#define AnalyticsLabel  @"com.boccfc.loan"

@implementation NSObject (event)

-(void)eventId:(NSString *)eventId{
    if (eventId) {
        [TalkingData trackEvent:eventId label:AnalyticsLabel];
        [RCMobClick event:eventId]; //武林榜单统计
    }
}


-(void)eventId:(NSString *)eventId durationTime:(NSTimeInterval)time{
    if (eventId&& time) {
        [TalkingData trackEvent:eventId label:AnalyticsLabel parameters:@{@"duration":@(time)}];
    }
    
    if (eventId) {
        [RCMobClick event:eventId];
    }
}


// 记录某个页面访问的开始， 建议在ViewController的viewDidAppear函数中调用
-(void)pageviewStartWithName:(NSString *)name{
    if (name) {
        [RCMobClick event:[name stringByAppendingString:@"_page_start"]];
        [TalkingData trackPageBegin:name];
    }
}

// 记录某个页面访问的结束， 建议在ViewController的viewDidDisappear函数中调用
- (void)pageviewEndWithName:(NSString *)name {
    if (name) {
        [RCMobClick event:[name stringByAppendingString:@"_page_end"]];
        [TalkingData trackPageEnd:name];
    }
}

@end
