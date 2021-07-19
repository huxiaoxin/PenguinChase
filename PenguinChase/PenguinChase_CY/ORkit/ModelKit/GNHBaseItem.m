//
//  GNHBaseItem.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/14.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "GNHBaseItem.h"

@implementation GNHBaseItem

- (instancetype)init
{
    if (self = [super init]) {
        _cellHeight = -1;
    }
    return self;
}

@end

@implementation GNHRootBaseItem

- (instancetype)init
{
    if (self = [super init]) {
        _code = -1;
    }
    return self;
}

@end




