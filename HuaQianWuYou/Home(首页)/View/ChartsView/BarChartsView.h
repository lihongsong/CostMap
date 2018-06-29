//
//  BarChartsView.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/10.
//  Copyright © 2018年 jason. All rights reserved.
//

#import "ChartsBaseView.h"
#define Title  @"title"
#define DataNumber  @"data"
#define State  @"state"

@interface BarChartsView : ChartsBaseView
@property(nonatomic,strong)NSArray *chartsData;
@property(nonatomic,strong)NSArray *chartsData2;
//example:  几组数据，几等份
//  @[
//  @{@"title":@"Party A",@"data":@"25",@"state":@"住房",},
//  @{@"title":@"Party B",@"data":@"35",@"state":@"吃饭",},
//  @{@"title":@"Party C",@"data":@"40",@"state":@"玩"}
//];
// 后面方法会添加 %
#pragma mark 更新数据
-(void)refreshData;
@end
