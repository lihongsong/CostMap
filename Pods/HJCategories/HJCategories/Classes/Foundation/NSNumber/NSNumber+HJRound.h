//
//  NSNumber+HJRound.h
//  HJCategories
//
//  Created by yoser on 2017/12/19.
//

#import <Foundation/Foundation.h>

@interface NSNumber (HJRound)

/**
 金额样式格式化 1000 -> 1,000
 */
- (NSString*)hj_toDisplayNumberWithDigit:(NSInteger)digit;

/**
 百分数格式化 1000 -> 100000%
 */
- (NSString*)hj_toDisplayPercentageWithDigit:(NSInteger)digit;

/*　四舍五入 */
/**
 *  @brief  四舍五入
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)hj_doRoundWithDigit:(NSUInteger)digit;
/**
 *  @brief  取上整
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)hj_doCeilWithDigit:(NSUInteger)digit;
/**
 *  @brief  取下整
 *
 *  @param digit  限制最大位数
 *
 *  @return 结果
 */
- (NSNumber*)hj_doFloorWithDigit:(NSUInteger)digit;


@end
