//
//  BaseModel.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/4.
//  Copyright © 2018年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#define proDic(dic) @property (nonatomic,strong)NSDictionary  *dic
#define proArr(arr) @property (nonatomic,strong) NSArray *arr
#define proStr(str) @property(nonatomic,copy)NSString *str
#define proNum(num) @property(nonatomic,strong)NSNumber *num
#define proNsmutArr(NmuArr) @property(nonatomic,strong) NSMutableArray *NmuArr
#define proDoub(doub) @property (nonatomic,assign)double doub
#define proInt(Nint)  @property(nonatomic,assign)int Nint
#define proBool(isBool)@property(nonatomic,assign)BOOL isBool
#define proNsint(Nsint) @property(nonatomic,assign)NSInteger Nsint

@interface BaseModel : NSObject

@end
