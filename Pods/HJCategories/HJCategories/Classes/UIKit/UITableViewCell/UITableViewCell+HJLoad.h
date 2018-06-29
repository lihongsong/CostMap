//
//  UITableViewCell+HJLoad.h
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (HJLoad)

/**
 加载与类名相同的 CellNib 文件
 
 @return cell对应的NIB
 */
+ (UINib *)hj_cellNib;

/**
 加载与类名相同的 CellReuseIdentifity 文件

 @return cell对应的Identifity
 */
+ (NSString *)hj_cellReuseIdentifity;

@end
