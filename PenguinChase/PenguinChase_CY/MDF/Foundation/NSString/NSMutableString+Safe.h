//
//  NSMutableString+Safe.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (Safe)

- (void)mdf_safeAppendString:(NSString *)str;

@end
