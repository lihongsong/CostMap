#import "YosKeepAccountsBillTool.h"
@implementation YosKeepAccountsBillTool
+ (UIColor *)colorWithType:(YosKeepAccountsBillType)billType {
    switch (billType) {
        case YosKeepAccountsBillTypeFood:
            return HJHexColor(0xc07fd6);
            break;
        case YosKeepAccountsBillTypeBuy:
            return HJHexColor(0x48c1e3);
            break;
        case YosKeepAccountsBillTypeFriend:
            return HJHexColor(0xf7756d);
            break;
        case YosKeepAccountsBillTypeHome:
            return HJHexColor(0x7da0eb);
            break;
        case YosKeepAccountsBillTypeEduca:
            return HJHexColor(0xf76d9c);
            break;
        case YosKeepAccountsBillTypeMedic:
            return HJHexColor(0x7672d3);
            break;
        case YosKeepAccountsBillTypePlay:
            return HJHexColor(0x78cd65);
            break;
        default:
            return HJHexColor(0xf18b58);
            break;
    }
}
+ (NSString *)typeNameWithIndex:(YosKeepAccountsBillType)index {
    switch (index) {
        case 0: return  YosKeepAccountsBillTypeFoodName;
        case 1: return  YosKeepAccountsBillTypeBuyName;
        case 2: return  YosKeepAccountsBillTypeFriendName;
        case 3: return  YosKeepAccountsBillTypePlayName;
        case 4: return  YosKeepAccountsBillTypeHomeName;
        case 5: return  YosKeepAccountsBillTypeEducaName;
        case 6: return  YosKeepAccountsBillTypeMedicName;
        default: return YosKeepAccountsBillTypeOtherName;
    }
}
+ (NSArray *)allBillTypesName {
    return @[YosKeepAccountsBillTypeFoodName,
             YosKeepAccountsBillTypeBuyName,
             YosKeepAccountsBillTypeFriendName,
             YosKeepAccountsBillTypePlayName,
             YosKeepAccountsBillTypeHomeName,
             YosKeepAccountsBillTypeEducaName,
             YosKeepAccountsBillTypeMedicName,
             YosKeepAccountsBillTypeOtherName
             ];
}
+ (NSArray *)allBillTypesColor {
    return @[[self colorWithType:YosKeepAccountsBillTypeFood],
             [self colorWithType:YosKeepAccountsBillTypeBuy],
             [self colorWithType:YosKeepAccountsBillTypeFriend],
             [self colorWithType:YosKeepAccountsBillTypePlay],
             [self colorWithType:YosKeepAccountsBillTypeHome],
             [self colorWithType:YosKeepAccountsBillTypeEduca],
             [self colorWithType:YosKeepAccountsBillTypeMedic],
             [self colorWithType:YosKeepAccountsBillTypeOther]
             ];
}
+ (NSArray *)allBillTypes {
    return @[@(YosKeepAccountsBillTypeFood),
             @(YosKeepAccountsBillTypeBuy),
             @(YosKeepAccountsBillTypeFriend),
             @(YosKeepAccountsBillTypePlay),
             @(YosKeepAccountsBillTypeHome),
             @(YosKeepAccountsBillTypeEduca),
             @(YosKeepAccountsBillTypeMedic),
             @(YosKeepAccountsBillTypeOther)
             ];
}
+ (YosKeepAccountsBillType)typeWithTypeName:(NSString *)typeName {
    if ([typeName isEqualToString:YosKeepAccountsBillTypeFoodName]) {
        return YosKeepAccountsBillTypeFood;
    } else if ([typeName isEqualToString:YosKeepAccountsBillTypeBuyName]) {
        return YosKeepAccountsBillTypeBuy;
    } else if ([typeName isEqualToString:YosKeepAccountsBillTypeFriendName]) {
        return YosKeepAccountsBillTypeFriend;
    } else if ([typeName isEqualToString:YosKeepAccountsBillTypePlayName]) {
        return YosKeepAccountsBillTypePlay;
    } else if ([typeName isEqualToString:YosKeepAccountsBillTypeHomeName]) {
        return YosKeepAccountsBillTypeHome;
    } else if ([typeName isEqualToString:YosKeepAccountsBillTypeEducaName]) {
        return YosKeepAccountsBillTypeEduca;
    } else if ([typeName isEqualToString:YosKeepAccountsBillTypeMedicName]) {
        return YosKeepAccountsBillTypeMedic;
    } else {
        return YosKeepAccountsBillTypeOther;
    };
}
+ (NSString *)typeImage:(YosKeepAccountsBillType)type {
    switch (type) {
        case YosKeepAccountsBillTypeFood: return @"restaurant_ic";
        case YosKeepAccountsBillTypeBuy: return @"shop_ic";
        case YosKeepAccountsBillTypeFriend: return @"friend_ic";
        case YosKeepAccountsBillTypePlay: return @"play_ic";
        case YosKeepAccountsBillTypeHome: return @"home_ic";
        case YosKeepAccountsBillTypeEduca: return @"education_ic";
        case YosKeepAccountsBillTypeMedic: return @"medical_ic";
        default: return @"more_ic";
    }
}
+ (NSString *)typePressedImage:(YosKeepAccountsBillType)type {
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
