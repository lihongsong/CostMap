//
//  WYHQEditBillToolBar.h
//  Wuyouhuaqian
//
//  Created by sunhw on 2018/11/8.
//  Copyright © 2018 yoser. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WYHQEditBillToolBarSelectedTime)(NSString *timeStr);
typedef void(^WYHQEditBillToolBarSelectedClassify)(NSString *typeStr);

@interface WYHQEditBillToolBar : UIView

+ (void)showEditBillToolBarOnSuperVC:(UIViewController *)superVC
                            classify:(NSString * _Nullable)classify
                 selectedTimeHandler:(WYHQEditBillToolBarSelectedTime)selectedTimeHandler
             selectedClassifyHandler:(WYHQEditBillToolBarSelectedClassify)selectedClassifyHandler;

+ (void)hideEditBillToolBar;

@end

NS_ASSUME_NONNULL_END
