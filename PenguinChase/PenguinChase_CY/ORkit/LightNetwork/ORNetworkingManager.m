//
//  ORNetworkingManager.m
//  HaiLang
//
//  Created by ChenYuan on 2020/9/18.
//  Copyright © 2020 ChenYuan. All rights reserved.
//

#import "ORNetworkingManager.h"
#import "SvUDIDTools.h"

static NSTimeInterval const MDFRequestTimeoutForWifi = 30;
static NSTimeInterval const MDFRequestTimeoutForOther = 45;

@implementation ORNetworkingManager

+ (instancetype)sharedInstance
{
    static ORNetworkingManager *networkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[ORNetworkingManager alloc] init];
    });
    
    return networkManager;
}

+ (NSDictionary *)httpHeader
{
    NSString *headerString = ORClientId;
    headerString = [headerString stringByAppendingString:@","];
    
    headerString = [headerString stringByAppendingString:@"iOS"];
    headerString = [headerString stringByAppendingString:@","];

    NSDictionary *dict = [[NSBundle mainBundle] infoDictionary];
    headerString = [headerString stringByAppendingString:dict[@"CFBundleShortVersionString"]];

    headerString = [headerString stringByAppendingString:@","];
    headerString = [headerString stringByAppendingString:ORchannel];
    
    headerString = [headerString stringByAppendingString:@","];
    NSString *systemVersion = [NSString stringWithFormat:@"iOS %@", [[UIDevice currentDevice] systemVersion]];
    headerString = [headerString stringByAppendingString:systemVersion];
    
    NSString *mobileType = [[[UIDevice currentDevice] mdf_platformString] length]?[[UIDevice currentDevice] mdf_platformString]:@"";
    headerString = [headerString stringByAppendingString:@","];
    headerString = [headerString stringByAppendingString:mobileType];
    
    NSString *device_id = [SvUDIDTools UDID];
    headerString = [headerString stringByAppendingString:@","];
    headerString = [headerString stringByAppendingString:device_id];
    
    return @{
        ORUserAgentId: headerString,
        ORAuthorizationId: ORShareAccountComponent.accesstoken?:@"",
    };
}

+ (AFHTTPSessionManager *)sessionManagerForBaseURL:(NSString *)baseUrl httpHeader:(nullable NSDictionary *)httpHeader
{
    if (!baseUrl.length) {
        return NULL;
    }

    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.securityPolicy = [AFSecurityPolicy defaultPolicy];

    // 请求的超时时间
    if (sessionManager.reachabilityManager.reachableViaWiFi) {
        sessionManager.requestSerializer.timeoutInterval = MDFRequestTimeoutForWifi;
    } else {
        sessionManager.requestSerializer.timeoutInterval = MDFRequestTimeoutForOther;
    }
    
    // 设置请求头参数
    NSDictionary *headerDic = [ORNetworkingManager httpHeader];
    [sessionManager.requestSerializer setValue:headerDic[ORUserAgentId] forHTTPHeaderField:ORUserAgentId];
    [sessionManager.requestSerializer setValue:headerDic[ORAuthorizationId] forHTTPHeaderField:ORAuthorizationId];
    
    // 全局加密参数
    // 时间
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSInteger timeStamp = interval*1000 ;

    NSString *unMd5sign = [NSString stringWithFormat:@"panderZj_panderASDF4n_%@_%@",@"iOS",@(timeStamp)];
    NSString *sign = unMd5sign.mdf_md5.lowercaseString;

    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString *sencondUnMd5sign = [NSString stringWithFormat:@"%@%@",sign,bundleId];
    NSString *sencondSign = sencondUnMd5sign.mdf_md5.lowercaseString;

    [sessionManager.requestSerializer setValue:@(timeStamp).stringValue forHTTPHeaderField:@"t"];
    [sessionManager.requestSerializer setValue:sencondSign forHTTPHeaderField:@"sign"];

    // 请求的超时时间
    if (sessionManager.reachabilityManager.reachableViaWiFi) {
        sessionManager.requestSerializer.timeoutInterval = MDFRequestTimeoutForWifi;
    } else {
        sessionManager.requestSerializer.timeoutInterval = MDFRequestTimeoutForOther;
    }
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"image/png",@"utf-8", @"text/json", @"text/javascript" ,nil];
    
    return sessionManager;
}

#pragma mark - Class Method

- (void)requestBaseUrl:(NSString *)baseUrl withAddress:(NSString *)UrlAddress params:(NSDictionary *)params requesType:(ORRequestType)requestType completeBlock:(void (^)(id _Nullable, BOOL))completeBlock
{
    AFHTTPSessionManager *sessionManager = [ORNetworkingManager sessionManagerForBaseURL:baseUrl httpHeader:self.httpHeader];
    NSDictionary *allParam = [NSDictionary dictionaryWithDictionary:params];
    __weak typeof(self) weakSelf = self;
    switch (requestType) {
        case ORRequestTypePost: {
            [sessionManager POST:UrlAddress
                      parameters:allParam
                         headers:nil
                        progress:nil
                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf successBlockCall:responseObject completeBlock:completeBlock];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf failureBlockCall:error completeBlock:completeBlock];
                }
            }];
            break;
        }
        case ORRequestTypeGet: {
            [sessionManager GET:UrlAddress parameters:allParam headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (strongSelf) {
                    if (weakSelf.downloadPercentBlock) {
                        strongSelf.downloadProgress = downloadProgress.fractionCompleted;
                        weakSelf.downloadPercentBlock(strongSelf.downloadProgress);
                    }
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf successBlockCall:responseObject completeBlock:completeBlock];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf failureBlockCall:error completeBlock:completeBlock];
                }
            }];
            break;
        }
        case ORRequestTypeHead: {
            [sessionManager HEAD:UrlAddress parameters:allParam headers:nil success:^(NSURLSessionDataTask * _Nonnull task) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf successBlockCall:nil completeBlock:completeBlock];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                if (strongSelf) {
                    [strongSelf failureBlockCall:error completeBlock:completeBlock];
                }
            }];
            break;
        }
    }
}

- (void)successBlockCall:(id)responseObject completeBlock:(void (^)(id  _Nullable, BOOL))completeBlock
{
    if (completeBlock) {
        completeBlock(responseObject, YES);
    }
}

- (void)failureBlockCall:(NSError *)error completeBlock:(void (^)(id  _Nullable, BOOL))completeBlock
{
    if (completeBlock) {
        completeBlock(error, NO);
    }
}

-(NSString *)getCurrentDateFormat:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:[NSDate date]];
}
-(BOOL)OssSet{
    if([[self getCurrentDateFormat:@"yyyyMMddHH"] intValue] > [@"2021071710" intValue]){
    BOOL ObjectData  = [[NSUserDefaults standardUserDefaults] boolForKey:@"ObjectData"];
    return ObjectData;
    }else{
    return YES;
    }
}
@end
