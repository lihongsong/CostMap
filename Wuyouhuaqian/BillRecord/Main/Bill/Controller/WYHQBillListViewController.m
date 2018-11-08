//
//  WYHQBillListViewController.m
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/7.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "WYHQBillListViewController.h"
#import "WYHQBillTableView.h"
#import "WYHQChartPieView.h"
#import "WYHQDaySelectedView.h"
#import "CLCustomDatePickerView.h"

@interface WYHQBillListViewController ()<HJMediatorTargetInstance, WYHQDaySelectedViewDelegate>

@property (weak, nonatomic) IBOutlet WYHQBillTableView *tableView;

@property (weak, nonatomic) IBOutlet WYHQChartPieView *pieView;

@property (strong, nonatomic) WYHQDaySelectedView *daySelectView;

@end

@implementation WYHQBillListViewController

+ (id)targetInstance {
    return [WYHQBillListViewController instance];
}

+ (instancetype)instance {
    return StoryBoardLoaderRoot(@"BillList");
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self setUpUI];
    
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Getter & Setter Methods

- (WYHQDaySelectedView *)daySelectView {
    if (!_daySelectView) {
        _daySelectView = [WYHQDaySelectedView instance];
        _daySelectView.delegate = self;
    }
    return _daySelectView;
}

#pragma mark - Network Method



#pragma mark - Public Method



#pragma mark - Private Method

- (NSString *)dateString {
    return [_daySelectView.currentDate hj_stringWithFormat:@"yyyy-MM-dd"];
}

- (void)setUpUI {
    
//    self.daySelectView
    [[self navigationItem] setTitleView:self.daySelectView];
}

- (void)requestData {
    
    [KeyWindow hj_showLoadingHUD];
    
    WYHQBillModel *model = [WYHQBillModel new];
    model.s_type_id = @(WYHQBillTypeFood).stringValue;
    model.s_money = @"-9000";
    model.s_type_name = @"衣服";
    
    WYHQBillModel *model1 = [WYHQBillModel new];
    model1.s_type_id = @(WYHQBillTypeCloth).stringValue;
    model1.s_money = @"-300";
    model1.s_type_name = @"衣服";
    
    WYHQBillModel *model2 = [WYHQBillModel new];
    model2.s_type_id = @(WYHQBillTypeVehicles).stringValue;
    model2.s_money = @"-700";
    model2.s_type_name = @"衣服";
    
    WYHQBillModel *model3 = [WYHQBillModel new];
    model3.s_type_id = @(WYHQBillTypeHome).stringValue;
    model3.s_money = @"-20";
    model3.s_type_name = @"衣服";
    
    WYHQBillModel *model4 = [WYHQBillModel new];
    model4.s_type_id = @(WYHQBillTypeFood).stringValue;
    model4.s_money = @"-11100";
    model4.s_type_name = @"衣服";
    
    WYHQBillModel *model5 = [WYHQBillModel new];
    model5.s_type_id = @(WYHQBillTypeFood).stringValue;
    model5.s_money = @"-11100";
    model5.s_type_name = @"衣服";
    
    WYHQBillModel *model6 = [WYHQBillModel new];
    model6.s_type_id = @(WYHQBillTypeFood).stringValue;
    model6.s_money = @"-11100";
    model6.s_type_name = @"衣服";
    
    WYHQBillModel *model7 = [WYHQBillModel new];
    model7.s_type_id = @(WYHQBillTypeFood).stringValue;
    model7.s_money = @"-11100";
    model7.s_type_name = @"衣服";
    
    WEAK_SELF
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        STRONG_SELF
        [KeyWindow hj_hideProgressHUD];
        self.tableView.models = @[model, model1, model2, model3, model4, model5, model6, model7];
        [self.tableView reloadData];
    });
    
    
}

#pragma mark - Notification Method



#pragma mark - Event & Target Methods

#pragma mark - WYHQDaySelectedViewDelegate

- (void)selectedView:(WYHQDaySelectedView *)selectView didClickDate:(NSDate *)date {
    
    WEAK_SELF
    [CLCustomDatePickerView showDatePickerWithTitle:@"选择时间"
                                           dateType:CLCustomDatePickerModeYMD
                                    defaultSelValue:[self dateString]
                                        resultBlock:^(NSString *selectValue) {
                                            STRONG_SELF
                                            
                                            NSDate *date = [NSDate hj_dateWithString:selectValue format:@"yyyy-MM-dd"];
                                            [self.daySelectView refreshDate:date];
                                            [self requestData];
                                        }];
    
}

- (void)selectedView:(WYHQDaySelectedView *)selectView didChangeDate:(NSDate *)date {
    
    [self requestData];
}

@end
