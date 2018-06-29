//
//  CInvestigationProgressViewController.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CInvestigationModel.h"

typedef void(^RequestAccomplishedBlock)(void);
@interface CInvestigationProgressViewController : BaseViewController
@property(nonatomic,strong)RequestAccomplishedBlock accomplishBlock;
@property (nonatomic, strong)CInvestigationRequestModel *requestModel;
@end
