//
//  NSString+HJMoneyConversion.h
//  HJCategories
//
//  Created by yoser on 2018/4/20.
//

#import <Foundation/Foundation.h>

@interface NSString (HJMoneyConversion)

- (NSString *)hj_fen2yuan;

- (NSString *)hj_yuan2fen;

- (NSString *)hj_fen2jiao;

- (NSString *)hj_jiao2fen;

- (NSString *)hj_jiao2yuan;

- (NSString *)hj_yuan2jiao;

@end
