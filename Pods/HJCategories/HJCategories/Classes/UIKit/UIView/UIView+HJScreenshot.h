//
//  UIView+HJScreenshot.h
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import <UIKit/UIKit.h>

@interface UIView (HJScreenshot)

/**
 *  @brief  单纯的view截图
 *
 *  @return 截图
 */
- (UIImage *)hj_screenshot;

/**
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *
 *  @param maxWidth 限制缩放的最大宽度 保持默认传0
 *
 *  @return 截图
 */
- (UIImage *)hj_screenshot:(CGFloat)maxWidth;

@end
