//
//  ContactsModel.h
//  
//
//  Created by terrywang on 2018/12/16.
//  Copyright © 2018 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactsModel : NSObject

@property (nonatomic, strong) NSArray *phones;
@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
