#import "YosKeepAccountsBillList.h"
#import "YosKeepAccountsBillEntity.h"
#import "YosKeepAccountsBillListCell.h"
#import "UNNoDataScene.h"
@interface YosKeepAccountsBillList()<UITableViewDataSource, UITableViewDelegate>
@end
@implementation YosKeepAccountsBillList
#pragma mark - Life Cycle
- (void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = HJHexColor(k0xf5f5f5);
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[YosKeepAccountsBillListCell cellNib] forCellReuseIdentifier:[YosKeepAccountsBillListCell cellID]];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.cyl_placeHolderScene) {
        self.cyl_placeHolderScene.frame = self.bounds;
    }
}
#pragma mark - Getter & Setter Methods
#pragma mark - Public Method
#pragma mark - Private Method
#pragma mark - Notification Method
#pragma mark - Event & Target Methods
#pragma mark - UITableViewDataSource & UITableViewDelegate
- (CGFloat)sectionHeaderHeight {
    return 5.0f;
}
- (UIView *)tableView:(UITableView *)tableScene viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
- (UITableViewCellEditingStyle)tableScene:(UITableView *)tableScene editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (BOOL)tableView:(UITableView *)tableScene canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.enableDelete;
}
- (void)tableView:(UITableView *)tableScene commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.row >= self.entitys.count) {
            return;
        }
        YosKeepAccountsBillEntity *model = self.entitys[indexPath.row];
        !_deleteAction?:_deleteAction(editingStyle, model);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableScene cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YosKeepAccountsBillListCell *cell = [YosKeepAccountsBillListCell cellWithList:tableScene
                                                                 indexPath:indexPath];
    cell.tableType = _tableType;
    cell.entity = _entitys[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableScene didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.entitys.count) {
        return;
    }
    YosKeepAccountsBillEntity *model = self.entitys[indexPath.row];
    !_selectAction?:_selectAction(model);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableScene {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableScene numberOfRowsInSection:(NSInteger)section {
    return _entitys.count;
}
- (CGFloat)tableView:(UITableView *)tableScene heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}
#pragma mark - YosKeepAccountsListPlaceHolderDelegate
- (UIView *)makePlaceHolderScene {
    NSString *title;
    if (_tableType == YosKeepAccountsBillTableTypeMonth || _tableType == YosKeepAccountsBillTableTypeMonth_Type) {
        title = @"您本月还没有任何支出";
    } else {
        title = @"您当日还没有任何支出";
    }
    return [UNNoDataScene viewAddedTo:self
                           imageName:@"bill_icon_nodata"
                               title:title];
}
@end
