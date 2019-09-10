#import "CostMapOrderList.h"
#import "CostMapOrderEntity.h"
#import "CostMapOrderListCell.h"
#import "UNNoDataScene.h"
@interface CostMapOrderList()<UITableViewDataSource, UITableViewDelegate>
@end
@implementation CostMapOrderList
- (void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = HJHexColor(k0xf5f5f5);
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[CostMapOrderListCell cellNib] forCellReuseIdentifier:[CostMapOrderListCell cellID]];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.cyl_placeHolderScene) {
        self.cyl_placeHolderScene.frame = self.bounds;
    }
}



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
        CostMapOrderEntity *model = self.entitys[indexPath.row];
        !_deleteAction?:_deleteAction(editingStyle, model);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableScene cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CostMapOrderListCell *cell = [CostMapOrderListCell cellWithList:tableScene
                                                                 indexPath:indexPath];
    cell.tableType = _tableType;
    cell.entity = _entitys[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableScene didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.entitys.count) {
        return;
    }
    CostMapOrderEntity *model = self.entitys[indexPath.row];
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
- (UIView *)makePlaceHolderScene {
    NSString *title;
    if (_tableType == CostMapOrderTableTypeMonth || _tableType == CostMapOrderTableTypeMonth_Type) {
        title = @"You haven't made any payments this month.";
    } else {
        title = @"You haven't made any payments that day.";
    }
    return [UNNoDataScene viewAddedTo:self
                           imageName:@"order_icon_nodata"
                               title:title];
}
@end
