//
//  GNHWebJSModel.h
//  GeiNiHua
//
//  Created by 吴浪 on 2018/6/15.
//  Copyright © 2018年 GNH. All rights reserved.
//

#import "GNHWebKitHeader.h"

@interface GNHWebJSModel : NSObject
@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSDictionary *info;
@property (nonatomic, copy, readonly) NSString *platform;
@property (nonatomic, copy, readonly) NSString *h5_tasksId;

+ (instancetype)webJSModelWithInfo:(NSDictionary *)info funType:(GNHWebFuncType)funType h5_tasksId:(NSString *)h5_tasksId;

@end
