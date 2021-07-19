//
//  GNHDataHeader.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/15.
//  Copyright © 2017年 GNH. All rights reserved.
//

#ifndef GNHDataHeader_h
#define GNHDataHeader_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GNHDataHasMore) {
    GNHDataHasMoreNoAlpha = 0, /**< 没有更多 (alpha)*/
    GNHDataHasMoreYES = 1,     /**< 还有更多*/
    GNHDataHasMoreNO = 2       /**< 没有更多*/
};

typedef NS_ENUM(NSUInteger, GNHBaseURLType) {
    GNHBaseURLTypeClient,        // 业务
};

typedef NS_ENUM(NSUInteger, GNHBaseAPIType) {
    GNHBaseAPITypeUnknow = 0,
    GNHBaseAPITypeAPI,
    GNHBaseAPITypeOrder,
};

#endif /* GNHDataHeader_h */
