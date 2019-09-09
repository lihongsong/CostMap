#import "YosKeepAccountsOrderListPresenter.h"
#import "YosKeepAccountsOrderList.h"
#import "YosKeepAccountsChartPieScene.h"
#import "YosKeepAccountsDaySelectedScene.h"
#import "YosKeepAccountsCustomDatePickerScene.h"
#import "YosKeepAccountsOrderEntity+YosKeepAccountsService.h"
@interface YosKeepAccountsOrderListPresenter ()<HJMediatorTargetInstance, YosKeepAccountsDaySelectedSceneDelegate>
@property (weak, nonatomic) IBOutlet YosKeepAccountsOrderList *tableScene;
@property (weak, nonatomic) IBOutlet YosKeepAccountsChartPieScene *pieScene;
@property (strong, nonatomic) YosKeepAccountsDaySelectedScene *daySelectScene;
@end
@implementation YosKeepAccountsOrderListPresenter
+ (id)targetInstance {
    return [YosKeepAccountsOrderListPresenter instance];
}
+ (instancetype)instance {
    return StoryBoardLoaderRoot(@"OrderList");
}
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

- (YosKeepAccountsDaySelectedScene *)daySelectScene {
    if (!_daySelectScene) {
        _daySelectScene = [YosKeepAccountsDaySelectedScene instance];
        _daySelectScene.delegate = self;
    }
    return _daySelectScene;
}
- (NSString *)dateString {
    return [_daySelectScene.currentDate hj_stringWithFormat:@"yyyy-MM-dd"];
}
- (void)setUpUI {
    self.pieScene.holeRadiusPercent = 0.8;
    self.pieScene.drawHoleEnabled = YES;
    self.tableScene.enableDelete = YES;
    self.tableScene.tableType = YosKeepAccountsOrderTableTypeDay;
    WEAK_SELF
    self.tableScene.deleteAction = ^(UITableViewCellEditingStyle editingStyle, YosKeepAccountsOrderEntity * _Nonnull model) {
        STRONG_SELF
        [[YosKeepAccountsSQLManager share] deleteData:kSQLTableName yka_id:model.yka_id];
        NSMutableArray *tempArray = [self.tableScene.entitys mutableCopy];
        [tempArray removeObject:model];
        self.tableScene.entitys = tempArray;
        [self.tableScene reloadData];
        NSArray *pieData = [YosKeepAccountsOrderEntity templateOrderArrayWithOrders:tempArray];
        self.pieScene.entitys = pieData;
    };
    self.tableScene.selectAction = ^(YosKeepAccountsOrderEntity * _Nonnull model) {
        [[HJMediator shared] routeToURL:HJAPPURL(@"EditOrder") withParameters:@{@"orderEntity": model}, nil];
    };
    [[self navigationItem] setTitleView:self.daySelectScene];
}
- (void)requestData {
    NSString *year = @([self.daySelectScene.currentDate hj_year]).stringValue;
    NSString *month = @([self.daySelectScene.currentDate hj_month]).stringValue;
    NSString *day = @([self.daySelectScene.currentDate hj_day]).stringValue;
    WEAK_SELF
    [[YosKeepAccountsSQLManager share] searchData:kSQLTableName
                                  year:year
                                 month:month
                                   day:day
                                result:^(NSMutableArray<YosKeepAccountsOrderEntity *> *result, NSError *error) {
                                    STRONG_SELF
                                    NSArray *pieData = [YosKeepAccountsOrderEntity templateOrderArrayWithOrders:result];
                                    self.pieScene.entitys = pieData;
                                    self.tableScene.entitys = result;
                                    [self.tableScene cyl_reloadData];
                                }];
}

- (void)selectedScene:(YosKeepAccountsDaySelectedScene *)selectScene didClickDate:(NSDate *)date {
    WEAK_SELF
    [YosKeepAccountsCustomDatePickerScene showDatePickerWithTitle:@"Choose Time"
                                           dateType:YosKeepAccountsCustomDatePickerModeYMD
                                    defaultSelValue:[self dateString]
                                            minDate:nil
                                            maxDate:nil
                                       isAutoSelect:NO
                                         themeColor:YosKeepAccountsThemeColor
                                        resultBlock:^(NSString *selectValue) {
                                            STRONG_SELF
                                            NSDate *date = [NSDate hj_dateWithString:selectValue format:@"yyyy-MM-dd"];
                                            [self.daySelectScene refreshDate:date];
                                            [self requestData];
                                        }];
}
- (void)selectedScene:(YosKeepAccountsDaySelectedScene *)selectScene didChangeDate:(NSDate *)date {
    [self requestData];
}
@end
