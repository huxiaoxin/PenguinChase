//
//  LYSignalHandler.h
//  99fenqi
//
//  Created by ChenYuan on 16/5/13.
//  Copyright © 2016年 dingli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

/** 请配置BUG收集者的 Mail */
#define DEVELOPER_MAIL @"sishuilingxiu@163.com"

@interface LYSignalHandler : NSObject

singleton_interface(LYSignalHandler;)
/** 注册捕获信号的方法 */
+ (void)registerSignalHandler;
+ (void)setDefaultHander;

@end
