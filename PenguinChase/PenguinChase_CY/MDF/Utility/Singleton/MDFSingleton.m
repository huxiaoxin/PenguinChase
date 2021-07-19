//
//  MDFSingleton.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFSingleton.h"
#import "MDFSingletonManager.h"

@implementation MDFSingleton

+ (instancetype)sharedInstance
{
    return [[MDFSingletonManager sharedManager] sharedInstanceFor:[self class]];
}

+ (void)destorySharedInstance
{
    [[MDFSingletonManager sharedManager] destroySharedInstanceFor:[self class]];
}

- (BOOL)needsSerialProxy
{
    return NO;
}

@end
