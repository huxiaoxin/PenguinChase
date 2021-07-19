//
//  NSData+DES.h
//  ShouMi
//
//  Created by ChenYuan on 2020/6/14.
//  Copyright © 2020 lesports. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (DES)

// 3DES解密

// 加密
+ (NSString *)encryptWithText:(NSString *)sText key:(NSString *)key;
// 解密
+ (NSString *)decryptWithText:(NSString *)sText key:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
