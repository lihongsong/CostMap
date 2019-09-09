#import "YosKeepAccountsOrderMonthListPresenter.h"
#import "YosKeepAccountsOrderList.h"
#import "YosKeepAccountsOrderEntity+YosKeepAccountsService.h"
@interface YosKeepAccountsOrderMonthListPresenter () <HJMediatorTargetInstance>
@property (weak, nonatomic) IBOutlet YosKeepAccountsOrderList *tableScene;
@end
@implementation YosKeepAccountsOrderMonthListPresenter
+ (id)targetInstance {
    return [YosKeepAccountsOrderMonthListPresenter instance];
}
+ (instancetype)instance {
    return StoryBoardLoaderRoot(@"OrderMonthList");
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

- (void)setUpUI {
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(addOrderBtnClick)];
    self.tableScene.enableDelete = YES;
    self.tableScene.tableType = YosKeepAccountsOrderTableTypeMonth_Type;
    WEAK_SELF
    self.tableScene.deleteAction = ^(UITableViewCellEditingStyle editingStyle, YosKeepAccountsOrderEntity * _Nonnull model) {
        STRONG_SELF
        [[YosKeepAccountsSQLManager share] deleteData:kSQLTableName yka_id:model.yka_id];
        NSMutableArray *tempArray = [self.tableScene.entitys mutableCopy];
        [tempArray removeObject:model];
        self.tableScene.entitys = tempArray;
        [self.tableScene reloadData];
    };
    self.tableScene.selectAction = ^(YosKeepAccountsOrderEntity * _Nonnull model) {
        [[HJMediator shared] routeToURL:HJAPPURL(@"EditOrder") withParameters:@{@"orderEntity": model}, nil];
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
    YosKeepAccountsOrderEntity *model = [YosKeepAccountsOrderEntity new];
    model.yka_year = self.year;
    model.yka_month = self.month;
    model.yka_type_id = self.order_type_id;
    NSArray *result =
    [[YosKeepAccountsSQLManager share] searchData:model
                             tableName:kSQLTableName];
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"yka_time" ascending:NO];
    result = [result sortedArrayUsingDescriptors:@[sortDes]];
    self.tableScene.entitys = result;
    [self.tableScene cyl_reloadData];
}

- (void)addOrderBtnClick {
    [[HJMediator shared] routeToURL:HJAPPURL(@"EditOrder") withParameters:@{@"orderTypeStr": _order_type_id}, nil];
}
@end
