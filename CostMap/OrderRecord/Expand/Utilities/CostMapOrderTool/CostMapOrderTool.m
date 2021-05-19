#import "CostMapOrderTool.h"
@implementation CostMapOrderTool
+ (UIColor *)colorWithType:(CostMapOrderType)orderType {
    switch (orderType) {
        case CostMapOrderTypeFood:
            return HJHexColor(0xc07fd6);
            break;
        case CostMapOrderTypeBuy:
            return HJHexColor(0x48c1e3);
            break;
        case CostMapOrderTypeFriend:
            return HJHexColor(0xf7756d);
            break;
        case CostMapOrderTypeHome:
            return HJHexColor(0x7da0eb);
            break;
        case CostMapOrderTypeEduca:
            return HJHexColor(0xf76d9c);
            break;
        case CostMapOrderTypeMedic:
            return HJHexColor(0x7672d3);
            break;
        case CostMapOrderTypePlay:
            return HJHexColor(0x78cd65);
            break;
        default:
            return HJHexColor(0xf18b58);
            break;
    }
}
+ (NSString *)typeNameWithIndex:(CostMapOrderType)index {
    switch (index) {
        case 0: return  CostMapOrderTypeFoodName;
        case 1: return  CostMapOrderTypeBuyName;
        case 2: return  CostMapOrderTypeMedicName;
        case 3: return  CostMapOrderTypePlayName;
        case 4: return  CostMapOrderTypeHomeName;
        case 5: return  CostMapOrderTypeEducaName;
        case 6: return  CostMapOrderTypeFriendName;
        default: return CostMapOrderTypeOtherName;
    }
}

+ (NSArray *)allOrderTypesName {
    return @[CostMapOrderTypeFoodName,
             CostMapOrderTypeBuyName,
             CostMapOrderTypeMedicName,
             CostMapOrderTypePlayName,
             CostMapOrderTypeHomeName,
             CostMapOrderTypeEducaName,
             CostMapOrderTypeFriendName,
             CostMapOrderTypeOtherName
             ];
}

+ (NSArray *)allOrderShortTypesName {
    return @[@"repa",
             @"shop",
             @"rela",
             @"play",
             @"fami",
             @"educ",
             @"medi",
             @"othe"
             ];
}

+ (NSArray *)allOrderTypesColor {
    return @[[self colorWithType:CostMapOrderTypeFood],
             [self colorWithType:CostMapOrderTypeBuy],
             [self colorWithType:CostMapOrderTypeMedic],
             [self colorWithType:CostMapOrderTypePlay],
             [self colorWithType:CostMapOrderTypeHome],
             [self colorWithType:CostMapOrderTypeEduca],
             [self colorWithType:CostMapOrderTypeFriend],
             [self colorWithType:CostMapOrderTypeOther]
             ];
}
+ (NSArray *)allOrderTypes {
    return @[@(CostMapOrderTypeFood),
             @(CostMapOrderTypeBuy),
             @(CostMapOrderTypeMedic),
             @(CostMapOrderTypePlay),
             @(CostMapOrderTypeHome),
             @(CostMapOrderTypeEduca),
             @(CostMapOrderTypeFriend),
             @(CostMapOrderTypeOther)
             ];
}
+ (CostMapOrderType)typeWithTypeName:(NSString *)typeName {
    if ([typeName isEqualToString:CostMapOrderTypeFoodName]) {
        return CostMapOrderTypeFood;
    } else if ([typeName isEqualToString:CostMapOrderTypeBuyName]) {
        return CostMapOrderTypeBuy;
    } else if ([typeName isEqualToString:CostMapOrderTypeFriendName]) {
        return CostMapOrderTypeFriend;
    } else if ([typeName isEqualToString:CostMapOrderTypePlayName]) {
        return CostMapOrderTypePlay;
    } else if ([typeName isEqualToString:CostMapOrderTypeHomeName]) {
        return CostMapOrderTypeHome;
    } else if ([typeName isEqualToString:CostMapOrderTypeEducaName]) {
        return CostMapOrderTypeEduca;
    } else if ([typeName isEqualToString:CostMapOrderTypeMedicName]) {
        return CostMapOrderTypeMedic;
    } else {
        return CostMapOrderTypeOther;
    };
}
+ (NSString *)typeImage:(CostMapOrderType)type {
    switch (type) {
        case CostMapOrderTypeFood: return @"repast_ic";
        case CostMapOrderTypeBuy: return @"shopping_ic";
        case CostMapOrderTypePlay: return @"play_ic";
        case CostMapOrderTypeHome: return @"family_ic";
        case CostMapOrderTypeEduca: return @"education_ic";
        case CostMapOrderTypeMedic: return @"medical_ic";
        case CostMapOrderTypeFriend: return @"friendship_ic";
        default: return @"other_ic";
    }
}
+ (NSString *)typePressedImage:(CostMapOrderType)type {
    return [NSString stringWithFormat:@"%@", [self typeImage:type]];
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
