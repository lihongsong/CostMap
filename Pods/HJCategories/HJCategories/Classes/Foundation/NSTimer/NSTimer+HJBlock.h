//
//  NSTimer+HJBlock.h
//  HJCategories
//
//  Created by yoser on 2017/12/18.
//

#import <Foundation/Foundation.h>

@interface NSTimer (HJBlock)

/**
 通过 block 创建定时器 兼容 ios2 以上

 @param inTimeInterval 调用间隔时间
 @param inBlock block
 @param inRepeats 是否重复
 @return 定时器
 */
+(id)hj_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval
                                 block:(void (^)(void))inBlock
                               repeats:(BOOL)inRepeats;

/**
  通过 block 创建定时器 兼容 ios2 以上

 @param inTimeInterval 调用间隔时间
 @param inBlock block
 @param inRepeats 是否重复
 @return 定时器
 */
+(id)hj_timerWithTimeInterval:(NSTimeInterval)inTimeInterval
                        block:(void (^)(void))inBlock
                      repeats:(BOOL)inRepeats;


@end
