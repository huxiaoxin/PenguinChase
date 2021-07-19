//
//  ORSingleton.h
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/11/3.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#import "MDFSingleton.h"
#import "GNHDataModelUtilProtocol.h"

@interface ORSingleton : MDFSingleton

@end

@interface ORSingleton (Model) <GNHDataModelUtilProtocol>

@end

