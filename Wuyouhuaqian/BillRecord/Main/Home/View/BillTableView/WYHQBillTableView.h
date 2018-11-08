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

@interface WYHQBillTableView : UITableView

@property (strong, nonatomic) NSArray <WYHQBillModel *> *models;

@end

NS_ASSUME_NONNULL_END
