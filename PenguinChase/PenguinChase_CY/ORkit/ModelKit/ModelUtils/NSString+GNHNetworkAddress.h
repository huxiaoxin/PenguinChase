//
//  NSString+GNHNetworkAddress.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/13.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NetworkAddress)

/**
 * api 服务器的地址
 */
+ (NSString *)gnh_httpServerHost:(GNHBaseURLType)urlType;

/**
 * H5 服务器的地址
 */
+ (NSString *)gnh_httpAppHost:(GNHBaseURLType)urlType;

/**
 * 基础业务类型地址
 */
+ (NSString *)gnh_addressWithString:(NSString *)address;

/**
 * 是否要包含Base接口
 */
+ (NSString *)gnh_addressWithString:(NSString *)address baseURLType:(GNHBaseAPIType)apiTpye;

/**
 * H5页面地址
 */
+ (NSString *)gnh_h5AddressWithString:(NSString *)address baseURLType:(GNHBaseURLType)urlTpye;

@end
