//
//  WYHQEditViewController.h
//  Wuyouhuaqian
//
//  Created by sunhw on 2018/11/8.
//  Copyright © 2018 yoser. All rights reserved.
//

#import "WYHQBaseViewController.h"
#import "WYHQBillModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYHQEditBillViewController : WYHQBaseViewController<HJMediatorTargetInstance>

@property (nonatomic, strong, nullable) WYHQBillModel *billModel;

/** 账单类型 */
@property (nonatomic, copy) NSString *billTypeStr;

@end

NS_ASSUME_NONNULL_END
