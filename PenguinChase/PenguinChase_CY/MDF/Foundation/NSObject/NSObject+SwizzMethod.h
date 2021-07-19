//
//  NSObject+SwizzMethod.h
//  反欺诈埋点model
//
//  Created by tanxk on 2017/10/18.
//  Copyright © 2017年 51信用卡. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SwizzMethod)
/// 交换两个方法的实现
+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;
@end
