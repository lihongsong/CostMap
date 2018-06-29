//
//  UITextView+HJInputLimit.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <UIKit/UIKit.h>

@interface UITextView (HJInputLimit)

/**
 最大的长度限制
 */
@property (assign, nonatomic) NSInteger hj_maxLength; //if <=0, no limit

@end
