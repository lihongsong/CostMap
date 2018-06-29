//
//  SvUDIDTools.h
//  SvUDID
//
//  Created by  maple on 8/18/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import <Foundation/Foundation.h>

// replace the identity with your company's domain
static const char kKeychainUDIDItemIdentifier[]  = "UUID";
static const char kKeyChainUDIDAccessGroup[] = "YOURAPPID.com.cnblogs.smileEvday";

@interface SvUDIDTools : NSObject


/*
 * @brief obtain Unique Device Identity
 */
+ (NSString*)UDID;

+ (NSString *)getUDIDFromKeyChain;

+ (BOOL)updateUDIDInKeyChain:(NSString*)newUDID;

@end
