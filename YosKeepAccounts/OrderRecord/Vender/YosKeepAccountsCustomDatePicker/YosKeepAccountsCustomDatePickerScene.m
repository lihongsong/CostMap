#import "YosKeepAccountsCustomDatePickerScene.h"
typedef NS_ENUM(NSInteger, BRDatePickerStyle) {
    BRDatePickerStyleSystem,   
    BRDatePickerStyleCustom    
};
@interface YosKeepAccountsCustomDatePickerScene () <UIPickerViewDataSource, UIPickerViewDelegate> {
    NSInteger _yearIndex;
    NSInteger _monthIndex;
    NSInteger _dayIndex;
    NSInteger _hourIndex;
    NSInteger _minuteIndex;
    NSString *_title;
    UIDatePickerMode _datePickerMode;
    BOOL _isAutoSelect;  
    UIColor *_themeColor;
}
@property(nonatomic, strong) UIDatePicker *datePicker;
@property(nonatomic, strong) UIPickerView *pickerScene;
@property(nonatomic, strong) NSArray *yearArr;
@property(nonatomic, strong) NSArray *monthArr;
@property(nonatomic, strong) NSArray *dayArr;
@property(nonatomic, strong) NSArray *hourArr;
@property(nonatomic, strong) NSArray *minuteArr;
@property(nonatomic, assign) YosKeepAccountsCustomDatePickerMode showType;
@property(nonatomic, assign) BRDatePickerStyle style;
@property(nonatomic, strong) NSDate *minLimitDate;
@property(nonatomic, strong) NSDate *maxLimitDate;
@property(nonatomic, strong) NSDate *selectDate;
@property(nonatomic, strong) NSString *selectDateFormatter;
@property(nonatomic, copy) YosKeepAccountsCustomDateResultBlock resultBlock;
@property(nonatomic, copy) YosKeepAccountsCustomDateCancelBlock cancelBlock;
@end
@implementation YosKeepAccountsCustomDatePickerScene

+ (YosKeepAccountsCustomDatePickerScene *)showDatePickerWithTitle:(NSString *)title
                                           dateType:(YosKeepAccountsCustomDatePickerMode)type
                                    defaultSelValue:(NSString *)defaultSelValue
                                        resultBlock:(YosKeepAccountsCustomDateResultBlock)resultBlock {
    return [self showDatePickerWithTitle:title dateType:type defaultSelValue:defaultSelValue minDate:nil maxDate:nil isAutoSelect:NO themeColor:nil resultBlock:resultBlock cancelBlock:nil];
}
+ (YosKeepAccountsCustomDatePickerScene *)showDatePickerWithTitle:(NSString *)title
                                           dateType:(YosKeepAccountsCustomDatePickerMode)type
                                    defaultSelValue:(NSString *)defaultSelValue
                                            minDate:(NSDate *)minDate
                                            maxDate:(NSDate *)maxDate
                                       isAutoSelect:(BOOL)isAutoSelect
                                         themeColor:(UIColor *)themeColor
                                        resultBlock:(YosKeepAccountsCustomDateResultBlock)resultBlock {
    return [self showDatePickerWithTitle:title dateType:type defaultSelValue:defaultSelValue minDate:minDate maxDate:maxDate isAutoSelect:isAutoSelect themeColor:themeColor resultBlock:resultBlock cancelBlock:nil];
}
+ (YosKeepAccountsCustomDatePickerScene *)showDatePickerWithTitle:(NSString *)title
                                           dateType:(YosKeepAccountsCustomDatePickerMode)type
                                    defaultSelValue:(NSString *)defaultSelValue
                                            minDate:(NSDate *)minDate
                                            maxDate:(NSDate *)maxDate
                                       isAutoSelect:(BOOL)isAutoSelect
                                         themeColor:(UIColor *)themeColor
                                        resultBlock:(YosKeepAccountsCustomDateResultBlock)resultBlock
                                        cancelBlock:(YosKeepAccountsCustomDateCancelBlock)cancelBlock {
    YosKeepAccountsCustomDatePickerScene *datePickerScene = [[YosKeepAccountsCustomDatePickerScene alloc] initWithTitle:title dateType:type defaultSelValue:defaultSelValue minDate:minDate maxDate:maxDate isAutoSelect:isAutoSelect themeColor:themeColor resultBlock:resultBlock cancelBlock:cancelBlock];
    [datePickerScene showWithAnimation:YES];
    return datePickerScene;
}
- (instancetype)initWithTitle:(NSString *)title
                     dateType:(YosKeepAccountsCustomDatePickerMode)type
              defaultSelValue:(NSString *)defaultSelValue
                      minDate:(NSDate *)minDate
                      maxDate:(NSDate *)maxDate
                 isAutoSelect:(BOOL)isAutoSelect
                   themeColor:(UIColor *)themeColor
                  resultBlock:(YosKeepAccountsCustomDateResultBlock)resultBlock
                  cancelBlock:(YosKeepAccountsCustomDateCancelBlock)cancelBlock {
    if (self = [super init]) {
        _title = title;
        _isAutoSelect = isAutoSelect;
        _themeColor = themeColor;
        _resultBlock = resultBlock;
        _cancelBlock = cancelBlock;
        self.showType = type;
        [self setupSelectDateFormatter:type];
        if (defaultSelValue && defaultSelValue.length > 0) {
            NSDate *defaultSelDate = [NSDate getDate:defaultSelValue format:self.selectDateFormatter];
            if (!defaultSelDate) {
                defaultSelDate = [NSDate date]; 
            }
            self.selectDate = defaultSelDate;
        } else {
            self.selectDate = [NSDate date];
        }
        if (minDate) {
            self.minLimitDate = minDate;
        } else {
            if (self.style == BRDatePickerStyleCustom) {
                self.minLimitDate = [NSDate distantPast];
            }
        }
        if (maxDate) {
            self.maxLimitDate = maxDate;
        } else {
            if (self.style == BRDatePickerStyleCustom) {
                self.maxLimitDate = [NSDate distantFuture];
            }
        }
        if (self.style == BRDatePickerStyleCustom) {
            [self initData];
        }
        [self initUI];
        if (self.style == BRDatePickerStyleSystem) {
            [self.datePicker setDate:self.selectDate animated:YES];
        } else if (self.style == BRDatePickerStyleCustom) {
            [self scrollToSelectDate];
        }
    }
    return self;
}
- (void)setupSelectDateFormatter:(YosKeepAccountsCustomDatePickerMode)type {
    switch (type) {
        case YosKeepAccountsCustomDatePickerModeTime: {
            self.selectDateFormatter = @"HH:mm";
            self.style = BRDatePickerStyleSystem;
            _datePickerMode = UIDatePickerModeTime;
        }
            break;
        case YosKeepAccountsCustomDatePickerModeDate: {
            self.selectDateFormatter = @"yyyy-MM-dd";
            self.style = BRDatePickerStyleSystem;
            _datePickerMode = UIDatePickerModeDate;
        }
            break;
        case YosKeepAccountsCustomDatePickerModeDateAndTime: {
            self.selectDateFormatter = @"yyyy-MM-dd HH:mm";
            self.style = BRDatePickerStyleSystem;
            _datePickerMode = UIDatePickerModeDateAndTime;
        }
            break;
        case YosKeepAccountsCustomDatePickerModeCountDownTimer: {
            self.selectDateFormatter = @"HH:mm";
            self.style = BRDatePickerStyleSystem;
            _datePickerMode = UIDatePickerModeCountDownTimer;
        }
            break;
        case YosKeepAccountsCustomDatePickerModeYMDHM: {
            self.selectDateFormatter = @"yyyy-MM-dd HH:mm:ss";
            self.style = BRDatePickerStyleCustom;
        }
            break;
        case YosKeepAccountsCustomDatePickerModeMDHM: {
            self.selectDateFormatter = @"MM-dd HH:mm";
            self.style = BRDatePickerStyleCustom;
        }
            break;
        case YosKeepAccountsCustomDatePickerModeYMD: {
            self.selectDateFormatter = @"yyyy-MM-dd";
            self.style = BRDatePickerStyleCustom;
        }
            break;
        case YosKeepAccountsCustomDatePickerModeYM: {
            self.selectDateFormatter = @"yyyy-MM";
            self.style = BRDatePickerStyleCustom;
        }
            break;
        case YosKeepAccountsCustomDatePickerModeY: {
            self.selectDateFormatter = @"yyyy";
            self.style = BRDatePickerStyleCustom;
        }
            break;
        case YosKeepAccountsCustomDatePickerModeMD: {
            self.selectDateFormatter = @"MM-dd";
            self.style = BRDatePickerStyleCustom;
        }
            break;
        case YosKeepAccountsCustomDatePickerModeHM: {
            self.selectDateFormatter = @"HH:mm";
            self.style = BRDatePickerStyleCustom;
        }
            break;
        default:
            break;
    }
}
- (void)initUI {
    [super initUI];
    self.titleLabel.text = _title;
    if (self.style == BRDatePickerStyleSystem) {
        [self.alertScene addSubview:self.datePicker];
    } else if (self.style == BRDatePickerStyleCustom) {
        [self.alertScene addSubview:self.pickerScene];
    }
    if (_themeColor && [_themeColor isKindOfClass:[UIColor class]]) {
        [self setupThemeColor:_themeColor];
    }
}
- (void)initData {
    [self setupYearArr];
    _yearIndex = self.selectDate.year - self.minLimitDate.year;
    _monthIndex = self.selectDate.month - ((_yearIndex == 0) ? self.minLimitDate.month : 1);
    _dayIndex = self.selectDate.day - ((_yearIndex == 0 && _monthIndex == 0) ? self.minLimitDate.day : 1);
    _hourIndex = self.selectDate.hour - ((_yearIndex == 0 && _monthIndex == 0 && _dayIndex == 0) ? self.minLimitDate.hour : 0);
    _minuteIndex = self.selectDate.minute - ((_yearIndex == 0 && _monthIndex == 0 && _dayIndex == 0 && _hourIndex == 0) ? self.minLimitDate.minute : 0);
    [self setupDateArray];
}
- (void)setupDateArray {
    NSInteger year = [self.yearArr[_yearIndex] integerValue];
    [self setupMonthArr:year];
    _monthIndex = (_monthIndex > self.monthArr.count - 1) ? (self.monthArr.count - 1) : _monthIndex;
    NSInteger month = [self.monthArr[_monthIndex] integerValue];
    [self setupDayArr:year month:month];
    _dayIndex = (_dayIndex > self.dayArr.count - 1) ? (self.dayArr.count - 1) : _dayIndex;
    NSInteger day = [self.dayArr[_dayIndex] integerValue];
    [self setupHourArr:year month:month day:day];
    _hourIndex = (_hourIndex > self.hourArr.count - 1) ? (self.hourArr.count - 1) : _hourIndex;
    NSInteger hour = [self.hourArr[_hourIndex] integerValue];
    [self setupMinuteArr:year month:month day:day hour:hour];
    _minuteIndex = (_minuteIndex > self.minuteArr.count - 1) ? (self.minuteArr.count - 1) : _minuteIndex;
}
- (void)setupYearArr {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = self.minLimitDate.year; i <= self.maxLimitDate.year; i++) {
        [tempArr addObject:[@(i) stringValue]];
    }
    self.yearArr = [tempArr copy];
}
- (void)setupMonthArr:(NSInteger)year {
    NSInteger startMonth = 1;
    NSInteger endMonth = 12;
    if (year == self.minLimitDate.year) {
        startMonth = self.minLimitDate.month;
    }
    if (year == self.maxLimitDate.year) {
        endMonth = self.maxLimitDate.month;
    }
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:(endMonth - startMonth + 1)];
    for (NSInteger i = startMonth; i <= endMonth; i++) {
        [tempArr addObject:[@(i) stringValue]];
    }
    self.monthArr = [tempArr copy];
}
- (void)setupDayArr:(NSInteger)year month:(NSInteger)month {
    NSInteger startDay = 1;
    NSInteger endDay = [NSDate getDaysInYear:year month:month];
    if (year == self.minLimitDate.year && month == self.minLimitDate.month) {
        startDay = self.minLimitDate.day;
    }
    if (year == self.maxLimitDate.year && month == self.maxLimitDate.month) {
        endDay = self.maxLimitDate.day;
    }
    NSMutableArray *tempDayArr = [NSMutableArray array];
    for (NSInteger i = startDay; i <= endDay; i++) {
        [tempDayArr addObject:[NSString stringWithFormat:@"%zi", i]];
    }
    self.dayArr = tempDayArr;
}
- (void)setupHourArr:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSInteger startHour = 0;
    NSInteger endHour = 23;
    if (year == self.minLimitDate.year && month == self.minLimitDate.month && day == self.minLimitDate.day) {
        startHour = self.minLimitDate.hour;
    }
    if (year == self.maxLimitDate.year && month == self.maxLimitDate.month && day == self.maxLimitDate.day) {
        endHour = self.maxLimitDate.hour;
    }
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:(endHour - startHour + 1)];
    for (NSInteger i = startHour; i <= endHour; i++) {
        [tempArr addObject:[@(i) stringValue]];
    }
    self.hourArr = [tempArr copy];
}
- (void)setupMinuteArr:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour {
    NSInteger startMinute = 0;
    NSInteger endMinute = 59;
    if (year == self.minLimitDate.year && month == self.minLimitDate.month && day == self.minLimitDate.day && hour == self.minLimitDate.hour) {
        startMinute = self.minLimitDate.minute;
    }
    if (year == self.maxLimitDate.year && month == self.maxLimitDate.month && day == self.maxLimitDate.day && hour == self.maxLimitDate.hour) {
        endMinute = self.maxLimitDate.minute;
    }
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:(endMinute - startMinute + 1)];
    for (NSInteger i = startMinute; i <= endMinute; i++) {
        [tempArr addObject:[@(i) stringValue]];
    }
    self.minuteArr = [tempArr copy];
}
- (void)scrollToSelectDate {
    NSArray *indexArr = [NSArray array];
    if (self.showType == YosKeepAccountsCustomDatePickerModeYMDHM) {
        indexArr = @[@(_yearIndex), @(_monthIndex), @(_dayIndex), @(_hourIndex), @(_minuteIndex)];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeMDHM) {
        indexArr = @[@(_monthIndex), @(_dayIndex), @(_hourIndex), @(_minuteIndex)];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeYMD) {
        indexArr = @[@(_yearIndex), @(_monthIndex), @(_dayIndex)];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeYM) {
        indexArr = @[@(_yearIndex), @(_monthIndex)];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeY) {
        indexArr = @[@(_yearIndex)];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeMD) {
        indexArr = @[@(_monthIndex), @(_dayIndex)];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeHM) {
        indexArr = @[@(_hourIndex), @(_minuteIndex)];
    }
    for (NSInteger i = 0; i < indexArr.count; i++) {
        [self.pickerScene selectRow:[indexArr[i] integerValue] inComponent:i animated:YES];
    }
}
- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kTopSceneHeight + 0.5, self.alertScene.frame.size.width, kPickerHeight)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.datePickerMode = _datePickerMode;
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CHS_CN"];
        if (self.minLimitDate) {
            _datePicker.minimumDate = self.minLimitDate;
        }
        if (self.maxLimitDate) {
            _datePicker.maximumDate = self.maxLimitDate;
        }
        [_datePicker addTarget:self action:@selector(didSelectValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}
- (UIPickerView *)pickerScene {
    if (!_pickerScene) {
        _pickerScene = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kTopSceneHeight + 0.5, self.alertScene.frame.size.width, kPickerHeight)];
        _pickerScene.backgroundColor = [UIColor whiteColor];
        _pickerScene.dataSource = self;
        _pickerScene.delegate = self;
        _pickerScene.showsSelectionIndicator = YES;
    }
    return _pickerScene;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerScene {
    if (self.showType == YosKeepAccountsCustomDatePickerModeYMDHM) {
        return 5;
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeMDHM) {
        return 4;
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeYMD) {
        return 3;
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeYM) {
        return 2;
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeY) {
        return 1;
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeMD) {
        return 2;
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeHM) {
        return 2;
    }
    return 0;
}
- (NSInteger)pickerView:(UIPickerView *)pickerScene numberOfRowsInComponent:(NSInteger)component {
    NSArray *rowsArr = [NSArray array];
    if (self.showType == YosKeepAccountsCustomDatePickerModeYMDHM) {
        rowsArr = @[@(self.yearArr.count), @(self.monthArr.count), @(self.dayArr.count), @(self.hourArr.count), @(self.minuteArr.count)];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeMDHM) {
        rowsArr = @[@(self.monthArr.count), @(self.dayArr.count), @(self.hourArr.count), @(self.minuteArr.count)];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeYMD) {
        rowsArr = @[@(self.yearArr.count), @(self.monthArr.count), @(self.dayArr.count)];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeYM) {
        rowsArr = @[@(self.yearArr.count), @(self.monthArr.count)];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeY) {
        rowsArr = @[@(self.yearArr.count)];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeMD) {
        rowsArr = @[@(self.monthArr.count), @(self.dayArr.count)];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeHM) {
        rowsArr = @[@(self.hourArr.count), @(self.minuteArr.count)];
    }
    return [rowsArr[component] integerValue];
}
- (UIView *)pickerView:(UIPickerView *)pickerScene viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    ((UIView *) [pickerScene.subviews objectAtIndex:1]).backgroundColor = [UIColor colorWithRed:195 / 255.0 green:195 / 255.0 blue:195 / 255.0 alpha:1.0f];
    ((UIView *) [pickerScene.subviews objectAtIndex:2]).backgroundColor = [UIColor colorWithRed:195 / 255.0 green:195 / 255.0 blue:195 / 255.0 alpha:1.0f];
    UILabel *label = (UILabel *) view;
    if (!label) {
        label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:20.0f * kScaleFit];
        label.adjustsFontSizeToFitWidth = YES;
        label.minimumScaleFactor = 0.5f;
    }
    [self setDateLabelText:label component:component row:row];
    return label;
}
- (void)pickerView:(UIPickerView *)pickerScene didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self setSelectedIndex:component row:row];
    if (_isAutoSelect) {
        if (self.resultBlock) {
            NSString *selectDateValue = [NSDate getDateString:self.selectDate format:self.selectDateFormatter];
            self.resultBlock(selectDateValue);
        }
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerScene rowHeightForComponent:(NSInteger)component {
    return 35.0f * kScaleFit;
}
- (void)setDateLabelText:(UILabel *)label component:(NSInteger)component row:(NSInteger)row {
    if (self.showType == YosKeepAccountsCustomDatePickerModeYMDHM) {
        if (component == 0) {
            label.text = [NSString stringWithFormat:@"%@year", self.yearArr[row]];
        } else if (component == 1) {
            label.text = [NSString stringWithFormat:@"%@month", self.monthArr[row]];
        } else if (component == 2) {
            label.text = [NSString stringWithFormat:@"%@day", self.dayArr[row]];
        } else if (component == 3) {
            label.text = [NSString stringWithFormat:@"%@hour", self.hourArr[row]];
        } else if (component == 4) {
            label.text = [NSString stringWithFormat:@"%@minute", self.minuteArr[row]];
        }
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeMDHM) {
        if (component == 0) {
            label.text = [NSString stringWithFormat:@"%@month", self.monthArr[row]];
        } else if (component == 1) {
            label.text = [NSString stringWithFormat:@"%@day", self.dayArr[row]];
        } else if (component == 2) {
            label.text = [NSString stringWithFormat:@"%@hour", self.hourArr[row]];
        } else if (component == 3) {
            label.text = [NSString stringWithFormat:@"%@minute", self.minuteArr[row]];
        }
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeYMD) {
        if (component == 0) {
            label.text = [NSString stringWithFormat:@"%@year", self.yearArr[row]];
        } else if (component == 1) {
            label.text = [NSString stringWithFormat:@"%@month", self.monthArr[row]];
        } else if (component == 2) {
            label.text = [NSString stringWithFormat:@"%@day", self.dayArr[row]];
        }
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeYM) {
        if (component == 0) {
            label.text = [NSString stringWithFormat:@"%@year", self.yearArr[row]];
        } else if (component == 1) {
            label.text = [NSString stringWithFormat:@"%@month", self.monthArr[row]];
        }
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeY) {
        if (component == 0) {
            label.text = [NSString stringWithFormat:@"%@year", self.yearArr[row]];
        }
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeMD) {
        if (component == 0) {
            label.text = [NSString stringWithFormat:@"%@month", self.monthArr[row]];
        } else if (component == 1) {
            label.text = [NSString stringWithFormat:@"%@day", self.dayArr[row]];
        }
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeHM) {
        if (component == 0) {
            label.text = [NSString stringWithFormat:@"%@hour", self.hourArr[row]];
        } else if (component == 1) {
            label.text = [NSString stringWithFormat:@"%@minute", self.minuteArr[row]];
        }
    }
}
- (void)setSelectedIndex:(NSInteger)component row:(NSInteger)row {
    NSString *selectDateValue = nil;
    if (self.showType == YosKeepAccountsCustomDatePickerModeYMDHM) {
        if (component == 0) {
            _yearIndex = row;
            [self setupDateArray];
            [self.pickerScene reloadComponent:1];
            [self.pickerScene reloadComponent:2];
            [self.pickerScene reloadComponent:3];
            [self.pickerScene reloadComponent:4];
        } else if (component == 1) {
            _monthIndex = row;
            [self setupDateArray];
            [self.pickerScene reloadComponent:2];
            [self.pickerScene reloadComponent:3];
            [self.pickerScene reloadComponent:4];
        } else if (component == 2) {
            _dayIndex = row;
            [self setupDateArray];
            [self.pickerScene reloadComponent:3];
            [self.pickerScene reloadComponent:4];
        } else if (component == 3) {
            _hourIndex = row;
            [self setupDateArray];
            [self.pickerScene reloadComponent:4];
        } else if (component == 4) {
            _minuteIndex = row;
        }
        selectDateValue = [NSString stringWithFormat:@"%@-%02zi-%02zi %02zi:%02zi:00", self.yearArr[_yearIndex], [self.monthArr[_monthIndex] integerValue], [self.dayArr[_dayIndex] integerValue], [self.hourArr[_hourIndex] integerValue], [self.minuteArr[_minuteIndex] integerValue]];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeMDHM) {
        if (component == 0) {
            _monthIndex = row;
            [self setupDateArray];
            [self.pickerScene reloadComponent:1];
            [self.pickerScene reloadComponent:2];
            [self.pickerScene reloadComponent:3];
        } else if (component == 1) {
            _dayIndex = row;
            [self setupDateArray];
            [self.pickerScene reloadComponent:2];
            [self.pickerScene reloadComponent:3];
        } else if (component == 2) {
            _hourIndex = row;
            [self setupDateArray];
            [self.pickerScene reloadComponent:3];
        } else if (component == 3) {
            _minuteIndex = row;
        }
        selectDateValue = [NSString stringWithFormat:@"%02zi-%02zi %02zi:%02zi", [self.monthArr[_monthIndex] integerValue], [self.dayArr[_dayIndex] integerValue], [self.hourArr[_hourIndex] integerValue], [self.minuteArr[_minuteIndex] integerValue]];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeYMD) {
        if (component == 0) {
            _yearIndex = row;
            [self setupDateArray];
            [self.pickerScene reloadComponent:1];
            [self.pickerScene reloadComponent:2];
        } else if (component == 1) {
            _monthIndex = row;
            [self setupDateArray];
            [self.pickerScene reloadComponent:2];
        } else if (component == 2) {
            _dayIndex = row;
        }
        selectDateValue = [NSString stringWithFormat:@"%@-%02zi-%02zi", self.yearArr[_yearIndex], [self.monthArr[_monthIndex] integerValue], [self.dayArr[_dayIndex] integerValue]];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeYM) {
        if (component == 0) {
            _yearIndex = row;
            [self setupDateArray];
            [self.pickerScene reloadComponent:1];
        } else if (component == 1) {
            _monthIndex = row;
        }
        selectDateValue = [NSString stringWithFormat:@"%@-%02zi", self.yearArr[_yearIndex], [self.monthArr[_monthIndex] integerValue]];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeY) {
        if (component == 0) {
            _yearIndex = row;
        }
        selectDateValue = [NSString stringWithFormat:@"%@", self.yearArr[_yearIndex]];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeMD) {
        if (component == 0) {
            _monthIndex = row;
            [self setupDateArray];
            [self.pickerScene reloadComponent:1];
        } else if (component == 1) {
            _dayIndex = row;
        }
        selectDateValue = [NSString stringWithFormat:@"%02zi-%02zi", [self.monthArr[_monthIndex] integerValue], [self.dayArr[_dayIndex] integerValue]];
    } else if (self.showType == YosKeepAccountsCustomDatePickerModeHM) {
        if (component == 0) {
            _hourIndex = row;
            [self setupDateArray];
            [self.pickerScene reloadComponent:1];
        } else if (component == 1) {
            _minuteIndex = row;
        }
        selectDateValue = [NSString stringWithFormat:@"%02zi:%02zi", [self.hourArr[_hourIndex] integerValue], [self.minuteArr[_minuteIndex] integerValue]];
    }
    self.selectDate = [NSDate getDate:selectDateValue format:self.selectDateFormatter];
}
- (void)didTapBackgroundScene:(UITapGestureRecognizer *)sender {
    [self dismissWithAnimation:NO];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}
- (void)didSelectValueChanged:(UIDatePicker *)sender {
    self.selectDate = sender.date;
    if (_isAutoSelect) {
        if (self.resultBlock) {
            NSString *selectDateValue = [NSDate getDateString:self.selectDate format:self.selectDateFormatter];
            self.resultBlock(selectDateValue);
        }
    }
}
- (void)clickLeftBtn {
    [self dismissWithAnimation:YES];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}
- (void)clickRightBtn {
    [self dismissWithAnimation:YES];
    if (self.resultBlock) {
        NSString *selectDateValue = [NSDate getDateString:self.selectDate format:self.selectDateFormatter];
        self.resultBlock(selectDateValue);
    }
}
- (void)showWithAnimation:(BOOL)animation {
    [KeyWindow addSubview:self];
    if (animation) {
        CGRect rect = self.alertScene.frame;
        rect.origin.y = SCREEN_HEIGHT;
        self.alertScene.frame = rect;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.alertScene.frame;
            rect.origin.y -= kPickerHeight + kTopSceneHeight + HJ_BottombarH;
            self.alertScene.frame = rect;
        }];
    }
}
- (void)dismissWithAnimation:(BOOL)animation {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertScene.frame;
        rect.origin.y += kPickerHeight + kTopSceneHeight + HJ_BottombarH;
        self.alertScene.frame = rect;
        self.backgroundScene.alpha = 0;
    }                completion:^(BOOL finished) {
        [self.leftBtn removeFromSuperview];
        [self.rightBtn removeFromSuperview];
        [self.titleLabel removeFromSuperview];
        [self.lineScene removeFromSuperview];
        [self.topScene removeFromSuperview];
        [self.datePicker removeFromSuperview];
        [self.pickerScene removeFromSuperview];
        [self.alertScene removeFromSuperview];
        [self.backgroundScene removeFromSuperview];
        [self removeFromSuperview];
        self.leftBtn = nil;
        self.rightBtn = nil;
        self.titleLabel = nil;
        self.lineScene = nil;
        self.topScene = nil;
        self.datePicker = nil;
        self.pickerScene = nil;
        self.alertScene = nil;
        self.backgroundScene = nil;
    }];
}
- (NSArray *)yearArr {
    if (!_yearArr) {
        _yearArr = [NSArray array];
    }
    return _yearArr;
}
- (NSArray *)monthArr {
    if (!_monthArr) {
        _monthArr = [NSArray array];
    }
    return _monthArr;
}
- (NSArray *)dayArr {
    if (!_dayArr) {
        _dayArr = [NSArray array];
    }
    return _dayArr;
}
- (NSArray *)hourArr {
    if (!_hourArr) {
        _hourArr = [NSArray array];
    }
    return _hourArr;
}
- (NSArray *)minuteArr {
    if (!_minuteArr) {
        _minuteArr = [NSArray array];
    }
    return _minuteArr;
}
@end
