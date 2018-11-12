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
    
//    education   f76d9c
//    friend      f7756d
//    home        7da0eb
//    medical     7672d3
//    more        f18b58
//    play        f7756d
//    restaurant  c07fd6
//    shop        48c1e3
    
    switch (billType) {
        case WYHQBillTypeFood:
            return HJHexColor(0xc07fd6);
            break;
        case WYHQBillTypeBuy:
            return HJHexColor(0x48c1e3);
            break;
        case WYHQBillTypeFriend:
            return HJHexColor(0xf7756d);
            break;
        case WYHQBillTypeHome:
            return HJHexColor(0x7da0eb);
            break;
        case WYHQBillTypeEduca:
            return HJHexColor(0xf76d9c);
            break;
        case WYHQBillTypeMedic:
            return HJHexColor(0x7672d3);
            break;
        case WYHQBillTypePlay:
            return HJHexColor(0x78cd65);
            break;
            
        default:
            return HJHexColor(0xf18b58);
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

+ (NSArray *)allBillTypesColor {
    
    return @[[self colorWithType:WYHQBillTypeFood],
             [self colorWithType:WYHQBillTypeBuy],
             [self colorWithType:WYHQBillTypeFriend],
             [self colorWithType:WYHQBillTypePlay],
             [self colorWithType:WYHQBillTypeHome],
             [self colorWithType:WYHQBillTypeEduca],
             [self colorWithType:WYHQBillTypeMedic],
             [self colorWithType:WYHQBillTypeOther]
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
