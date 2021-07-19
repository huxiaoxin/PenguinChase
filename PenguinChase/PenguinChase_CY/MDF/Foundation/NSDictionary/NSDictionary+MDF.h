//
//  NSDictionary+MDF.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDictionary (MDF)

//url转字符串
- (NSString *)mdf_urlEncodedKeyValueString;
//json转字符串
- (NSString *)mdf_jsonEncodedKeyValueString;
- (NSString *)mdf_jsonEncodedKeyValueStringOptions:(NSJSONWritingOptions)opt;
//plist转字符串
- (NSString *)mdf_plistEncodedKeyValueString;

// NSDictionary 按key排序 value按“|”分割
- (NSString *)mdf_signWithKeyOrder;

- (NSString *)mdf_stringForKey:(id)key;
- (NSNumber *)mdf_numberForKey:(id)key;

// 返回http request (如 {user_id:123456,user_name:gnh} 转成 user_id=123456&user_name=gnh)
- (NSString *)mdf_httpRequestBody;

// 递归遍历打印 NSDictionary key value 可显示中文
- (NSString *)mdf_description;

@end

