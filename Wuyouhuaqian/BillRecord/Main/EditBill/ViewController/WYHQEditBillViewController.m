//
//  WYHQEditViewController.m
//  Wuyouhuaqian
//
//  Created by sunhw on 2018/11/8.
//  Copyright © 2018 yoser. All rights reserved.
//

#import "WYHQEditBillViewController.h"
#import "WYHQEditBillToolBar.h"
#import "WYHQLocation.h"
#import "WYHQBillTool.h"
#import "WYHQTranstionAnimationPop.h"
#import "WYHQHomeViewController.h"
#import "CLCustomDatePickerView.h"
#import <HJCityPickerManager.h>
#import <HJAlertView.h>
#import <HJProgressHUD.h>

@interface WYHQEditBillViewController () <UITextFieldDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *billTypeLb;

@property (weak, nonatomic) IBOutlet UITextField *momeyTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *saveBillButton;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *customNavHeight;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

/** 城市选择器 */
@property (nonatomic, strong) HJCityPickerManager *cityPicker;
/** 选择的省 */
@property (nonatomic, assign) NSInteger pIndex;
/** 选择的市 */
@property (nonatomic, assign) NSInteger cIndex;
/** 选择的县/区 */
@property (nonatomic, assign) NSInteger dIndex;

/** 键盘消失时，正在编辑的输入框，用来在选择日期后恢复焦点 */
@property (weak, nonatomic) UIView *curruntInputView;

/** 账单类型 */
@property (nonatomic, assign) WYHQBillType billType;
/** 账单创建时间 */
@property (nonatomic, strong) NSDate *billTime;
/** 账单所在地点 */
@property (nonatomic, copy) NSString *billCity;
@end

@implementation WYHQEditBillViewController

+ (id)targetInstance {
    return [WYHQEditBillViewController instance];
}

+ (instancetype)instance {
    return StoryBoardLoaderRoot(@"WYHQEditBillViewController");
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
    [WYHQEditBillToolBar hideEditBillToolBar];
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
    if (self.billModel) {
        WYHQBillType billType = self.billModel.s_type_id.integerValue;
        self.billType = billType;
        
        NSString *money = [self.billModel.s_money stringByReplacingOccurrencesOfString:@"-" withString:@""];
        self.momeyTextField.text = [NSString stringWithFormat:@"￥%@",[money moneyStyle]];
        
        self.noteTextField.text = self.billModel.s_desc;
        
        NSTimeInterval time = self.billModel.s_time.doubleValue;
        if (time > 0) {
            self.billTime = [NSDate dateWithTimeIntervalSince1970:time];
        } else {
            self.billTime = [NSDate date];
        }
        self.billCity = self.billModel.s_city;
        [self.cityButton setTitle:self.billCity forState:UIControlStateNormal];
        
        self.deleteButton.hidden = NO;
    } else {
        self.billTime = [NSDate date];
        
        WEAK_SELF
        [[WYHQLocation sharedInstance] location:^(NSString * _Nonnull city) {
            STRONG_SELF
            if (!StrIsEmpty(city)) {
                self.billCity = city;
                [self.cityButton setTitle:self.billCity forState:UIControlStateNormal];
                [self.cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }];
        
        self.deleteButton.hidden = YES;
    }
    
    [self.timeButton setTitle:[WYHQBillTool billTimeStringWithBillTime:self.billTime] forState:UIControlStateNormal];
    UIColor *color = [WYHQBillTool colorWithType:self.billType];
    [self setContentColor:color];
    if ([self.cityButton.currentTitle isEqualToString:@"选择城市"]) {
        [self.cityButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateNormal];
    }
}

- (void)setBillType:(WYHQBillType)billType {
    _billType = billType;
    self.billTypeLb.text = [WYHQBillTool typeNameWithIndex:billType];
}

- (void)addEditBillToolBar {
    WEAK_SELF
    [WYHQEditBillToolBar showEditBillToolBarOnSuperVC:self billType:self.billType billTime:self.billTime selectedTimeHandler:^(NSDate * _Nullable billTime) {
        STRONG_SELF
        if (billTime) {
            self.billTime = billTime;
            [self.timeButton setTitle: [WYHQBillTool billTimeStringWithBillTime:billTime] forState:UIControlStateNormal];
        }
        if (self.curruntInputView) {
            [self.curruntInputView becomeFirstResponder];
        }
    } selectedClassifyHandler:^(WYHQBillType billType) {
        STRONG_SELF
        self.billType = billType;
        [UIView animateWithDuration:0.5 animations:^{
            UIColor *color = [WYHQBillTool colorWithType:billType];
            [self setContentColor:color];
        }];
    }];
}

- (void)setContentColor:(UIColor *)color {
    self.view.backgroundColor = color;
    self.contentView.backgroundColor = color;
    self.contentScrollView.backgroundColor = color;
}

- (IBAction)saveBillButtonClick:(id)sender {
    if (StrIsEmpty(self.momeyTextField.text)) {
        [KeyWindow hj_showToastHUD:@"请输入账单金额"];
        return;
    }
    
    NSString *memey = [[self.momeyTextField.text stringByReplacingOccurrencesOfString:@"￥" withString:@""] cleanMoneyStyle];
    if (StrIsEmpty(memey)) {
        [KeyWindow hj_showToastHUD:@"请输入账单金额"];
        return;
    }
    
    if (memey.integerValue == 0) {
        [KeyWindow hj_showToastHUD:@"请输入账单金额"];
        return;
    }
    
    [self.view endEditing:YES];
    
    WYHQBillModel *model = self.billModel;
    BOOL newBill = NO;
    if (!model) {
        model = [WYHQBillModel new];
        newBill = YES;
    }
    
    model.s_money = [NSString stringWithFormat:@"-%@", memey];
    model.s_type_name = [WYHQBillTool typeNameWithIndex:self.billType];
    model.s_type_id = @(self.billType).stringValue;
    model.s_year = @(self.billTime.hj_year).stringValue;
    model.s_month = @(self.billTime.hj_month).stringValue;
    model.s_day = @(self.billTime.hj_day).stringValue;
    model.s_time = @(self.billTime.timeIntervalSince1970).stringValue;
    model.s_desc = self.noteTextField.text;
    model.s_city = self.billCity ?: @"";
    
    if (newBill) {
        // 存入数据
        [[WYHQSQLManager share] insertData:model tableName:kSQLTableName];
    } else {
        // 更新
        [[WYHQSQLManager share] updateData:model tableName:kSQLTableName];
    }
    
    [self saveBillDone];
}

- (IBAction)backButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)deletButtonClick:(id)sender {
    if (self.billModel) {
        [self.view endEditing:YES];
        WEAK_SELF
        HJAlertView *alertView = [[HJAlertView alloc] initWithTitle:@"确定要删除账单吗" message:nil cancelBlock:^{
        } confirmBlock:^{
            STRONG_SELF
            [[WYHQSQLManager share] deleteData:kSQLTableName s_id:self.billModel.s_id];
            [KeyWindow hj_showToastHUD:@"账单已删除"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [alertView show];
    }
}

- (IBAction)selectBillTime:(id)sender {
    if (self.noteTextField.isFirstResponder || self.momeyTextField.isFirstResponder) {
        [self.view endEditing:YES];
    } else {
        self.curruntInputView = nil;
    }
    
    NSString *time = [WYHQBillTool billTimeStringWithBillTime:self.billTime];
    WEAK_SELF
    [CLCustomDatePickerView showDatePickerWithTitle:@"选择时间"
                                           dateType:CLCustomDatePickerModeYMDHM
                                    defaultSelValue:time
                                            minDate:nil
                                            maxDate:nil
                                       isAutoSelect:NO
                                         themeColor:[WYHQBillTool colorWithType:self.billType]
                                        resultBlock:^(NSString *selectValue) {
                                            STRONG_SELF
                                            self.billTime = [WYHQBillTool billTimeWithBillTimeString:selectValue];
                                            [self.timeButton setTitle:selectValue forState:UIControlStateNormal];
                                            if (self.curruntInputView) {
                                                [self.curruntInputView becomeFirstResponder];
                                            }
                                        }
                                        cancelBlock:^{
                                            STRONG_SELF
                                            if (self.curruntInputView) {
                                                [self.curruntInputView becomeFirstResponder];
                                            }
                                        }];
}

- (IBAction)selectBillCity:(id)sender {
    if (self.noteTextField.isFirstResponder || self.momeyTextField.isFirstResponder) {
        [self.view endEditing:YES];
    } else {
        self.curruntInputView = nil;
    }
    
    
    HJCityPickerManager *cityPicker = [HJCityPickerManager cityPickerManagerWithTitle:@"选择城市" type:HJCityPickerTypeAll regionList:[HJCPMLocalData provinceArray] cityPickSelected:^(HJCPMProvinceModel * _Nullable selectedProvinceModel, HJCPMCityModel * _Nullable selectedCityModel, HJCPMDistrictModel * _Nullable selectedDistrictModel) {
        self.billCity = selectedDistrictModel.name;
        [self.cityButton setTitle:self.billCity forState:UIControlStateNormal];
        [self.cityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.pIndex = selectedProvinceModel.index;
        self.cIndex = selectedCityModel.index;
        self.dIndex = selectedDistrictModel.index;
    }];
    
    UIColor *color = [WYHQBillTool colorWithType:self.billType];
    [cityPicker.commitBtn setTitleColor:color forState:UIControlStateNormal];
    cityPicker.titleLabel.textColor = color;
    cityPicker.pickerViewRowSelectedTextColor = color;
    [cityPicker selecteCityWithProvinceIndex:self.pIndex cityIndex:self.cIndex districtIndex:self.dIndex animated:YES];
    [self presentViewController:cityPicker.pickerController animated:YES completion:nil];
    self.cityPicker = cityPicker;
}

- (void)keyboardWillShowNotification:(NSNotification *)noti {
    CGFloat offset = (SHeight/2) - 178 - HJ_NavigationH;
    CGFloat navHeight = HJ_NavigationH;
    if (offset < navHeight) {
        offset = navHeight;
    }
    
    [self.contentScrollView setContentInset:UIEdgeInsetsMake(0 - offset, 0, 0, 0)];
}

- (void)keyboardWillHideNotification:(NSNotification *)noti {
    [self.contentScrollView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)saveBillDone {
    
    UIColor *color = [WYHQBillTool colorWithType:self.billType];
    UIImage *image = [UIImage imageNamed:[WYHQBillTool typePressedImage:self.billType]];
    [self.saveBillButton setTitle:@"" forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.momeyTextField.textColor = color;
        self.noteTextField.textColor = color;
        [self.timeButton setTitleColor:color forState:UIControlStateNormal];
        [self.cityButton setTitleColor:color forState:UIControlStateNormal];
        self.saveBillButton.layer.borderColor = color.CGColor;
        [self.saveBillButton setImage:image forState:UIControlStateNormal];
        self.backButton.tintColor = color;
        self.deleteButton.tintColor = color;
        self.titleLabel.textColor = color;
        self.billTypeLb.textColor = color;
        
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
    self.curruntInputView = textField;
}
#pragma mark -- UINavigationControllerDelegate --

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if ([fromVC isKindOfClass:[WYHQEditBillViewController class]] &&
        [toVC isKindOfClass:[WYHQHomeViewController class]] &&
        operation == UINavigationControllerOperationPop) {
        return [WYHQTranstionAnimationPop new];
    } else {
        return nil;
    }
}

@end
