//
//  MDFSingletonManager.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDFSingletonManager : NSObject

+ (MDFSingletonManager *)sharedManager;

- (id)sharedInstanceFor:(Class)aClass;
- (id)sharedInstanceFor:(Class)aClass category:(NSString*)key;

- (void)destroySharedInstanceFor:(Class)aClass;
- (void)destroySharedInstanceFor:(Class)aClass category:(NSString*)key;

@end

