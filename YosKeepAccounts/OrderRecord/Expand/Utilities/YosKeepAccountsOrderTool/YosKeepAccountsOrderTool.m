#import "YosKeepAccountsOrderTool.h"
@implementation YosKeepAccountsOrderTool
+ (UIColor *)colorWithType:(YosKeepAccountsOrderType)orderType {
    switch (orderType) {
        case YosKeepAccountsOrderTypeFood:
            return HJHexColor(0xc07fd6);
            break;
        case YosKeepAccountsOrderTypeBuy:
            return HJHexColor(0x48c1e3);
            break;
        case YosKeepAccountsOrderTypeFriend:
            return HJHexColor(0xf7756d);
            break;
        case YosKeepAccountsOrderTypeHome:
            return HJHexColor(0x7da0eb);
            break;
        case YosKeepAccountsOrderTypeEduca:
            return HJHexColor(0xf76d9c);
            break;
        case YosKeepAccountsOrderTypeMedic:
            return HJHexColor(0x7672d3);
            break;
        case YosKeepAccountsOrderTypePlay:
            return HJHexColor(0x78cd65);
            break;
        default:
            return HJHexColor(0xf18b58);
            break;
    }
}
+ (NSString *)typeNameWithIndex:(YosKeepAccountsOrderType)index {
    switch (index) {
        case 0: return  YosKeepAccountsOrderTypeFoodName;
        case 1: return  YosKeepAccountsOrderTypeBuyName;
        case 2: return  YosKeepAccountsOrderTypeFriendName;
        case 3: return  YosKeepAccountsOrderTypePlayName;
        case 4: return  YosKeepAccountsOrderTypeHomeName;
        case 5: return  YosKeepAccountsOrderTypeEducaName;
        case 6: return  YosKeepAccountsOrderTypeMedicName;
        default: return YosKeepAccountsOrderTypeOtherName;
    }
}
+ (NSArray *)allOrderTypesName {
    return @[YosKeepAccountsOrderTypeFoodName,
             YosKeepAccountsOrderTypeBuyName,
             YosKeepAccountsOrderTypeFriendName,
             YosKeepAccountsOrderTypePlayName,
             YosKeepAccountsOrderTypeHomeName,
             YosKeepAccountsOrderTypeEducaName,
             YosKeepAccountsOrderTypeMedicName,
             YosKeepAccountsOrderTypeOtherName
             ];
}
+ (NSArray *)allOrderTypesColor {
    return @[[self colorWithType:YosKeepAccountsOrderTypeFood],
             [self colorWithType:YosKeepAccountsOrderTypeBuy],
             [self colorWithType:YosKeepAccountsOrderTypeFriend],
             [self colorWithType:YosKeepAccountsOrderTypePlay],
             [self colorWithType:YosKeepAccountsOrderTypeHome],
             [self colorWithType:YosKeepAccountsOrderTypeEduca],
             [self colorWithType:YosKeepAccountsOrderTypeMedic],
             [self colorWithType:YosKeepAccountsOrderTypeOther]
             ];
}
+ (NSArray *)allOrderTypes {
    return @[@(YosKeepAccountsOrderTypeFood),
             @(YosKeepAccountsOrderTypeBuy),
             @(YosKeepAccountsOrderTypeFriend),
             @(YosKeepAccountsOrderTypePlay),
             @(YosKeepAccountsOrderTypeHome),
             @(YosKeepAccountsOrderTypeEduca),
             @(YosKeepAccountsOrderTypeMedic),
             @(YosKeepAccountsOrderTypeOther)
             ];
}
+ (YosKeepAccountsOrderType)typeWithTypeName:(NSString *)typeName {
    if ([typeName isEqualToString:YosKeepAccountsOrderTypeFoodName]) {
        return YosKeepAccountsOrderTypeFood;
    } else if ([typeName isEqualToString:YosKeepAccountsOrderTypeBuyName]) {
        return YosKeepAccountsOrderTypeBuy;
    } else if ([typeName isEqualToString:YosKeepAccountsOrderTypeFriendName]) {
        return YosKeepAccountsOrderTypeFriend;
    } else if ([typeName isEqualToString:YosKeepAccountsOrderTypePlayName]) {
        return YosKeepAccountsOrderTypePlay;
    } else if ([typeName isEqualToString:YosKeepAccountsOrderTypeHomeName]) {
        return YosKeepAccountsOrderTypeHome;
    } else if ([typeName isEqualToString:YosKeepAccountsOrderTypeEducaName]) {
        return YosKeepAccountsOrderTypeEduca;
    } else if ([typeName isEqualToString:YosKeepAccountsOrderTypeMedicName]) {
        return YosKeepAccountsOrderTypeMedic;
    } else {
        return YosKeepAccountsOrderTypeOther;
    };
}
+ (NSString *)typeImage:(YosKeepAccountsOrderType)type {
    switch (type) {
        case YosKeepAccountsOrderTypeFood: return @"restaurant_ic";
        case YosKeepAccountsOrderTypeBuy: return @"shop_ic";
        case YosKeepAccountsOrderTypeFriend: return @"friend_ic";
        case YosKeepAccountsOrderTypePlay: return @"play_ic";
        case YosKeepAccountsOrderTypeHome: return @"home_ic";
        case YosKeepAccountsOrderTypeEduca: return @"education_ic";
        case YosKeepAccountsOrderTypeMedic: return @"medical_ic";
        default: return @"more_ic";
    }
}
+ (NSString *)typePressedImage:(YosKeepAccountsOrderType)type {
    return [NSString stringWithFormat:@"%@_pressed", [self typeImage:type]];
}
+ (NSDateFormatter *)orderTimeDateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    });
    return dateFormatter;
}
+ (NSString *)orderTimeStringWithOrderTime:(NSDate *)orderTime {
    return [[self orderTimeDateFormatter] stringFromDate:orderTime];
}
+ (NSDate *)orderTimeWithOrderTimeString:(NSString *)orderTime {
    return [[self orderTimeDateFormatter] dateFromString:orderTime];
}
@end
