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


@interface WYHQEditBillViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *momeyTextField;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet UIImageView *classifyImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabelRight;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation WYHQEditBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"记一笔";
    
    [self setupUI];
    [self updateUI];
    
    WEAK_SELF
    [WYHQEditBillToolBar showEditBillToolBarOnSuperVC:self classify:@"医疗" selectedTimeHandler:^(NSString * _Nonnull timeStr) {
        
    } selectedClassifyHandler:^(NSString * _Nonnull typeStr) {
        STRONG_SELF
        self.classifyImageView.image = [UIImage imageNamed:[WYHQBillTool getTypePressedImage:typeStr]];
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    [self.bottomView addGestureRecognizer:tap];
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
}

- (void)updateUI {
    if (self.billModel) {
        self.classifyImageView.image = [UIImage imageNamed:[WYHQBillTool getTypePressedImage:self.billModel.s_type_name]];
        self.momeyTextField.text = [NSString stringWithFormat:@"￥%@",[self.billModel.s_money moneyStyle]];
        self.noteTextView.text = self.billModel.s_desc;
        self.addressLabel.text = self.billModel.s_city;
        self.timeLabel.text = self.billModel.s_time;
        if (StrIsEmpty(self.billModel.s_city)) {
            self.timeLabelRight.constant = 0;
        } else {
            self.timeLabelRight.constant = 30;
        }
    } else {
        self.timeLabel.text = [[NSDate date] hj_stringWithFormat:@"yyyy年MM月dd日 HH:mm"];
        WEAK_SELF
        [[WYHQLocation sharedInstance] location:^(NSString * _Nonnull city) {
            STRONG_SELF
            self.addressLabel.text = city;
            if (city) {
                self.timeLabelRight.constant = 0;
            } else {
                self.timeLabelRight.constant = 30;
            }
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
@end
