//
//  MineTableViewCell.h
//  HuaQianWuYou
//
//  Created by jasonzhang on 2018/5/16.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineTableViewCellDelegate
- (void)MineTableViewCellDidTapSwitch:(UISwitch *)switchView;
@end

typedef NS_ENUM(NSInteger, MineTableViewCellType) {
    MineTableViewCellType_Default,
    MineTableViewCellType_None,
    MineTableViewCellType_Switch,
};

@interface MineTableViewCell : UITableViewCell
@property(nonatomic, weak) id <MineTableViewCellDelegate> delegate;

- (void)updateCellInfo:(NSDictionary *)info;

@end
