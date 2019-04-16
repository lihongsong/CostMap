//
//  ContactHandler.h
//  Loan
//
//  Created by terrywang on 2018/12/16.
//  Copyright © 2018 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactsModel.h"

static NSString *const kErrNoContacts        = @"err_no_contacts";
static NSString *const kErrPermission        = @"err_permission";
static NSString *const kErrNoContactsText    = @"此联系人没有手机号码数据";
static NSString *const kErrPermissionText    = @"权限被拒绝";

NS_ASSUME_NONNULL_BEGIN



/**
 <#Description#>

 @param contactModel <#contactModel description#>
 @param errorMessage <#errorMessage description#>
 */
typedef void (^contactselectedCompletionBlock)(ContactsModel * _Nullable contactsModel, NSString * _Nullable errorMessage);

@interface ContactHandler : NSObject
@property (nonatomic, strong) ContactsModel *contactsModel;



/**
 <#Description#>

 @param viewController <#rootVC description#>
 @param completion <#completion description#>
 */
- (void)contactSelectWithViewController:(id)viewController completion:(_Nullable contactselectedCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
