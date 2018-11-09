//
//  WYHQDaySelectedView.m
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/8.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "WYHQDaySelectedView.h"

#define kDaySelectFormat @"yyyy年MM月dd日"

@interface WYHQDaySelectedView ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic, readwrite) NSDate *currentDate;

@end

@implementation WYHQDaySelectedView

#pragma mark - Life Cycle

+ (instancetype)instance {
    return (WYHQDaySelectedView *)[[[NSBundle mainBundle] loadNibNamed:@"WYHQDaySelectedView"
                                                                 owner:nil
                                                               options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
}



#pragma mark - Getter & Setter Methods

- (void)setCurrentDate:(NSDate *)currentDate {
    _currentDate = currentDate;
    _dateLabel.text = [currentDate hj_stringWithFormat:kDaySelectFormat];
}

#pragma mark - Public Method

- (void)refreshDate:(NSDate *)date {
    [self setCurrentDate:date];
}


#pragma mark - Private Method

- (void)setUpUI {
    
    NSDate *today = [NSDate date];
    [self setCurrentDate:today];
}


#pragma mark - Notification Method



#pragma mark - Event & Target Methods

- (IBAction)leftBtnClick:(UIButton *)sender {
    
    NSDate *date = [_currentDate hj_dateAfterDay:-1];
    [self setCurrentDate:date];
    
    if ([self.delegate respondsToSelector:@selector(selectedView:didChangeDate:)]) {
        [self.delegate selectedView:self didChangeDate:_currentDate];
    }
}

- (IBAction)rightBtnClick:(UIButton *)sender {
    
    NSDate *date = [_currentDate hj_dateAfterDay:1];
    [self setCurrentDate:date];
    
    if ([self.delegate respondsToSelector:@selector(selectedView:didChangeDate:)]) {
        [self.delegate selectedView:self didChangeDate:_currentDate];
    }
}

- (IBAction)titleBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectedView:didClickDate:)]) {
        [self.delegate selectedView:self didClickDate:_currentDate];
    }
}

@end
