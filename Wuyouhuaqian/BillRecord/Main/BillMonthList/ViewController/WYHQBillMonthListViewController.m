//
//  WYHQBillMonthListViewController.m
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/12.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "WYHQBillMonthListViewController.h"

#import "WYHQBillTableView.h"

#import "WYHQBillModel+WYHQService.h"

@interface WYHQBillMonthListViewController () <HJMediatorTargetInstance>

@property (weak, nonatomic) IBOutlet WYHQBillTableView *tableView;

@end

@implementation WYHQBillMonthListViewController

+ (id)targetInstance {
    return [WYHQBillMonthListViewController instance];
}

+ (instancetype)instance {
    return StoryBoardLoaderRoot(@"BillMonthList");
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HJHexColor(k0xf5f5f5);
    
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self requestData];
}

#pragma mark - Getter & Setter Methods



#pragma mark - Network Method



#pragma mark - Public Method



#pragma mark - Private Method

- (void)setUpUI {
    
    self.tableView.enableDelete = YES;
    self.tableView.tableType = WYHQBillTableTypeMonth_Type;
    
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
    };
    
    self.tableView.selectAction = ^(WYHQBillModel * _Nonnull model) {
        [[HJMediator shared] routeToURL:HJAPPURL(@"EditBill") withParameters:@{@"billModel": model}, nil];
    };
    
    UILabel *titleLb = [UILabel new];
    titleLb.textColor = HJHexColor(k0x666666);
    titleLb.font = [UIFont boldSystemFontOfSize:18];
    titleLb.frame = CGRectMake(0, 0, 100, 40);
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.text = [NSString stringWithFormat:@"%@-%@",self.year, self.month];
    
    [[self navigationItem] setTitleView:titleLb];
}

- (void)requestData {
    
    WYHQBillModel *model = [WYHQBillModel new];
    model.s_year = self.year;
    model.s_month = self.month;
    model.s_type_id = self.bill_type_id;
    
    NSArray *result =
    [[WYHQSQLManager share] searchData:model
                             tableName:kSQLTableName];
    
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"s_time" ascending:NO];
    result = [result sortedArrayUsingDescriptors:@[sortDes]];
    
    self.tableView.models = result;
    [self.tableView cyl_reloadData];
}

#pragma mark - Notification Method



#pragma mark - Event & Target Methods


#pragma mark - WYHQDaySelectedViewDelegate

@end
