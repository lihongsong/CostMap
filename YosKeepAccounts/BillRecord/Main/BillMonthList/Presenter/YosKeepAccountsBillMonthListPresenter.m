#import "YosKeepAccountsBillMonthListPresenter.h"
#import "YosKeepAccountsBillList.h"
#import "YosKeepAccountsBillEntity+YosKeepAccountsService.h"
@interface YosKeepAccountsBillMonthListPresenter () <HJMediatorTargetInstance>
@property (weak, nonatomic) IBOutlet YosKeepAccountsBillList *tableScene;
@end
@implementation YosKeepAccountsBillMonthListPresenter
+ (id)targetInstance {
    return [YosKeepAccountsBillMonthListPresenter instance];
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
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"]
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(addBillBtnClick)];
    self.tableScene.enableDelete = YES;
    self.tableScene.tableType = YosKeepAccountsBillTableTypeMonth_Type;
    WEAK_SELF
    self.tableScene.deleteAction = ^(UITableViewCellEditingStyle editingStyle, YosKeepAccountsBillEntity * _Nonnull model) {
        STRONG_SELF
        [[YosKeepAccountsSQLManager share] deleteData:kSQLTableName s_id:model.s_id];
        NSMutableArray *tempArray = [self.tableScene.entitys mutableCopy];
        [tempArray removeObject:model];
        self.tableScene.entitys = tempArray;
        [self.tableScene reloadData];
    };
    self.tableScene.selectAction = ^(YosKeepAccountsBillEntity * _Nonnull model) {
        [[HJMediator shared] routeToURL:HJAPPURL(@"EditBill") withParameters:@{@"billEntity": model}, nil];
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
    YosKeepAccountsBillEntity *model = [YosKeepAccountsBillEntity new];
    model.s_year = self.year;
    model.s_month = self.month;
    model.s_type_id = self.bill_type_id;
    NSArray *result =
    [[YosKeepAccountsSQLManager share] searchData:model
                             tableName:kSQLTableName];
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"s_time" ascending:NO];
    result = [result sortedArrayUsingDescriptors:@[sortDes]];
    self.tableScene.entitys = result;
    [self.tableScene cyl_reloadData];
}
#pragma mark - Notification Method
#pragma mark - Event & Target Methods
- (void)addBillBtnClick {
    [[HJMediator shared] routeToURL:HJAPPURL(@"EditBill") withParameters:@{@"billTypeStr": _bill_type_id}, nil];
}
#pragma mark - YosKeepAccountsDaySelectedSceneDelegate
@end
