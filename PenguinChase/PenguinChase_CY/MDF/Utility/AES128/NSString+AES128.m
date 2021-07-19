//
//  NSString+AES128.m
//  ZY
//
//  Created by 蔡儒楠 on 2018/7/19.
//  Copyright © 2018年 ZY. All rights reserved.
//

#import "NSString+AES128.h"
#import "NSData+AES128Encrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

@implementation NSString (AES128)

// 加密
- (NSString *)aes128_encrypt:(NSString *)key Mode:(ZYEncryptMode)encryptMode
{
    if ([NSString mdf_isEmptyString:key]) return @"";
    
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *originData = [NSData dataWithBytes:cstr length:self.length];
    
    NSData *resultData;
    if (encryptMode == ZYEncryptModeCBC) {
        resultData = [originData aes128_CBCEncrypt:key];
    } else {
        resultData = [originData aes128_ECBEncrypt:key];
    }
    
    if (resultData) {
        return [GTMBase64 stringByEncodingData:resultData];
    } else {
        return @"";
    }
}

// 解密
- (NSString *)aes128_decrypt:(NSString *)key Mode:(ZYEncryptMode)decryptMode
{
    if ([NSString mdf_isEmptyString:key]) return @"";
    
    NSData *originData = [GTMBase64 decodeData:[self dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *resultData;
    if (decryptMode == ZYEncryptModeCBC) {
        resultData = [originData aes128_CBCDecrypt:key];
    } else {
        resultData = [originData aes128_ECBDecrypt:key];
    }
    
    if (resultData) {
        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    } else {
        return @"";
    }
}

@end
