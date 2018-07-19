//
//  NSObject+LNJiekuanFailed.m
//  Loan
//
//  Created by terrywang on 2017/9/22.
//  Copyright © 2017年 2345. All rights reserved.
//

#import "NSObject+LNHQWYFailed.h"
#import "HJAlertView.h"

@implementation NSObject (LNHQWYFailed)

- (void)ln_showHQWYFailedAlert:(NSDictionary *)dict {
    if (!dict ||
        ![dict isKindOfClass:[NSDictionary class]] ||
        !dict[@"message"]) {
        return;
    }
    NSDictionary *message = dict[@"message"];
    if (!message
        || [message isKindOfClass:[NSNull class]]
        || ![message isKindOfClass:[NSDictionary class]]) {
        return;
    }
    HJAlertView *alert = [[HJAlertView alloc] initWithTitle:nil message:message[@"content"] confirmButtonTitle:@"确定" confirmBlock:^{

    }];
    [alert show];
}

@end
