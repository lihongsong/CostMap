//
//  CInvestigationViewController.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CInvestigationModel.h"
@interface CInvestigationViewController : BaseViewController
@property (nonatomic, strong)CInvestigationRequestModel *requestModel;
@property(nonatomic, strong) UITextField *firstTF;
@property(nonatomic, strong) UITextField *secondTF;
@property(nonatomic, strong) UITextField *thirdTF;
@property(nonatomic, strong) UIButton *bottomBtn;

@property(nonatomic, strong) NSArray *dataArray;

- (void)bottomButtonAction;

- (void)showThridTF;

- (void)setAlert:(NSString*)title;

- (BOOL)string:(NSString *)string isValidWithRegex:(NSString *)regexString;


/**
 如果需要右上角显示位置信息，则调用此方法
 */
- (void)initLocationService;
@end
