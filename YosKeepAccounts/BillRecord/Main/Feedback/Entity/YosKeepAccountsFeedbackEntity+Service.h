#import "YosKeepAccountsFeedbackEntity.h"
@interface YosKeepAccountsFeedbackEntity (Service)
+ (NSURLSessionDataTask *_Nullable)requestFeedbackWithAccount:(NSString *)account
                                                 adviceString:(NSString *)adviceString
                                                   Completion:(nullable void (^)(YosKeepAccountsFeedbackEntity *_Nullable result,
                                                                                 NSError *_Nullable error))completion;
@end
