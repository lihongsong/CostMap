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
#import "WYHQBillModel+WYHQService.h"

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
    
    self.pieView.holeRadiusPercent = 0.8;
    self.pieView.drawHoleEnabled = YES;
    self.tableView.enableDelete = YES;
    self.tableView.tableType = WYHQBillTableTypeDay;
    
    WEAK_SELF
    self.tableView.deleteAction = ^(UITableViewCellEditingStyle editingStyle, WYHQBillModel * _Nonnull model) {
        STRONG_SELF
        // 删除数据库
        [[WYHQSQLManager share] deleteData:kSQLTableName s_id:model.s_id];
        
        // 删除数据源
        NSMutableArray *tempArray = [self.tableView.models mutableCopy];
        [tempArray removeObject:model];
        self.tableView.models = tempArray;

        // 更新 UI
        [self.tableView reloadData];
        NSArray *pieData = [WYHQBillModel templateBillArrayWithBills:tempArray];
        self.pieView.models = pieData;
    };
    
    self.tableView.selectAction = ^(WYHQBillModel * _Nonnull model) {
        [[HJMediator shared] routeToURL:HJAPPURL(@"EditBill") withParameters:@{@"billModel": model}, nil];
    };
    
    [[self navigationItem] setTitleView:self.daySelectView];
}

- (void)requestData {
    
    [KeyWindow hj_showLoadingHUD];
    
    NSString *year = @([self.daySelectView.currentDate hj_year]).stringValue;
    NSString *month = @([self.daySelectView.currentDate hj_month]).stringValue;
    NSString *day = @([self.daySelectView.currentDate hj_day]).stringValue;
    
    WEAK_SELF
    [[WYHQSQLManager share] searchData:kSQLTableName
                                  year:year
                                 month:month
                                   day:day
                                result:^(NSMutableArray<WYHQBillModel *> *result, NSError *error) {
                                    STRONG_SELF
                                    [KeyWindow hj_hideProgressHUD];
                                    NSArray *pieData = [WYHQBillModel templateBillArrayWithBills:result];
                                    self.pieView.models = pieData;
                                    
                                    self.tableView.models = result;
                                    [self.tableView reloadData];
                                }];
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
