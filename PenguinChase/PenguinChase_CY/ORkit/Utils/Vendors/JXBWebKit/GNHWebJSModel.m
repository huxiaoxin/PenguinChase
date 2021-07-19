//
//  GNHWebJSModel.m
//  GeiNiHua
//
//  Created by 吴浪 on 2018/6/15.
//  Copyright © 2018年 GNH. All rights reserved.
//

#import "GNHWebJSModel.h"
#import "GNHWebModel.h"

@implementation GNHWebJSModel

- (instancetype)initWithInfo:(NSDictionary *)info funType:(GNHWebFuncType)funType platform:(NSString *)platform h5_tasksId:(NSString *)h5_tasksId {
    if (self = [super init]) {
        _type = [[GNHWebModel webFuncType:funType] copy];
        _info = info;
        _platform = [platform copy];
        _h5_tasksId = [h5_tasksId copy];
    }
    return self;
}

+ (instancetype)webJSModelWithInfo:(NSDictionary *)info funType:(GNHWebFuncType)funType h5_tasksId:(NSString *)h5_tasksId {
    return [[self alloc] initWithInfo:info funType:funType platform:@"iOS" h5_tasksId:h5_tasksId];
}

@end
