//
//  MDFSingletonSerialProxy.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//
#import <Foundation/Foundation.h>

//被代理对象的被代理函数里面不能直接访问界面元素 必须自己切换到主线程执行 因为被代理方法都在子线程执行

@interface MDFSingletonSerialProxy : NSProxy

+ (instancetype)singletonSerialProxy:(id)proxied;

@end
