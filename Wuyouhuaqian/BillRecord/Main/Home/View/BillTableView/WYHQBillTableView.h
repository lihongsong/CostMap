//
//  WYHQBillTableView.h
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/8.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WYHQBillTableViewCell.h"

@class WYHQBillModel;

NS_ASSUME_NONNULL_BEGIN

typedef void (^WYHQBillDeleteAction) (UITableViewCellEditingStyle editingStyle, WYHQBillModel *model);

typedef void (^WYHQBillSelectAction) (WYHQBillModel *model);

@interface WYHQBillTableView : UITableView

@property (assign, nonatomic) WYHQBillTableType tableType;

@property (assign, nonatomic) BOOL enableDelete;

@property (strong, nonatomic) NSArray <WYHQBillModel *> *models;

@property (copy, nonatomic) WYHQBillDeleteAction deleteAction;

@property (copy, nonatomic) WYHQBillSelectAction selectAction;

@end

NS_ASSUME_NONNULL_END
