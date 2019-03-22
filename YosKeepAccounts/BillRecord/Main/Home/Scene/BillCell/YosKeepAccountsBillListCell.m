#import "YosKeepAccountsBillListCell.h"
#import "YosKeepAccountsBillEntity.h"
#import "YosKeepAccountsBillTool.h"
@interface YosKeepAccountsBillListCell()
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
@implementation YosKeepAccountsBillListCell
#pragma mark - Life Cycle
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
#pragma mark - Getter & Setter Methods
- (void)setEntity:(YosKeepAccountsBillEntity *)entity {
    _entity = entity;
    _themeLineVw.backgroundColor = [YosKeepAccountsBillTool colorWithType:entity.s_type_id.integerValue];
    _titleLb.text = entity.s_type_name;
    _moneyLb.text = entity.s_money ?: @"-0.00";
    _themeLineVw.backgroundColor = [YosKeepAccountsBillTool colorWithType:entity.s_type_id.integerValue];
    _iconIV.image = [UIImage imageNamed:[YosKeepAccountsBillTool typePressedImage:[entity.s_type_id integerValue]]];
    _bigTitleLb.text = entity.s_type_name;
    _cityLb.text = entity.s_city;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[entity.s_time doubleValue]];
    if (_tableType == YosKeepAccountsBillTableTypeDay) {
        _dateLb.text = [NSDate hj_stringWithDate:date format:@"HH:mm"];
    } else if (_tableType == YosKeepAccountsBillTableTypeMonth_Type) {
        _dateLb.text = [NSDate hj_stringWithDate:date format:@"dd日 HH:mm"];
    }
}
- (void)setTableType:(YosKeepAccountsBillTableType)tableType {
    _tableType = tableType;
    self.bigTitleBaseVw.hidden = tableType != YosKeepAccountsBillTableTypeMonth;
    _arrowWidth.constant = tableType != YosKeepAccountsBillTableTypeMonth ? 6 : 0 ;
    _arrowLeading.constant = tableType != YosKeepAccountsBillTableTypeMonth ? 8 : 0 ;
    _arrowIV.hidden = tableType == YosKeepAccountsBillTableTypeMonth;
}
#pragma mark - Public Method
+ (NSString *)cellID {
    return @"YosKeepAccountsBillListCell";
}
+ (UINib *)cellNib {
    return [UINib nibWithNibName:@"YosKeepAccountsBillListCell" bundle:nil];
}
+ (YosKeepAccountsBillListCell *)cellWithList:(UITableView *)tableScene indexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [YosKeepAccountsBillListCell cellID];
    YosKeepAccountsBillListCell *cell =
    (YosKeepAccountsBillListCell *)[tableScene dequeueReusableCellWithIdentifier:cellID
                                                             forIndexPath:indexPath];
    return cell;
}
#pragma mark - Private Method
#pragma mark - Notification Method
#pragma mark - Event & Target Methods
@end
