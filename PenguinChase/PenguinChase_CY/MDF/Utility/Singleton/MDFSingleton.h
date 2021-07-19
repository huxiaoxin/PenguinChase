//
//  MDFSingleton.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <Foundation/Foundation.h>

#undef	DECLARE_SINGLETON
#define DECLARE_SINGLETON( __class ) \
    + (__class *)sharedInstance;

#undef	DEFINE_SINGLETON
#define DEFINE_SINGLETON( __class ) \
        + (__class *)sharedInstance \
        { \
            static dispatch_once_t once; \
            static __class * __singleton__; \
            dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
            return __singleton__; \
        }

@interface MDFSingleton : NSObject

+ (instancetype)sharedInstance;
+ (void)destorySharedInstance;
- (BOOL)needsSerialProxy;

@end
