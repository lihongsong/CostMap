//
//  WYHQDaySelectedView.h
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/8.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WYHQDaySelectedView;

@protocol WYHQDaySelectedViewDelegate<NSObject>

- (void)selectedView:(WYHQDaySelectedView *)selectView didChangeDate:(NSDate *)date;

- (void)selectedView:(WYHQDaySelectedView *)selectView didClickDate:(NSDate *)date;

@end

@interface WYHQDaySelectedView : UIView

@property (strong, nonatomic, readonly) NSDate *currentDate;

+ (instancetype)instance;

- (void)refreshDate:(NSDate *)date;

@property (weak, nonatomic) id<WYHQDaySelectedViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
