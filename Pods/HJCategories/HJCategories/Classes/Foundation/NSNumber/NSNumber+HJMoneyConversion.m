//
//  NSNumber+HJMoneyConversion.m
//  HJCategories
//
//  Created by yoser on 2018/4/20.
//

#import "NSNumber+HJMoneyConversion.h"

@implementation NSNumber (HJMoneyConversion)

- (NSNumber *)hj_fen2jiao{
    return @([self floatValue] / 10.f);
}

- (NSNumber *)hj_jiao2fen{
    return @([self floatValue] * 10);
}

- (NSNumber *)hj_jiao2yuan{
    return @([self floatValue] / 10.f);
}

- (NSNumber *)hj_fen2yuan{
    return @([self floatValue] / 100.f);
}

- (NSNumber *)hj_yuan2fen{
    return @([self floatValue] * 100.f);
}

- (NSNumber *)hj_yuan2jiao{
    return @([self floatValue] * 10.f);
}

@end
