//
//  MDFSessionManager.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFSessionManager.h"
#import "NSMutableDictionary+MDF.h"
#import <AFNetworking/AFNetworking.h>

static NSTimeInterval const MDFRequestTimeoutForWifi = 30;
static NSTimeInterval const MDFRequestTimeoutForOther = 45;

@interface MDFSessionManager ()

@property (nonatomic, strong) NSMutableDictionary *sessionDict;

@end

@implementation MDFSessionManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sessionDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (AFHTTPSessionManager *)sessionManagerForBaseURL:(NSString *)baseUrl httpHeader:(nullable NSDictionary *)httpHeader
{
    if (!baseUrl.length) {
        return nil;
    }

    AFHTTPSessionManager *sessionManager = [self.sessionDict objectForKey:baseUrl];
    if (!sessionManager) {
        sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        sessionManager.responseSerializer.acceptableContentTypes = nil;
        
        sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        sessionManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        
        [self.sessionDict mdf_safeSetObject:sessionManager forKey:baseUrl];
    }
    
    // 请求的超时时间
    if (sessionManager.reachabilityManager.reachableViaWiFi) {
        sessionManager.requestSerializer.timeoutInterval = MDFRequestTimeoutForWifi;
    } else {
        sessionManager.requestSerializer.timeoutInterval = MDFRequestTimeoutForOther;
    }
    return sessionManager;
}

@end
