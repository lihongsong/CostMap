//
//  DiscoverTableViewCell.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverPageModel.h"

@interface DiscoverTableViewCell : UITableViewCell

- (void)updateCellModel:(DiscoverItemModel *)itemModel;

@end
