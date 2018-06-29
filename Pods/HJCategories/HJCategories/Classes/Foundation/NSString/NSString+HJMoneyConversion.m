//
//  NSString+HJMoneyConversion.m
//  HJCategories
//
//  Created by yoser on 2018/4/20.
//

#import "NSString+HJMoneyConversion.h"

@implementation NSString (HJMoneyConversion)

- (NSString *)hj_fen2jiao{
    return @([self floatValue] / 10.f).stringValue;
}

- (NSString *)hj_jiao2fen{
    return @([self floatValue] * 10).stringValue;
}

- (NSString *)hj_jiao2yuan{
    return @([self floatValue] / 10.f).stringValue;
}

- (NSString *)hj_fen2yuan{
    return @([self floatValue] / 100.f).stringValue;
}

- (NSString *)hj_yuan2fen{
    return @([self floatValue] * 100.f).stringValue;
}

- (NSString *)hj_yuan2jiao{
    return @([self floatValue] * 10.f).stringValue;
}

@end
