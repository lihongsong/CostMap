//
//  WYHQBillTableView.h
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/8.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WYHQBillModel;

typedef void (^WYHQBillDeleteAction) (UITableViewCellEditingStyle editingStyle, WYHQBillModel *model);

@interface WYHQBillTableView : UITableView

@property (assign, nonatomic) BOOL enableDelete;

@property (strong, nonatomic) NSArray <WYHQBillModel *> *models;

@property (copy, nonatomic) WYHQBillDeleteAction deleteAction;

@end

NS_ASSUME_NONNULL_END
