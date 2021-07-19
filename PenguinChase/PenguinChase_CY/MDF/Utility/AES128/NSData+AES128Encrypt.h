//
//  NSData+AES128Encrypt.h
//  ZY
//
//  Created by 蔡儒楠 on 2018/7/19.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES128Encrypt)

// ECB加密
- (NSData *)aes128_ECBEncrypt:(NSString *)key;
// ECB解密
- (NSData *)aes128_ECBDecrypt:(NSString *)key;

// CBC加密
- (NSData *)aes128_CBCEncrypt:(NSString *)key;
// CBC解密
- (NSData *)aes128_CBCDecrypt:(NSString *)key;

// CBC NoPadding加密
- (NSData *)aes128_CBCNoPaddingEncrypt:(NSString *)key;
// CBC NoPadding解密
- (NSData *)aes128_CBCNoPaddingDecrypt:(NSString *)key;

@end
