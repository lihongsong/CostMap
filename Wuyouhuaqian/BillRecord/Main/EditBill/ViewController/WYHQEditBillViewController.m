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

@interface WYHQEditBillViewController () <UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *momeyTextField;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet UIImageView *classifyImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabelRight;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"记一笔";
    
    [self setupUI];
    [self updateUI];
    [self addEditBillToolBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [[self navigationController] setDelegate:self];
}

- (void)endEditing {
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [WYHQEditBillToolBar hideEditBillToolBar];
}

- (void)setupUI {
    
    self.momeyTextField.hj_maxLength = 10;
    self.momeyTextField.delegate = self;
    [self.noteTextView hj_addPlaceHolder:@"备注"];
    self.noteTextView.hj_placeHolderTextView.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    self.timeLabelRight.constant = 0;
    
    self.momeyTextField.delegate = self;
    self.noteTextView.delegate = self;
    
    [self setupCustomRightWithImage:[UIImage imageNamed:@"nav_btn_save_default"] target:self action:@selector(saveBill)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    [self.bottomView addGestureRecognizer:tap];
}

- (void)updateUI {
    if (self.billModel) {
        WYHQBillType billType = self.billModel.s_type_id.integerValue;
        self.billType = billType;
        
        self.classifyImageView.image = [UIImage imageNamed:[WYHQBillTool typePressedImage:billType]];
        
        NSString *money = [self.billModel.s_money stringByReplacingOccurrencesOfString:@"-" withString:@""];
        self.momeyTextField.text = [NSString stringWithFormat:@"￥%@",[money moneyStyle]];
        
        self.noteTextView.text = self.billModel.s_desc;
        
        NSTimeInterval time = self.billModel.s_time.doubleValue;
        if (time > 0) {
            self.billTime = [NSDate dateWithTimeIntervalSince1970:time];
        } else {
            self.billTime = [NSDate date];
        }
        self.timeLabel.text = [WYHQBillTool billTimeStringWithBillTime:self.billTime];
        
        self.addressLabel.text = self.billModel.s_city;
        if (StrIsEmpty(self.billModel.s_city)) {
            self.timeLabelRight.constant = 0;
        } else {
            self.timeLabelRight.constant = 30;
        }
    } else {
        self.billTime = [NSDate date];
        self.timeLabel.text = [WYHQBillTool billTimeStringWithBillTime:self.billTime];
        WEAK_SELF
        [[WYHQLocation sharedInstance] location:^(NSString * _Nonnull city) {
            STRONG_SELF
            self.billCity = city;
            self.addressLabel.text = city;
            if (city) {
                self.timeLabelRight.constant = 0;
            } else {
                self.timeLabelRight.constant = 30;
            }
        }];
    }
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
        self.classifyImageView.image = [UIImage imageNamed:[WYHQBillTool typePressedImage:billType]];
    }];
}

- (void)saveBill {
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
    model.s_desc = self.noteTextView.text;
    model.s_city = self.billCity;
    
    if (newBill) {
        // 存入数据
        [[WYHQSQLManager share] insertData:model tableName:kSQLTableName];
    } else {
        // 更新
        [[WYHQSQLManager share] updateData:model tableName:kSQLTableName];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
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
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.curruntInputView = textField;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.curruntInputView = textView;
}

#pragma mark -- UINavigationControllerDelegate --

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        return [WYHQTranstionAnimationPop new];
    }else{
        return nil;
    }
}

@end
