//
//  WYHQEditBillToolBar.h
//  Wuyouhuaqian
//
//  Created by sunhw on 2018/11/8.
//  Copyright © 2018 yoser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYHQBillTool.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^WYHQEditBillToolBarSelectedTime)(NSDate * _Nullable billTime);
typedef void(^WYHQEditBillToolBarSelectedClassify)(WYHQBillType billType);

@interface WYHQEditBillToolBar : UIView

+ (void)showEditBillToolBarOnSuperVC:(UIViewController *)superVC
                            billType:(WYHQBillType)billType
                            billTime:(NSDate *)billTime
                 selectedTimeHandler:(WYHQEditBillToolBarSelectedTime)selectedTimeHandler
             selectedClassifyHandler:(WYHQEditBillToolBarSelectedClassify)selectedClassifyHandler;

+ (void)hideEditBillToolBar;

@end

NS_ASSUME_NONNULL_END
