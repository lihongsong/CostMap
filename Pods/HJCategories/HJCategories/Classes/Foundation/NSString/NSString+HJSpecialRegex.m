//
//  NSString+HJSpecialRegex.m
//  HJCategories
//
//  Created by yoser on 2018/1/9.
//

#import "NSString+HJSpecialRegex.h"

@implementation NSString (HJSpecialRegex)

- (BOOL)hj_chenkCharacterWithType:(HJCharacterSetType)type{
    NSString *typeString;
    switch (type) {
        case HJCharacterSetTypeAlphaNum_:
        {
            typeString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_";
        }
            break;
        case HJCharacterSetTypeAlphaNum:
        {
            typeString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        }
            break;
        case HJCharacterSetTypeAlpha:
        {
            typeString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        }
            break;
        case HJCharacterSetTypeNumPeriod:
        {
            typeString = @"0123456789.";
        }
            break;
        case HJCharacterSetTypeNumHeng:
        {
            typeString = @"0123456789-";
        }
            break;
        case HJCharacterSetTypeNumxX:
        {
            typeString = @"0123456789xX";
        }
            break;
        case HJCharacterSetTypeNum:
        {
            typeString = @"0123456789";
        }
            break;
            
        default:
            break;
    }
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:typeString] invertedSet];
    NSString *filtered =
    [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basic = [self isEqualToString:filtered];
    return basic;
}

@end
