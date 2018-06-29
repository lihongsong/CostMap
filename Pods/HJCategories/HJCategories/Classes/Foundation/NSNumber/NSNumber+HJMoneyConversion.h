//
//  NSNumber+HJMoneyConversion.h
//  HJCategories
//
//  Created by yoser on 2018/4/20.
//

#import <Foundation/Foundation.h>

@interface NSNumber (HJMoneyConversion)

- (NSNumber *)hj_fen2yuan;

- (NSNumber *)hj_yuan2fen;

- (NSNumber *)hj_fen2jiao;

- (NSNumber *)hj_jiao2fen;

- (NSNumber *)hj_jiao2yuan;

- (NSNumber *)hj_yuan2jiao;

@end
