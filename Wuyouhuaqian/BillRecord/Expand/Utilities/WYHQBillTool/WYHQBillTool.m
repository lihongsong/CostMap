//
//  WYHQBillTheme.m
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/8.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "WYHQBillTool.h"

@implementation WYHQBillTool

+ (UIColor *)colorWithType:(WYHQBillType)billType {
    
    switch (billType) {
        case WYHQBillTypeFood:
            return [UIColor orangeColor];
            break;
        case WYHQBillTypeBuy:
            return [UIColor redColor];
            break;
        case WYHQBillTypeFriend:
            return [UIColor yellowColor];
            break;
        case WYHQBillTypeHome:
            return [UIColor purpleColor];
            break;
        case WYHQBillTypeEduca:
            return [UIColor grayColor];
            break;
        case WYHQBillTypeMedic:
            return [UIColor blueColor];
            break;
            
        default:
            return [UIColor orangeColor];
            break;
    }
}



+ (NSString *)typeNameWithIndex:(WYHQBillType)index {
    
    switch (index) {
        case 0: return  WYHQBillTypeFoodName;
        case 1: return  WYHQBillTypeBuyName;
        case 2: return  WYHQBillTypeFriendName;
        case 3: return  WYHQBillTypePlayName;
        case 4: return  WYHQBillTypeHomeName;
        case 5: return  WYHQBillTypeEducaName;
        case 6: return  WYHQBillTypeMedicName;
        default: return WYHQBillTypeOtherName;
    }
}

+ (NSArray *)allBillTypesName {
    
    return @[WYHQBillTypeFoodName,
             WYHQBillTypeBuyName,
             WYHQBillTypeFriendName,
             WYHQBillTypePlayName,
             WYHQBillTypeHomeName,
             WYHQBillTypeEducaName,
             WYHQBillTypeMedicName,
             WYHQBillTypeOtherName
             ];
}

+ (NSArray *)allBillTypes {
    
    return @[@(WYHQBillTypeFood),
             @(WYHQBillTypeBuy),
             @(WYHQBillTypeFriend),
             @(WYHQBillTypePlay),
             @(WYHQBillTypeHome),
             @(WYHQBillTypeEduca),
             @(WYHQBillTypeMedic),
             @(WYHQBillTypeOther)
             ];
}

+ (WYHQBillType)typeWithTypeName:(NSString *)typeName {
    
    if ([typeName isEqualToString:WYHQBillTypeFoodName]) {
        return WYHQBillTypeFood;
    } else if ([typeName isEqualToString:WYHQBillTypeBuyName]) {
        return WYHQBillTypeBuy;
    } else if ([typeName isEqualToString:WYHQBillTypeFriendName]) {
        return WYHQBillTypeFriend;
    } else if ([typeName isEqualToString:WYHQBillTypePlayName]) {
        return WYHQBillTypePlay;
    } else if ([typeName isEqualToString:WYHQBillTypeHomeName]) {
        return WYHQBillTypeHome;
    } else if ([typeName isEqualToString:WYHQBillTypeEducaName]) {
        return WYHQBillTypeEduca;
    } else if ([typeName isEqualToString:WYHQBillTypeMedicName]) {
        return WYHQBillTypeMedic;
    } else {
        //其他
        return WYHQBillTypeOther;
    };
}

+ (NSString *)typeImage:(WYHQBillType)type {
    
    switch (type) {
        case WYHQBillTypeFood: return @"restaurant_ic";
        case WYHQBillTypeBuy: return @"shop_ic";
        case WYHQBillTypeFriend: return @"friend_ic";
        case WYHQBillTypePlay: return @"play_ic";
        case WYHQBillTypeHome: return @"home_ic";
        case WYHQBillTypeEduca: return @"education_ic";
        case WYHQBillTypeMedic: return @"medical_ic";
        default: return @"more_ic";
    }
}

+ (NSString *)typePressedImage:(WYHQBillType)type {
    return [NSString stringWithFormat:@"%@_pressed", [self typeImage:type]];
}

+ (NSDateFormatter *)billTimeDateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    });
    return dateFormatter;
}

+ (NSString *)billTimeStringWithBillTime:(NSDate *)billTime {
    return [[self billTimeDateFormatter] stringFromDate:billTime];
}

+ (NSDate *)billTimeWithBillTimeString:(NSString *)billTime {
    return [[self billTimeDateFormatter] dateFromString:billTime];
}

@end
