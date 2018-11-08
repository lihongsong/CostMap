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
        case WYHQBillTypeCloth:
            return [UIColor orangeColor];
            break;
        case WYHQBillTypeFood:
            return [UIColor redColor];
            break;
        case WYHQBillTypeHome:
            return [UIColor yellowColor];
            break;
        case WYHQBillTypeVehicles:
            return [UIColor purpleColor];
            break;
        case WYHQBillTypeBuy:
            return [UIColor grayColor];
            break;
        case WYHQBillTypeG:
            return [UIColor blueColor];
            break;
            
        default:
            return [UIColor orangeColor];
            break;
    }
}



+ (NSString *)classifyWithIndex:(WYHQBillType)index {
    
    switch (index) {
        case 0: return  @"餐饮";
        case 1: return  @"购物";
        case 2: return  @"交友";
        case 3: return  @"游玩";
        case 4: return  @"居家";
        case 5: return  @"教育";
        case 6: return  @"医疗";
        default: return @"其他";
    }
}

+ (NSInteger)indexWithClassify:(NSString *)classify {
    
    if ([classify isEqualToString:@"餐饮"]) {
        return 0;
    } else if ([classify isEqualToString:@"购物"]) {
        return 1;
    } else if ([classify isEqualToString:@"交友"]) {
        return 2;
    } else if ([classify isEqualToString:@"游玩"]) {
        return 3;
    } else if ([classify isEqualToString:@"居家"]) {
        return 4;
    } else if ([classify isEqualToString:@"教育"]) {
        return 5;
    } else if ([classify isEqualToString:@"医疗"]) {
        return 6;
    } else {
        //其他
        return 7;
    };
}

+ (NSString *)getTypeImage:(NSString *)type {
    if ([type isEqualToString:@"餐饮"]) {
        return @"restaurant_ic";
    } else if ([type isEqualToString:@"购物"]) {
        return @"shop_ic";
    } else if ([type isEqualToString:@"交友"]) {
        return @"friend_ic";
    } else if ([type isEqualToString:@"游玩"]) {
        return @"play_ic";
    } else if ([type isEqualToString:@"居家"]) {
        return @"home_ic";
    } else if ([type isEqualToString:@"教育"]) {
        return @"education_ic";
    } else if ([type isEqualToString:@"医疗"]) {
        return @"medical_ic";
    } else {//其他
        return @"more_ic";
    };
}

+ (NSString *)getTypePressedImage:(NSString *)type {
    return [NSString stringWithFormat:@"%@_pressed", [self getTypeImage:type]];
}


@end
