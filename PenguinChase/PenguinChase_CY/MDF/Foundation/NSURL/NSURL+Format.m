//
//  NSURL+Format.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "NSURL+Format.h"
#import "NSString+Utility.h"

@implementation NSURL (Format)

+ (instancetype)mdf_URLWithString:(NSString *)URLString
{
    NSString *formatString = URLString.mdf_stringByTrimingWhitespaceOrNewlineCharacter;
    return [NSURL URLWithString:formatString?:@""];
}

@end
