//
//  UITextField+HJInputLimit.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <UIKit/UIKit.h>

@interface UITextField (HJInputLimit)

/**
 字数限制 default 0 if <=0, no limit 可以在 xib 上操作
 */
@property (assign, nonatomic) IB_DESIGNABLE NSInteger hj_maxLength;

/**
 
 插入空格的位置 比如 @[@3,@7] : 123 4567 8910
 
 hj_sdk_fix_me: 重新赋值后光标偏移的问题
 
 */
@property (strong, nonatomic) NSArray <NSNumber *> *spaceIndex;

@end
