//
//  MDFSessionManager.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFSingleton.h"

@class AFHTTPSessionManager;

@interface MDFSessionManager : MDFSingleton

- (nullable AFHTTPSessionManager *)sessionManagerForBaseURL:(nullable NSString *)baseUrl httpHeader:(nullable NSDictionary *)httpHeader;

@end
