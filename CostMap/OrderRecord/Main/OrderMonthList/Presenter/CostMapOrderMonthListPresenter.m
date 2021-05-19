#import "CostMapOrderMonthListPresenter.h"
#import "CostMapOrderList.h"
#import "CostMapOrderEntity+CostMapService.h"
@interface CostMapOrderMonthListPresenter () <HJMediatorTargetInstance>
@property (weak, nonatomic) IBOutlet CostMapOrderList *tableScene;
@end
@implementation CostMapOrderMonthListPresenter
+ (id)targetInstance {
    return [CostMapOrderMonthListPresenter instance];
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
    self.tableScene.tableType = CostMapOrderTableTypeMonth_Type;
    WEAK_SELF
    self.tableScene.deleteAction = ^(UITableViewCellEditingStyle editingStyle, CostMapOrderEntity * _Nonnull model) {
        STRONG_SELF
        [[CostMapSQLManager share] deleteData:kSQLTableName yka_id:model.yka_id];
        NSMutableArray *tempArray = [self.tableScene.entitys mutableCopy];
        [tempArray removeObject:model];
        self.tableScene.entitys = tempArray;
        [self.tableScene reloadData];
    };
    self.tableScene.selectAction = ^(CostMapOrderEntity * _Nonnull model) {
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
    CostMapOrderEntity *model = [CostMapOrderEntity new];
    model.yka_year = self.year;
    model.yka_month = self.month;
    model.yka_type_id = self.order_type_id;
    NSArray *result =
    [[CostMapSQLManager share] searchData:model
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
