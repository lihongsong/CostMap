#import "CostMapOrderListCell.h"
#import "CostMapOrderEntity.h"
#import "CostMapOrderTool.h"
@interface CostMapOrderListCell()
@property (weak, nonatomic) IBOutlet UILabel *wealthLb;
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
@implementation CostMapOrderListCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _wealthLb.textColor = CostMapThemeColor;
    _titleLb.textColor = CostMapThemeColor;
    _iconIV.tintColor = CostMapThemeColor;
}

- (void)setEntity:(CostMapOrderEntity *)entity {
    _entity = entity;
    _themeLineVw.backgroundColor = [CostMapOrderTool colorWithType:entity.yka_type_id.integerValue];
    _titleLb.text = entity.yka_type_name;
    _wealthLb.text = entity.yka_wealth ?: @"-0.00";
    _themeLineVw.backgroundColor = [CostMapOrderTool colorWithType:entity.yka_type_id.integerValue];
    _iconIV.image = [UIImage imageNamed:[CostMapOrderTool typePressedImage:[entity.yka_type_id integerValue]]];
    _bigTitleLb.text = entity.yka_type_name;
    _cityLb.text = entity.yka_city;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[entity.yka_time doubleValue]];
    if (_tableType == CostMapOrderTableTypeDay) {
        _dateLb.text = [NSDate hj_stringWithDate:date format:@"HH:mm"];
    } else if (_tableType == CostMapOrderTableTypeMonth_Type) {
        _dateLb.text = [NSDate hj_stringWithDate:date format:@"dd HH:mm"];
    }
}
- (void)setTableType:(CostMapOrderTableType)tableType {
    _tableType = tableType;
    self.bigTitleBaseVw.hidden = tableType != CostMapOrderTableTypeMonth;
    _arrowWidth.constant = tableType != CostMapOrderTableTypeMonth ? 6 : 0 ;
    _arrowLeading.constant = tableType != CostMapOrderTableTypeMonth ? 8 : 0 ;
    _arrowIV.hidden = tableType == CostMapOrderTableTypeMonth;
}
+ (NSString *)cellID {
    return @"CostMapOrderListCell";
}
+ (UINib *)cellNib {
    return [UINib nibWithNibName:@"CostMapOrderListCell" bundle:nil];
}
+ (CostMapOrderListCell *)cellWithList:(UITableView *)tableScene indexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [CostMapOrderListCell cellID];
    CostMapOrderListCell *cell =
    (CostMapOrderListCell *)[tableScene dequeueReusableCellWithIdentifier:cellID
                                                             forIndexPath:indexPath];
    return cell;
}

@end
