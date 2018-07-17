//
//  UnClickProductModel.h
//  HuaQianWuYou
//
//  Created by 2345 on 2018/7/11.
//  Copyright © 2018年 2345. All rights reserved.
//

#import "BaseModel.h"
@class ProductInfo;

@interface UnClickProductModel : BaseModel
//@property(nonatomic,strong)NSArray<ProductInfo *> *productCategoryVO;
@end

@interface ProductInfo : NSObject

/**
 H5跳转路径
 */
@property(nonatomic, copy) NSString *address;

/**
 办理流程
 */
@property(nonatomic, copy) NSString *applyFlow;

/**
 申请说明
 */
@property(nonatomic, copy) NSString *applyTips;

/**
 件均金额
 */
@property(nonatomic, strong) NSNumber *averagePrice;

/**
 渠道编号
 */
@property(nonatomic, strong) NSNumber *channelId;

/**
 优惠金额/内容
 */
@property(nonatomic, copy) NSString *couponContent;

/**
 优惠券名称
 */
@property(nonatomic, copy) NSString *couponName;
/**
 小花提示
 */
@property(nonatomic, copy) NSString *detailPrompt;
/**
 期限
 */
@property(nonatomic, copy) NSString *duration;
/**
 期限类型
 */
@property(nonatomic, strong) NSNumber *durationType;
/**
 产品id
 */
@property(nonatomic, strong) NSNumber *id;
/**
 额度
 */
@property(nonatomic, copy) NSString *limit;
/**
 放*款*时*间
 */
@property(nonatomic, copy) NSString *loanTime;
/**
 
 */
@property(nonatomic, copy) NSString *logo;
/**
产品名称
*/
@property(nonatomic, copy) NSString *name;
/**
参考通过率
*/
@property(nonatomic, copy) NSString *passRate;
/**
特别提示
*/
@property(nonatomic, copy) NSString *prompt;
/**
 利率
*/
@property(nonatomic, copy) NSString *rate;
/**
利率类型
*/
@property(nonatomic, strong) NSNumber *rateType;
/**
优惠券副标题
*/
@property(nonatomic, copy) NSString *subCouponName;
/**
副标题
 */
@property(nonatomic, copy) NSString *subhead;
/**
标签色号
*/
@property(nonatomic, copy) NSString *tagColor;

/**
 产品标签（非特色标签
 */
@property(nonatomic, copy) NSString *tagName;
@end
