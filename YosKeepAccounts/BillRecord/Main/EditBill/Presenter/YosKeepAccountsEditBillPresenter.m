#import "YosKeepAccountsEditBillPresenter.h"
#import "YosKeepAccountsEditBillToolBar.h"
#import "YosKeepAccountsLocation.h"
#import "YosKeepAccountsBillTool.h"
#import "YosKeepAccountsTranstionAnimationPop.h"
#import "YosKeepAccountsHomePresenter.h"
#import "YosKeepAccountsCustomDatePickerScene.h"
#import <HJCityPickerManager.h>
#import <HJAlertView.h>
#import <HJProgressHUD.h>
@interface YosKeepAccountsEditBillPresenter () <UITextFieldDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *billTypeLb;
@property (weak, nonatomic) IBOutlet UITextField *momeyTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *saveBillButton;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollScene;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *customNavHeight;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic, assign) NSInteger pIndex;
@property (nonatomic, assign) NSInteger cIndex;
@property (nonatomic, assign) NSInteger dIndex;
@property (weak, nonatomic) UIView *curruntInputScene;
@property (nonatomic, assign) YosKeepAccountsBillType billType;
@property (nonatomic, strong) NSDate *billTime;
@property (nonatomic, copy) NSString *billCity;
@end
@implementation YosKeepAccountsEditBillPresenter
+ (id)targetInstance {
    return [YosKeepAccountsEditBillPresenter instance];
}
+ (instancetype)instance {
    return StoryBoardLoaderRoot(@"EditBill");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"记一笔";
    [self setupUI];
    [self updateUI];
    [self addEditBillToolBar];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [[self navigationController] setDelegate:self];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.momeyTextField becomeFirstResponder];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [YosKeepAccountsEditBillToolBar hideEditBillToolBar];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)endEditing {
    [self.view endEditing:YES];
}
- (void)setupUI {
    self.momeyTextField.hj_maxLength = 10;
    self.noteTextField.hj_maxLength = 30;
    self.momeyTextField.attributedPlaceholder =  [[NSAttributedString alloc] initWithString:@"¥ 0.00" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:0.5], NSFontAttributeName: [UIFont boldSystemFontOfSize:35]}];
    self.noteTextField.attributedPlaceholder =  [[NSAttributedString alloc] initWithString:@"备注" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:0.5], NSFontAttributeName: [UIFont boldSystemFontOfSize:18]}];
    self.momeyTextField.delegate = self;
    self.noteTextField.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    [self.contentView addGestureRecognizer:tap];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.title;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = UIColor.whiteColor;
    self.navigationItem.titleView = titleLabel;
    self.customNavHeight.constant = HJ_NavigationH;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)updateUI {
    if (self.billEntity) {
        YosKeepAccountsBillType billType = self.billEntity.s_type_id.integerValue;
        self.billType = billType;
        NSString *money = [self.billEntity.s_money stringByReplacingOccurrencesOfString:@"-" withString:@""];
        self.momeyTextField.text = [NSString stringWithFormat:@"￥%@",[money moneyStyle]];
        self.noteTextField.text = self.billEntity.s_desc;
        NSTimeInterval time = self.billEntity.s_time.doubleValue;
        if (time > 0) {
            self.billTime = [NSDate dateWithTimeIntervalSince1970:time];
        } else {
            self.billTime = [NSDate date];
        }
        self.billCity = self.billEntity.s_city;
        [self.cityButton setTitle:self.billCity forState:UIControlStateNormal];
        self.deleteButton.hidden = NO;
    } else {
        self.billTime = [NSDate date];
        WEAK_SELF
        [[YosKeepAccountsLocation sharedInstance] location:^(NSString * _Nonnull city) {
            STRONG_SELF
            if (!StrIsEmpty(city)) {
                self.billCity = city;
                [self.cityButton setTitle:self.billCity forState:UIControlStateNormal];
                [self.cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }];
        self.deleteButton.hidden = YES;
    }
    [self.timeButton setTitle:[YosKeepAccountsBillTool billTimeStringWithBillTime:self.billTime] forState:UIControlStateNormal];
    UIColor *color = [YosKeepAccountsBillTool colorWithType:self.billType];
    [self setContentColor:color];
    if ([self.cityButton.currentTitle isEqualToString:@"选择城市"]) {
        [self.cityButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateNormal];
    }
    self.billTypeLb.text = [YosKeepAccountsBillTool typeNameWithIndex:_billType];
}
- (void)setBillType:(YosKeepAccountsBillType)billType {
    _billType = billType;
    self.billTypeLb.text = [YosKeepAccountsBillTool typeNameWithIndex:billType];
}
- (void)addEditBillToolBar {
    WEAK_SELF
    [YosKeepAccountsEditBillToolBar showEditBillToolBarOnSuperVC:self billType:self.billType billTime:self.billTime selectedTimeHandler:^(NSDate * _Nullable billTime) {
        STRONG_SELF
        if (billTime) {
            self.billTime = billTime;
            [self.timeButton setTitle: [YosKeepAccountsBillTool billTimeStringWithBillTime:billTime] forState:UIControlStateNormal];
        }
        if (self.curruntInputScene) {
            [self.curruntInputScene becomeFirstResponder];
        }
    } selectedClassifyHandler:^(YosKeepAccountsBillType billType) {
        STRONG_SELF
        self.billType = billType;
        [UIView animateWithDuration:0.5 animations:^{
            UIColor *color = [YosKeepAccountsBillTool colorWithType:billType];
            [self setContentColor:color];
        }];
    }];
}
- (void)setContentColor:(UIColor *)color {
    self.view.backgroundColor = color;
    self.contentView.backgroundColor = color;
    self.contentScrollScene.backgroundColor = color;
}
- (IBAction)saveBillButtonClick:(id)sender {
    if (StrIsEmpty(self.momeyTextField.text)) {
        [KeyWindow hj_showToastHUD:@"请输入账单金额"];
        return;
    }
    NSString *memeyStr = [self.momeyTextField.text stringByReplacingOccurrencesOfString:@"￥" withString:@""];
    memeyStr = [memeyStr stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSString *memey = [memeyStr cleanMoneyStyle];
    if (StrIsEmpty(memey)) {
        [KeyWindow hj_showToastHUD:@"请输入账单金额"];
        return;
    }
    if (memey.integerValue == 0) {
        [KeyWindow hj_showToastHUD:@"请输入账单金额"];
        return;
    }
    [self.view endEditing:YES];
    YosKeepAccountsBillEntity *model = self.billEntity;
    BOOL newBill = NO;
    if (!model) {
        model = [YosKeepAccountsBillEntity new];
        newBill = YES;
    }
    model.s_money = [NSString stringWithFormat:@"-%@", memey];
    model.s_type_name = [YosKeepAccountsBillTool typeNameWithIndex:self.billType];
    model.s_type_id = @(self.billType).stringValue;
    model.s_year = @(self.billTime.hj_year).stringValue;
    model.s_month = @(self.billTime.hj_month).stringValue;
    model.s_day = @(self.billTime.hj_day).stringValue;
    model.s_time = @(self.billTime.timeIntervalSince1970).stringValue;
    model.s_desc = self.noteTextField.text;
    model.s_city = self.billCity ?: @"";
    if (newBill) {
        [[YosKeepAccountsSQLManager share] insertData:model tableName:kSQLTableName];
    } else {
        [[YosKeepAccountsSQLManager share] updateData:model tableName:kSQLTableName];
    }
    [self saveBillDone];
}
- (void)setBillTypeStr:(NSString *)billTypeStr {
    _billTypeStr = billTypeStr;
    self.billType = billTypeStr.integerValue;
}
- (IBAction)backButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)deletButtonClick:(id)sender {
    if (self.billEntity) {
        [self.view endEditing:YES];
        WEAK_SELF
        HJAlertView *alertScene = [[HJAlertView alloc] initWithTitle:@"确定要删除账单吗" message:nil cancelBlock:^{
        } confirmBlock:^{
            STRONG_SELF
            [[YosKeepAccountsSQLManager share] deleteData:kSQLTableName s_id:self.billEntity.s_id];
            [KeyWindow hj_showToastHUD:@"账单已删除"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertScene show];
    }
}
- (IBAction)selectBillTime:(id)sender {
    if (self.noteTextField.isFirstResponder || self.momeyTextField.isFirstResponder) {
        [self.view endEditing:YES];
    } else {
        self.curruntInputScene = nil;
    }
    NSString *time = [YosKeepAccountsBillTool billTimeStringWithBillTime:self.billTime];
    WEAK_SELF
    [YosKeepAccountsCustomDatePickerScene showDatePickerWithTitle:@"选择时间"
                                           dateType:YosKeepAccountsCustomDatePickerModeYMDHM
                                    defaultSelValue:time
                                            minDate:nil
                                            maxDate:nil
                                       isAutoSelect:NO
                                         themeColor:[YosKeepAccountsBillTool colorWithType:self.billType]
                                        resultBlock:^(NSString *selectValue) {
                                            STRONG_SELF
                                            self.billTime = [YosKeepAccountsBillTool billTimeWithBillTimeString:selectValue];
                                            [self.timeButton setTitle:selectValue forState:UIControlStateNormal];
                                            if (self.curruntInputScene) {
                                                [self.curruntInputScene becomeFirstResponder];
                                            }
                                        }
                                        cancelBlock:^{
                                            STRONG_SELF
                                            if (self.curruntInputScene) {
                                                [self.curruntInputScene becomeFirstResponder];
                                            }
                                        }];
}
- (IBAction)selectBillCity:(id)sender {
    if (self.noteTextField.isFirstResponder || self.momeyTextField.isFirstResponder) {
        [self.view endEditing:YES];
    } else {
        self.curruntInputScene = nil;
    }
    HJCityPickerManager *cityPicker = [HJCityPickerManager cityPickerManagerWithTitle:@"选择城市" type:HJCityPickerTypeAll regionList:[HJCPMLocalData provinceArray] cityPickSelected:^(HJCPMProvinceModel * _Nullable selectedProvinceEntity, HJCPMCityModel * _Nullable selectedCityEntity, HJCPMDistrictModel * _Nullable selectedDistrictEntity) {
        self.billCity = selectedDistrictEntity.name;
        [self.cityButton setTitle:self.billCity forState:UIControlStateNormal];
        [self.cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.pIndex = selectedProvinceEntity.index;
        self.cIndex = selectedCityEntity.index;
        self.dIndex = selectedDistrictEntity.index;
    }];
    UIColor *color = [YosKeepAccountsBillTool colorWithType:self.billType];
    [cityPicker.commitBtn setTitleColor:color forState:UIControlStateNormal];
    cityPicker.titleLabel.textColor = color;
    cityPicker.pickerViewRowSelectedTextColor = color;
    [cityPicker selecteCityWithProvinceIndex:self.pIndex cityIndex:self.cIndex districtIndex:self.dIndex animated:YES];
    [cityPicker showPickerFromController:self];
}
- (void)keyboardWillShowNotification:(NSNotification *)noti {
    CGFloat offset = (SHeight/2) - 178 - HJ_NavigationH;
    CGFloat navHeight = HJ_NavigationH;
    if (offset < navHeight) {
        offset = navHeight;
    }
    [self.contentScrollScene setContentInset:UIEdgeInsetsMake(0 - offset, 0, 0, 0)];
}
- (void)keyboardWillHideNotification:(NSNotification *)noti {
    [self.contentScrollScene setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}
- (void)saveBillDone {
    UIColor *color = [YosKeepAccountsBillTool colorWithType:self.billType];
    UIImage *image = [UIImage imageNamed:[YosKeepAccountsBillTool typePressedImage:self.billType]];
    [self.saveBillButton setTitle:@"" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        self.momeyTextField.textColor = color;
        self.noteTextField.textColor = color;
        [self.timeButton setTitleColor:color forState:UIControlStateNormal];
        self.saveBillButton.layer.borderColor = color.CGColor;
        [self.saveBillButton setImage:image forState:UIControlStateNormal];
        self.backButton.tintColor = color;
        self.deleteButton.tintColor = color;
        self.titleLabel.textColor = color;
        self.billTypeLb.textColor = color;
        if (self.billCity) {
            [self.cityButton setTitleColor:color forState:UIControlStateNormal];
        }
        [self setContentColor:UIColor.whiteColor];
    } completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField == self.momeyTextField) {
        NSString *tfString = textField.text;
        if (!StrIsEmpty(tfString)) {
            if ([tfString containsString:@"￥"]) {
                tfString = [tfString stringByReplacingOccurrencesOfString:@"￥" withString:@""];
                tfString = [tfString stringByReplacingOccurrencesOfString:@"," withString:@""];
            }
            tfString = [NSString stringWithFormat:@"￥%@",[tfString moneyStyle]];
            textField.text = tfString;
        } else {
            self.momeyTextField.text = @"";
        }
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.curruntInputScene = textField;
}
#pragma mark -- UINavigationControllerDelegate --
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if ([fromVC isKindOfClass:[YosKeepAccountsEditBillPresenter class]] &&
        [toVC isKindOfClass:[YosKeepAccountsHomePresenter class]] &&
        operation == UINavigationControllerOperationPop) {
        return [YosKeepAccountsTranstionAnimationPop new];
    } else {
        return nil;
    }
}
@end
