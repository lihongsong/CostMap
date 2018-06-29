//
//  HomeBaseTableViewCell.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//
#define CircleSpace 27    // 圆环间距
#define CircleHeight (SWidth - CircleSpace * 5)/4.0

#define CircleCellHeight  205 + CircleHeight

typedef NS_ENUM(NSInteger, cellType){
    CredictUseRateType,//使用率
    ApplyRecordType,// 申请记录
    LendRecordType,// 记录
    CommunicationActiveType,//通信活跃度
};



#import <UIKit/UIKit.h>
#import "HomeDataModel.h"
@interface HomeBaseTableViewCell : UITableViewCell
@property(nonatomic,assign)BOOL *isExample;
-(void)config:(HomeDataModel *)model example:(BOOL)isExample withType:(cellType)type;
@end
