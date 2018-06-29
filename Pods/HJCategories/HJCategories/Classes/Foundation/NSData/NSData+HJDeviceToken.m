//
//  NSData+HJDeviceToken.m
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import "NSData+HJDeviceToken.h"

@implementation NSData (HJDeviceToken)

- (NSString *)hj_deviceToken{
    NSString *tempString = [self description];
    tempString = [tempString stringByReplacingOccurrencesOfString:@"<" withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@">" withString:@""];
    tempString = [tempString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return !tempString ? @"" : [tempString mutableCopy];
}

@end
