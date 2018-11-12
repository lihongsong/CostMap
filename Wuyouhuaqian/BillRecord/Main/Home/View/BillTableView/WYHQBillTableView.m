//
//  WYHQBillTableView.m
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/8.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "WYHQBillTableView.h"
#import "WYHQBillModel.h"
#import "WYHQBillTableViewCell.h"
#import "UNNoDataView.h"

@interface WYHQBillTableView()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation WYHQBillTableView

#pragma mark - Life Cycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    
    self.backgroundColor = HJHexColor(k0xf5f5f5);
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[WYHQBillTableViewCell cellNib] forCellReuseIdentifier:[WYHQBillTableViewCell cellID]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.cyl_placeHolderView) {
        self.cyl_placeHolderView.frame = self.bounds;
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.enableDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (indexPath.row >= self.models.count) {
            return;
        }
        
        WYHQBillModel *model = self.models[indexPath.row];
        !_deleteAction?:_deleteAction(editingStyle, model);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WYHQBillTableViewCell *cell = [WYHQBillTableViewCell cellWithTableView:tableView
                                                                 indexPath:indexPath];
    cell.tableType = _tableType;
    cell.model = _models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row >= self.models.count) {
        return;
    }
    
    WYHQBillModel *model = self.models[indexPath.row];
    !_selectAction?:_selectAction(model);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

#pragma mark - CYLTableViewPlaceHolderDelegate

/**
 *  无数据时的占位视图
 */
- (UIView *)makePlaceHolderView {
    
    NSString *title;
    if (_tableType == WYHQBillTableTypeMonth) {
        title = @"您本月还没有任何支出";
    } else {
        title = @"您当日还没有任何支出";
    }
    
    return [UNNoDataView viewAddedTo:self
                           imageName:@"bill_icon_nodata"
                               title:@"您本月还没有任何支出"];
}

@end
