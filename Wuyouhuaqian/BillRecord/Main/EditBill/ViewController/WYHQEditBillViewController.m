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

@interface WYHQEditBillViewController () <UITextFieldDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *momeyTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *saveBillButton;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

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

- (void)endEditing {
    [self.view endEditing:YES];
}

- (void)setupUI {
    
    self.momeyTextField.hj_maxLength = 10;
    self.noteTextField.hj_maxLength = 30;
    
    self.momeyTextField.attributedPlaceholder =  [[NSAttributedString alloc] initWithString:@"¥ 0.00" attributes:@{NSForegroundColorAttributeName:HJHexColor(k0xcccccc), NSFontAttributeName: [UIFont boldSystemFontOfSize:30]}];
    self.noteTextField.attributedPlaceholder =  [[NSAttributedString alloc] initWithString:@"备注" attributes:@{NSForegroundColorAttributeName:HJHexColor(k0xcccccc), NSFontAttributeName: [UIFont boldSystemFontOfSize:18]}];
    
    self.momeyTextField.delegate = self;
    self.noteTextField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    [self.contentView addGestureRecognizer:tap];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.title;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = UIColor.whiteColor;
    self.navigationItem.titleView = titleLabel;
    
    UIImage *backImage = [[UIImage imageNamed:@"nav_btn_back_default"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.backButton setImage:backImage forState:UIControlStateNormal];
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
        self.timeLabel.text = [WYHQBillTool billTimeStringWithBillTime:self.billTime];
        
        self.addressLabel.text = self.billModel.s_city;
    } else {
        self.billTime = [NSDate date];
        self.timeLabel.text = [WYHQBillTool billTimeStringWithBillTime:self.billTime];
        WEAK_SELF
        [[WYHQLocation sharedInstance] location:^(NSString * _Nonnull city) {
            STRONG_SELF
            self.billCity = city;
            self.addressLabel.text = city;
        }];
    }
    
    UIColor *color = [WYHQBillTool colorWithType:self.billType];
    [self setContentColor:color];
}

- (void)addEditBillToolBar {
    WEAK_SELF
    [WYHQEditBillToolBar showEditBillToolBarOnSuperVC:self billType:self.billType billTime:self.billTime selectedTimeHandler:^(NSDate * _Nullable billTime) {
        STRONG_SELF
        if (billTime) {
            self.billTime = billTime;
            self.timeLabel.text = [WYHQBillTool billTimeStringWithBillTime:billTime];
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
        return;
    }
    
    NSString *memey = [[self.momeyTextField.text stringByReplacingOccurrencesOfString:@"￥" withString:@""] cleanMoneyStyle];
    if (StrIsEmpty(memey)) {
        return;
    }
    
    if (memey.integerValue == 0) {
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
    model.s_city = self.billCity;
    
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

- (void)saveBillDone {
    
    UIColor *color = [WYHQBillTool colorWithType:self.billType];
    UIImage *image = [UIImage imageNamed:[WYHQBillTool typePressedImage:self.billType]];
    [self.saveBillButton setTitle:@"" forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.momeyTextField.textColor = color;
        self.noteTextField.textColor = color;
        self.timeLabel.textColor = color;
        self.addressLabel.textColor = color;
        self.saveBillButton.layer.borderColor = color.CGColor;
        [self.saveBillButton setImage:image forState:UIControlStateNormal];
        self.backButton.tintColor = color;
        self.titleLabel.textColor = color;
        
        [self setContentColor:UIColor.whiteColor];
        self.momeyTextField.attributedPlaceholder =  [[NSAttributedString alloc] initWithString:@"¥ 0.00" attributes:@{NSForegroundColorAttributeName:UIColor.whiteColor, NSFontAttributeName: [UIFont boldSystemFontOfSize:30]}];
        self.noteTextField.attributedPlaceholder =  [[NSAttributedString alloc] initWithString:@"备注" attributes:@{NSForegroundColorAttributeName:UIColor.whiteColor, NSFontAttributeName: [UIFont boldSystemFontOfSize:18]}];
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
