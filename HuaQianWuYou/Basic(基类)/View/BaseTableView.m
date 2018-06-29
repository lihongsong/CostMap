//
//  BaseTableView.m
//  HuaQianWuYou
//
//  Created by jason on 2018/5/4.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if ([self.delegate respondsToSelector:@selector(tableView:touchesBegan:withEvent:)]) {
        [self.delegate tableView:self touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    if ([self.delegate respondsToSelector:@selector(tableView:touchesMoved:withEvent:)]) {
        [self.delegate tableView:self touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if ([self.delegate respondsToSelector:@selector(tableView:touchesEnded:withEvent:)]) {
        [self.delegate tableView:self touchesEnded:touches withEvent:event];
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if ([self.delegate respondsToSelector:@selector(tableView:changeFrame:)]) {
        [self.delegate tableView:self changeFrame:self.frame];
    }
}

@end
