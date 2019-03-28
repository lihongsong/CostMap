#import "YosKeepAccountsDaySelectedScene.h"
#define kDaySelectFormat @"yyyy-MM-dd"
@interface YosKeepAccountsDaySelectedScene ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic, readwrite) NSDate *currentDate;
@end
@implementation YosKeepAccountsDaySelectedScene
#pragma mark - Life Cycle
+ (instancetype)instance {
    return (YosKeepAccountsDaySelectedScene *)[[[NSBundle mainBundle] loadNibNamed:@"YosKeepAccountsDaySelectedScene"
                                                                 owner:nil
                                                               options:nil] firstObject];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpUI];
}
#pragma mark - Getter & Setter Methods
- (void)setCurrentDate:(NSDate *)currentDate {
    _currentDate = currentDate;
    _dateLabel.text = [currentDate hj_stringWithFormat:kDaySelectFormat];
}
#pragma mark - Public Method
- (void)refreshDate:(NSDate *)date {
    [self setCurrentDate:date];
}
#pragma mark - Private Method
- (void)setUpUI {
    NSDate *today = [NSDate date];
    [self setCurrentDate:today];
}
#pragma mark - Notification Method
#pragma mark - Event & Target Methods
- (IBAction)leftBtnClick:(UIButton *)sender {
    NSDate *date = [_currentDate hj_dateAfterDay:-1];
    [self setCurrentDate:date];
    if ([self.delegate respondsToSelector:@selector(selectedScene:didChangeDate:)]) {
        [self.delegate selectedScene:self didChangeDate:_currentDate];
    }
}
- (IBAction)rightBtnClick:(UIButton *)sender {
    NSDate *date = [_currentDate hj_dateAfterDay:1];
    [self setCurrentDate:date];
    if ([self.delegate respondsToSelector:@selector(selectedScene:didChangeDate:)]) {
        [self.delegate selectedScene:self didChangeDate:_currentDate];
    }
}
- (IBAction)titleBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectedScene:didClickDate:)]) {
        [self.delegate selectedScene:self didClickDate:_currentDate];
    }
}
@end