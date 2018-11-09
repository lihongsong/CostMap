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
            return HJHexColor(0xf7756d);
            break;
            
        default:
            return HJHexColor(0xf18b58);
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
