//
//  GNHBaseDataModel.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/14.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "GNHBaseDataModel.h"
#import <AFNetworking.h>
#import "SvUDIDTools.h"

typedef NS_ENUM(NSUInteger, GNHRequestLogType) {
    GNHRequestLogTypeSuccessParsed,
    GNHRequestLogTypeFailParsed,
    GNHRequestLogTypeAFNetworkingError, 
    GNHRequestLogTypeOtherError
};

@interface GNHBaseDataModel ()

@end

@implementation GNHBaseDataModel

#pragma mark - Life Cycle

- (instancetype)init
{
    if (self = [super init]) {
        _checkLogin = YES;
        _isAutoShowNetworkErrorToast = YES;
        _isAutoShowBusinessErrorToast = NO;
        _isResponseSucess = YES;
        _messageType = GNHDataModelLoadMessageTypeNormal;
        _hostType = GNHBaseURLTypeClient;
        _isShowSVProgressLoading = YES;
    }
    return self;
}

#pragma mark - Interface

- (BOOL)isServerDataCorrectAndNetworkRequestSuccess
{
    GNHRootBaseItem *baseItem = (GNHRootBaseItem *)self.parsedItem;
    if (baseItem) {
        if ([baseItem isKindOfClass:[GNHRootBaseItem class]]) {
            if (baseItem.code == ZYDataModelErrorTypeSuccess) {
                return self.isRequestSuccess;
            } else {
                return NO;
            }
        } else {
            return self.isRequestSuccess;
        }
    } else {
        if (self.isRequestSuccess) {
            if ([self.responseObject isKindOfClass:[NSDictionary class]]) {
                NSInteger code = [[self.responseObject objectForKey:@"code"] integerValue];
                if (code == 0) {
                    return YES;
                }
            } else {
                return NO;
            }
        } else {
            return NO;
        }
    }
    return NO;
}

- (void)lnterfaceLogWithSucceed:(BOOL)succeed {
#ifdef DEBUG
    NSString *status = succeed ? @"成功": @"失败";
    id baseURL = self.baseURL ?: @"nil";
    id address = self.address ?: @"nil";
    id params = self.params ?: @"nil";
    id result = succeed ? (self.responseObject ?: @"nil") : (self.error ?: @"nil");
    id header = self.requestHeader ? self.requestHeader : @"nil";
    
    NSLog(@"\n%@ 请求%@：\n域名：%@ 接口：%@\n参数：\n%@\n结果：\n%@ header：\n%@", self, status, baseURL, address, params, result, header);
#endif
}


- (NSString *)errorUserMessage
{
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        GNHRootBaseItem *item = (GNHRootBaseItem *)self.parsedItem;
        return item.msg;
    }
    return nil;
}

#pragma mark - Load

- (void)willBeginRequest
{
    if (self.isLoading) {
        NSLog(@"network is loading");
    }
    if ([self.delegate respondsToSelector:@selector(dataModelWillLoad:)]) {
        [self.delegate dataModelWillLoad:self];
    }
}

- (void)cancel
{
    [super cancel];
    if (!self.disableAutoDismiss) {
        [SVProgressHUD dismiss];
    }
}

- (BOOL)load
{
    if ([self conformsToProtocol:@protocol(GNHBaseDataModelProtocol)] && [self respondsToSelector:@selector(configBaseUrl)]) {
        id<GNHBaseDataModelProtocol> protocolItem = (id<GNHBaseDataModelProtocol>)self;
        if ([protocolItem configBaseUrl]) {
            self.baseURL = [protocolItem configBaseUrl];
        }
    } else {
        self.baseURL = [NSString gnh_httpServerHost:self.hostType];
    }
    
    return [super load];
}

#pragma mark - Request Params

+ (NSMutableDictionary *)requestHead
{
    NSMutableDictionary *commonParam = [NSMutableDictionary dictionary];
    
    // 渠道
    [commonParam mdf_safeSetObject:ORchannel forKey:@"channel"];
    return commonParam;
}

- (NSDictionary *)commonParam
{
    NSMutableDictionary *commonParam = [[self class] requestHead];
    
    return commonParam;
}

- (BOOL)enableCompleteBlock
{
    return YES;
}

- (NSDictionary *)httpHeader
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

#pragma mark - Override

- (NSDictionary *)getAutoparseObjectWithResponseObject:(NSDictionary *)dictionary
{
    NSDictionary *data = nil;
    if (self.enableEncrypt) {
        // data 解密
    } else {
       data = [dictionary objectForKey:@"data"];
    }
    
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *newDictionary = [NSMutableDictionary dictionaryWithDictionary:data];
        id code = [dictionary objectForKey:@"code"];
        [newDictionary mdf_safeSetObject:code forKey:@"code"];
        
        id message = [dictionary objectForKey:@"msg"];
        [newDictionary mdf_safeSetObject:message forKey:@"msg"];
        
        id httpStatus = [dictionary objectForKey:@"httpStatus"];
        [newDictionary mdf_safeSetObject:httpStatus forKey:@"httpStatus"];

        return newDictionary;
    }
    return dictionary;
}

- (void)handleFail
{
    if ([self.delegate respondsToSelector:@selector(networkFailNotify:)]) {
        [self.delegate networkFailNotify:self];
        self.isResponseSucess = NO;
    }
    [self collectionRequestAndResponseToDicWithType:GNHRequestLogTypeAFNetworkingError];
}

- (void)handleDataAfterParsed 
{
    self.isResponseSucess = YES;
    GNHRootBaseItem *baseItem = (GNHRootBaseItem *)self.parsedItem;
    if ([baseItem isKindOfClass:[GNHRootBaseItem class]]) {
        GNHRequestLogType logType = baseItem.code == ZYDataModelErrorTypeSuccess ? GNHRequestLogTypeSuccessParsed : GNHRequestLogTypeFailParsed;
        [self collectionRequestAndResponseToDicWithType:logType];

        if (![self filterSpecialErrorCodeWithErrorBaseItem:baseItem]) {
            // 处理特殊code值，如系统维护、强制登录等
            // code = 401 强制登录
        }
    }
    
    [super handleDataAfterParsed];
}

// 处理无法解析的数据
- (void)handleUnparsedData
{
    NSLog(@"response dict can not support %@", NSStringFromClass(self.parsedItem.class));

    if ([self.delegate respondsToSelector:@selector(parseDataError:)]) {
        [self.delegate parseDataError:self];
    }
    NSDictionary *dictionary = self.responseObject;
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        if ([dictionary objectForKey:@"code"]) {
            NSInteger errorCode = -1;
            if ([dictionary objectForKey:@"code"]) {
                errorCode = [[dictionary objectForKey:@"code"] integerValue];
            }
            
            NSString *errorMessage = [dictionary mdf_stringForKey:@"msg"];
            GNHRootBaseItem *errorItem = [[GNHRootBaseItem alloc] init];
            errorItem.code = errorCode;
            errorItem.msg = errorMessage;
            if (![self filterSpecialErrorCodeWithErrorBaseItem:errorItem]) {
                // 处理特殊code值，如系统维护、强制登录等
            }
        }
    }
    [self collectionRequestAndResponseToDicWithType:GNHRequestLogTypeOtherError];
}

- (BOOL)filterSpecialErrorCodeWithErrorBaseItem:(GNHRootBaseItem *)errorItem
{
    errorItem.hasHandledError = NO;

    NSUInteger errorCode = errorItem.code;
    if ((errorCode == ZYDataModeErrorTypeError1 || errorCode == ZYDataModeErrorTypeError2 ||
         errorCode == ZYDataModelErrorTypeLoginAgain)) {
        [SVProgressHUD dismiss];
        
        if (errorCode == ZYDataModelErrorTypeLoginAgain) {
            errorItem.msg = @"获取用户信息失败，请重新登录";
            
            // 退出登录
            [[NSNotificationCenter defaultCenter] postNotificationName:ORAccountLogoutNotification object:nil];
            
            // 强制登录
            [[NSNotificationCenter defaultCenter] postNotificationName:ORAccountForceToLoginNotification object:nil userInfo:nil];
        }
        
        errorItem.hasHandledError = YES;
        
        return YES;
    }
    
    return NO;
}

- (void)collectionRequestAndResponseToDicWithType:(GNHRequestLogType)type
{
}

#pragma mark - Request
- (AFURLSessionManager *)beforeSendRequest:(AFHTTPSessionManager *)sessionManager
{
    NSDictionary *header = [self httpHeader];
    
    if (self.requestType == MDFRequestTypePost) {
        sessionManager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    } else {
        sessionManager.requestSerializer =  [AFJSONRequestSerializer serializer];
    }
    [sessionManager.requestSerializer setValue:header[ORUserAgentId] forHTTPHeaderField:ORUserAgentId];
    [sessionManager.requestSerializer setValue:header[ORAuthorizationId] forHTTPHeaderField:ORAuthorizationId];
    
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

    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"image/png",@"utf-8", @"text/json", @"text/javascript" ,nil];
    
    
    return sessionManager;
}


#pragma mark - Properties

- (void)setParseCls:(Class)parseCls
{
    if (![parseCls isSubclassOfClass:[GNHRootBaseItem class]]) {
        NSString *assertTips;
        assertTips = [NSString stringWithFormat:@"%@ 必须为GNHRootBaseItem", NSStringFromClass(parseCls)];
        NSLog(@"%@", assertTips);
        
        return;
    }
    _parseCls = parseCls;
}

@end
