//
//  DebugCollectionViewCell.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/7.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectApiDelegate<NSObject>
- (void)selectApi:(NSInteger)tag;
@end


@interface DebugCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *stateButton;
@property(nonatomic, weak)id<SelectApiDelegate>delegate;
@end
