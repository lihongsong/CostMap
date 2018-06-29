//
//  CInvestigationResultViewController.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/17.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, CInvestigationResultType) {
    CInvestigationResultType_Fail,
    CInvestigationResultType_Success,
};

@interface CInvestigationResultViewController : BaseViewController
@property(nonatomic, assign) CInvestigationResultType resultType;

@end
