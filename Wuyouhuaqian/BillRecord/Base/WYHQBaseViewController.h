//
//  WYHQBaseViewController.h
//  WYHQ
//
//  Created by Rainy on 16/5/25.
//  Copyright © 2016年 JiKeLoan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LNImageInfo;

@interface WYHQBaseViewController : UIViewController

/**
 *	@brief	设置视图控制器的leftBarButtonItemWithImage
 *
 *	@param 	image   图片
 *	@param 	tar     事件响应对象
 *	@param 	act     sel事件
 */
- (void)setupCustomLeftWithImage:(UIImage *)image target:(id)tar action:(SEL)act;


/**
 *	@brief	设置视图控制器的rightBarButtonItemWithImage
 *
 *	@param 	image   图片
 *	@param 	tar     事件响应对象
 *	@param 	act     sel事件
 */
- (void)setupCustomRightWithImage:(UIImage *)image target:(id)tar action:(SEL)act;

/**
 *	@brief	设置视图控制器的rightBarButtonItemWithTitle
 *
 *	@param 	title   标题
 *	@param 	tar     事件响应对象
 *	@param 	act     sel事件
 */
- (void)setupCustomRightWithtitle:(NSString *)title attributes:(NSDictionary<NSAttributedStringKey, id> *)attrs target:(id)tar action:(SEL)act;

@end
