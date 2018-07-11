//
//  HQWYUser.m
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/10.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "HQWYUser.h"

@implementation HQWYUser

+ (NSDictionary*)modelCustomPropertyMapper {
    return @{
             @"mobilephone" : @"mobilephone",
             @"respDateTime" : @"respDateTime",
             @"token" : @"token",
             @"userId" : @"userId",
             };
}
@end
