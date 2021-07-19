//
//  NSMutableString+Safe.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "NSMutableString+Safe.h"

@implementation NSMutableString (Safe)

- (void)mdf_safeAppendString:(NSString *)str
{
    if (str.length) {
        [self appendString:str];
    }
}

@end
