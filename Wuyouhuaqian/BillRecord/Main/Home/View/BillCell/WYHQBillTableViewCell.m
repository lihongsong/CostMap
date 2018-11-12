//
//  WYHQBillTableViewCell.m
//  Wuyouhuaqian
//
//  Created by yoser on 2018/11/8.
//  Copyright © 2018年 yoser. All rights reserved.
//

#import "WYHQBillTableViewCell.h"
#import "WYHQBillModel.h"
#import "WYHQBillTool.h"

@interface WYHQBillTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *moneyLb;

@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@property (weak, nonatomic) IBOutlet UIView *themeLineVw;

@property (weak, nonatomic) IBOutlet UIImageView *iconIV;

@property (weak, nonatomic) IBOutlet UIView *bigTitleBaseVw;

@property (weak, nonatomic) IBOutlet UILabel *bigTitleLb;

@property (weak, nonatomic) IBOutlet UILabel *cityLb;

@property (weak, nonatomic) IBOutlet UILabel *dateLb;
    
@property (weak, nonatomic) IBOutlet UIImageView *arrowIV;
    
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *arrowLeading;
    
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *arrowWidth;
    
@end

@implementation WYHQBillTableViewCell

#pragma mark - Life Cycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Getter & Setter Methods

- (void)setModel:(WYHQBillModel *)model {
    _model = model;
    
    _themeLineVw.backgroundColor = [WYHQBillTool colorWithType:model.s_type_id.integerValue];
    
    _titleLb.text = model.s_type_name;
    _moneyLb.text = model.s_money ?: @"-0.00";
    _themeLineVw.backgroundColor = [WYHQBillTool colorWithType:model.s_type_id.integerValue];
    _iconIV.image = [UIImage imageNamed:[WYHQBillTool typePressedImage:[model.s_type_id integerValue]]];
    _bigTitleLb.text = model.s_type_name;
    _cityLb.text = model.s_city;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.s_time doubleValue]];
    _dateLb.text = [NSDate hj_stringWithDate:date format:@"HH:mm"];
    
    
}

- (void)setTableType:(WYHQBillTableType)tableType {
    _tableType = tableType;
    
    self.bigTitleBaseVw.hidden = tableType != WYHQBillTableTypeHome;
    
    _arrowWidth.constant = tableType != WYHQBillTableTypeHome ? 6 : 0 ;
    _arrowLeading.constant = tableType != WYHQBillTableTypeHome ? 8 : 0 ;
    _arrowIV.hidden = tableType == WYHQBillTableTypeHome;
}

#pragma mark - Public Method

+ (NSString *)cellID {
    return @"WYHQBillTableViewCell";
}

+ (UINib *)cellNib {
    return [UINib nibWithNibName:@"WYHQBillTableViewCell" bundle:nil];
}

+ (WYHQBillTableViewCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = [WYHQBillTableViewCell cellID];
    WYHQBillTableViewCell *cell =
    (WYHQBillTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID
                                                             forIndexPath:indexPath];
    return cell;
}

#pragma mark - Private Method



#pragma mark - Notification Method



#pragma mark - Event & Target Methods

@end
