//
//  WYHQBillTableViewCell.h
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/8.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WYHQBillTableType) {
    WYHQBillTableTypeHome = 0,
    WYHQBillTableTypeDay = 1,
};

NS_ASSUME_NONNULL_BEGIN

@class WYHQBillModel;

@interface WYHQBillTableViewCell : UITableViewCell

@property (strong, nonatomic) WYHQBillModel *model;

@property (assign, nonatomic) WYHQBillTableType tableType;

+ (NSString *)cellID;

+ (UINib *)cellNib;

+ (WYHQBillTableViewCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
