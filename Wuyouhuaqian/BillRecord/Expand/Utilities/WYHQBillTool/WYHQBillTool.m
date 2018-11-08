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


@end
