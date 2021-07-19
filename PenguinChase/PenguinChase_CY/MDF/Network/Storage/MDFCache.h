//
//  MDFCache.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "TMCache.h"

@interface MDFCache : TMCache

+ (instancetype)sharedCache;
+ (instancetype)sharedImageCache;

@end
