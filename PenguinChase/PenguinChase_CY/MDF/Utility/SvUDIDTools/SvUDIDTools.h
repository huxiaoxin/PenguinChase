//
//  SvUDIDTools.h
//  SvUDID
//
//  Created by  maple on 8/18/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kSvNull;

@interface SvUDIDTools : NSObject

/*
 * @brief obtain Unique Device Identity
 */
+ (NSString*)UDID;
+ (NSString *)keyChainUDIDAccessGroup;

@end
