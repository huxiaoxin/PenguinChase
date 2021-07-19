//
//  NSURLRequest+MDF.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (MDF)

- (NSURL*)mdf_url;

- (NSString *)mdf_method;

- (NSDictionary *)mdf_headers;

- (NSData *)mdf_body;

@end
