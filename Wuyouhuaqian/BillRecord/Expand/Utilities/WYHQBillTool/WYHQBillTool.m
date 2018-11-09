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



+ (NSString *)classifyWithIndex:(WYHQBillType)index {
    
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

+ (WYHQBillType)indexWithClassify:(NSString *)classify {
    
    if ([classify isEqualToString:WYHQBillTypeFoodName]) {
        return 0;
    } else if ([classify isEqualToString:WYHQBillTypeBuyName]) {
        return 1;
    } else if ([classify isEqualToString:WYHQBillTypeFriendName]) {
        return 2;
    } else if ([classify isEqualToString:WYHQBillTypePlayName]) {
        return 3;
    } else if ([classify isEqualToString:WYHQBillTypeHomeName]) {
        return 4;
    } else if ([classify isEqualToString:WYHQBillTypeEducaName]) {
        return 5;
    } else if ([classify isEqualToString:WYHQBillTypeMedicName]) {
        return 6;
    } else {
        //其他
        return 7;
    };
}

+ (NSString *)getTypeImage:(NSString *)type {
    if ([type isEqualToString:WYHQBillTypeFoodName]) {
        return @"restaurant_ic";
    } else if ([type isEqualToString:WYHQBillTypeBuyName]) {
        return @"shop_ic";
    } else if ([type isEqualToString:WYHQBillTypeFriendName]) {
        return @"friend_ic";
    } else if ([type isEqualToString:WYHQBillTypePlayName]) {
        return @"play_ic";
    } else if ([type isEqualToString:WYHQBillTypeHomeName]) {
        return @"home_ic";
    } else if ([type isEqualToString:WYHQBillTypeEducaName]) {
        return @"education_ic";
    } else if ([type isEqualToString:WYHQBillTypeMedicName]) {
        return @"medical_ic";
    } else {//其他
        return @"more_ic";
    };
}

+ (NSString *)getTypePressedImage:(NSString *)type {
    return [NSString stringWithFormat:@"%@_pressed", [self getTypeImage:type]];
}


@end
