//
//  MDFObserverManger.h
//  GeiNiHua
//
//  Created by ChenYuan on 2017/10/27.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDFSingleton.h"

typedef void(^MDFComponet)(NSDictionary<NSKeyValueChangeKey,id> *change);
@interface MDFObserverManger : MDFSingleton
+ (void)subscribeToObjc:(NSObject *)objc serveOfKeyPath:(NSString *)keyPath componet:(MDFComponet)componet;
+ (void)unsbscribeToObjc:(NSObject *)objc serveOfKeyPath:(NSString *)keyPath;
@end
