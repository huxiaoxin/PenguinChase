//
//  GNHDataModelUtilProtocol.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/14.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GNHBaseDataModel.h"

@protocol GNHDataModelUtilProtocol <NSObject>

@required

// 生产和配置model
- (__kindof GNHBaseDataModel *)produceModel:(Class)modelClass;

//请求成功
- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel;

//请求失败
- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel;

@end
