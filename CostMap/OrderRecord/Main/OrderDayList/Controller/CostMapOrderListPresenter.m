#import "CostMapOrderListPresenter.h"
#import "CostMapOrderList.h"
#import "CostMapChartPieScene.h"
#import "CostMapDaySelectedScene.h"
#import "CostMapCustomDatePickerScene.h"
#import "CostMapOrderEntity+CostMapService.h"
@interface CostMapOrderListPresenter ()<HJMediatorTargetInstance, CostMapDaySelectedSceneDelegate>
@property (weak, nonatomic) IBOutlet CostMapOrderList *tableScene;
@property (weak, nonatomic) IBOutlet CostMapChartPieScene *pieScene;
@property (strong, nonatomic) CostMapDaySelectedScene *daySelectScene;
@end
@implementation CostMapOrderListPresenter
+ (id)targetInstance {
    return [CostMapOrderListPresenter instance];
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

- (CostMapDaySelectedScene *)daySelectScene {
    if (!_daySelectScene) {
        _daySelectScene = [CostMapDaySelectedScene instance];
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
    self.tableScene.tableType = CostMapOrderTableTypeDay;
    WEAK_SELF
    self.tableScene.deleteAction = ^(UITableViewCellEditingStyle editingStyle, CostMapOrderEntity * _Nonnull model) {
        STRONG_SELF
        [[CostMapSQLManager share] deleteData:kSQLTableName yka_id:model.yka_id];
        NSMutableArray *tempArray = [self.tableScene.entitys mutableCopy];
        [tempArray removeObject:model];
        self.tableScene.entitys = tempArray;
        [self.tableScene reloadData];
        NSArray *pieData = [CostMapOrderEntity templateOrderArrayWithOrders:tempArray];
        self.pieScene.entitys = pieData;
    };
    self.tableScene.selectAction = ^(CostMapOrderEntity * _Nonnull model) {
        [[HJMediator shared] routeToURL:HJAPPURL(@"EditOrder") withParameters:@{@"orderEntity": model}, nil];
    };
    [[self navigationItem] setTitleView:self.daySelectScene];
}
- (void)requestData {
    NSString *year = @([self.daySelectScene.currentDate hj_year]).stringValue;
    NSString *month = @([self.daySelectScene.currentDate hj_month]).stringValue;
    NSString *day = @([self.daySelectScene.currentDate hj_day]).stringValue;
    WEAK_SELF
    [[CostMapSQLManager share] searchData:kSQLTableName
                                  year:year
                                 month:month
                                   day:day
                                result:^(NSMutableArray<CostMapOrderEntity *> *result, NSError *error) {
                                    STRONG_SELF
                                    NSArray *pieData = [CostMapOrderEntity templateOrderArrayWithOrders:result];
                                    self.pieScene.entitys = pieData;
                                    self.tableScene.entitys = result;
                                    [self.tableScene cyl_reloadData];
                                }];
}

- (void)selectedScene:(CostMapDaySelectedScene *)selectScene didClickDate:(NSDate *)date {
    WEAK_SELF
    [CostMapCustomDatePickerScene showDatePickerWithTitle:@"Choose Time"
                                           dateType:CostMapCustomDatePickerModeYMD
                                    defaultSelValue:[self dateString]
                                            minDate:nil
                                            maxDate:nil
                                       isAutoSelect:NO
                                         themeColor:CostMapThemeColor
                                        resultBlock:^(NSString *selectValue) {
                                            STRONG_SELF
                                            NSDate *date = [NSDate hj_dateWithString:selectValue format:@"yyyy-MM-dd"];
                                            [self.daySelectScene refreshDate:date];
                                            [self requestData];
                                        }];
}
- (void)selectedScene:(CostMapDaySelectedScene *)selectScene didChangeDate:(NSDate *)date {
    [self requestData];
}
@end
