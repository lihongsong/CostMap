//
//  HomeDataModel.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "BaseModel.h"

@class CommunicationActiveModel,CredictCheckRecondModel,CredictLendRecord;
@interface HomeDataModel : NSObject

/**
 通讯活跃度
 */
@property (nonatomic,strong) NSArray <CommunicationActiveModel *>* communicationActive;

/**
 征信查询记录
 */
@property (nonatomic,strong) NSArray <CredictCheckRecondModel *>* credictCheckRecond;

/**
 信贷记录
 */
@property (nonatomic,strong) NSArray <CredictLendRecord *>* credictLendRecord;

/**
 使用率
 */
@property (nonatomic,strong) NSArray <NSString *>*credictUseRate;

/**
 使用率解读
 */
@property (nonatomic,copy) NSString *credictUseState;

/**
 信贷申请记录解读
 */
@property (nonatomic,copy) NSString *applyRecordState;
/**
 信贷记录解读
 */
@property (nonatomic,copy) NSString *lendRecordState;
/**
 通讯活跃度解读
 */
@property (nonatomic,copy) NSString *communicationState;
/**
 分
 */
@property (nonatomic,copy) NSString *creditScore;
/**
 状况，一般，良好。。。
 */
@property (nonatomic,copy) NSString *creditStatus;

/**
 评估时间
 */
@property (nonatomic,copy) NSString *evaluationTime;

/**
 信贷申请记录
 */
@property (nonatomic,strong) NSArray <NSString *>*credictApplyRecode;

/**
 通讯分布
 */
@property (nonatomic,strong) NSArray <NSString *>* communicationDistribution;
@end


@interface CommunicationActiveModel : NSObject

/**
 被叫
 */
@property (nonatomic,copy) NSString *called;

/**
 主叫
 */
@property (nonatomic,copy) NSString *calling;
@end

@interface CredictCheckRecondModel : NSObject

/**
 查询
 */
@property (nonatomic,copy) NSString *credictCardCheck;

/**
 审批
 */
@property (nonatomic,copy) NSString *approval;

/**
 贷后管理
 */
@property (nonatomic,copy) NSString *management;
@end

@interface CredictLendRecord : NSObject

/**
 次数
 */
@property(nonatomic,copy) NSString *lendCount;

/**
 次数
 */
@property (nonatomic,copy) NSString *repayCount;
@end

