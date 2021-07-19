//
//  GNHDataModelErrorType.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/14.
//  Copyright © 2017年 GNH. All rights reserved.
//

#ifndef GNHClient_GNHDataModelErrorType_h
#define GNHClient_GNHDataModelErrorType_h

static NSUInteger const ZYDataModelErrorTypeSuccess = 0; // 成功

static NSUInteger const ZYDataModeErrorTypeError1 = 400;  // 失败
static NSUInteger const ZYDataModeErrorTypeError2 = 500;  // 失败

static NSUInteger const ZYDataModelErrorTypeLoginAgain = 401; // 重新登录，token失效

#endif
