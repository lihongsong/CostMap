//
//  UITableViewCell+HJLoad.m
//  HJCategories
//
//  Created by yoser on 2017/12/15.
//

#import "UITableViewCell+HJLoad.h"

@implementation UITableViewCell (HJLoad)

+ (UINib *)hj_cellNib{
    return  [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+ (NSString *)hj_cellReuseIdentifity{
    return NSStringFromClass([self class]);
}

@end
