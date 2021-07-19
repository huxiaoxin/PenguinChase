//
//  NSString+AES128.h
//  ZY
//
//  Created by 蔡儒楠 on 2018/7/19.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ZYEncryptMode) {
    ZYEncryptModeECB, // ECB模式
    ZYEncryptModeCBC, // CBC模式
    ZYEncryptModeCBCNoPadding, // CBC NoPadding模式
};

@interface NSString (AES128)

// 加密
- (NSString *)aes128_encrypt:(NSString *)key Mode:(ZYEncryptMode)encryptMode;
// 解密
- (NSString *)aes128_decrypt:(NSString *)key Mode:(ZYEncryptMode)decryptMode;

@end
