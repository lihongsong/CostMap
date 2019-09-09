#import "YosKeepAccountsOrderListCell.h"
#import "YosKeepAccountsOrderEntity.h"
#import "YosKeepAccountsOrderTool.h"
@interface YosKeepAccountsOrderListCell()
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
@implementation YosKeepAccountsOrderListCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _wealthLb.textColor = YosKeepAccountsThemeColor;
    _titleLb.textColor = YosKeepAccountsThemeColor;
    _iconIV.tintColor = YosKeepAccountsThemeColor;
}

- (void)setEntity:(YosKeepAccountsOrderEntity *)entity {
    _entity = entity;
    _themeLineVw.backgroundColor = [YosKeepAccountsOrderTool colorWithType:entity.yka_type_id.integerValue];
    _titleLb.text = entity.yka_type_name;
    _wealthLb.text = entity.yka_wealth ?: @"-0.00";
    _themeLineVw.backgroundColor = [YosKeepAccountsOrderTool colorWithType:entity.yka_type_id.integerValue];
    _iconIV.image = [UIImage imageNamed:[YosKeepAccountsOrderTool typePressedImage:[entity.yka_type_id integerValue]]];
    _bigTitleLb.text = entity.yka_type_name;
    _cityLb.text = entity.yka_city;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[entity.yka_time doubleValue]];
    if (_tableType == YosKeepAccountsOrderTableTypeDay) {
        _dateLb.text = [NSDate hj_stringWithDate:date format:@"HH:mm"];
    } else if (_tableType == YosKeepAccountsOrderTableTypeMonth_Type) {
        _dateLb.text = [NSDate hj_stringWithDate:date format:@"dd HH:mm"];
    }
}
- (void)setTableType:(YosKeepAccountsOrderTableType)tableType {
    _tableType = tableType;
    self.bigTitleBaseVw.hidden = tableType != YosKeepAccountsOrderTableTypeMonth;
    _arrowWidth.constant = tableType != YosKeepAccountsOrderTableTypeMonth ? 6 : 0 ;
    _arrowLeading.constant = tableType != YosKeepAccountsOrderTableTypeMonth ? 8 : 0 ;
    _arrowIV.hidden = tableType == YosKeepAccountsOrderTableTypeMonth;
}
+ (NSString *)cellID {
    return @"YosKeepAccountsOrderListCell";
}
+ (UINib *)cellNib {
    return [UINib nibWithNibName:@"YosKeepAccountsOrderListCell" bundle:nil];
}
+ (YosKeepAccountsOrderListCell *)cellWithList:(UITableView *)tableScene indexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [YosKeepAccountsOrderListCell cellID];
    YosKeepAccountsOrderListCell *cell =
    (YosKeepAccountsOrderListCell *)[tableScene dequeueReusableCellWithIdentifier:cellID
                                                             forIndexPath:indexPath];
    return cell;
}

@end
