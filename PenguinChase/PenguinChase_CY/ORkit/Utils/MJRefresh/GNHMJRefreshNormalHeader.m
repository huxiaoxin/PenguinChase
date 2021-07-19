//
//  GNHMJRefreshNormalHeader.m
//  ShouMi
//
//  Created by ChenYuan on 2020/6/28.
//  Copyright © 2020 lesports. All rights reserved.
//

#import "GNHMJRefreshNormalHeader.h"

@implementation GNHMJRefreshNormalHeader

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    self.lastUpdatedTimeLabel.hidden = YES;
}


@end
