//
//  MDFBaseDataModel.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFBaseDataModel.h"
#import "MDFSessionManager.h"
#import "MDFBaseItem.h"
#import "NSURLRequest+MDF.h"
#import "NSDictionary+MDF.h"
#import "NSMutableDictionary+MDF.h"
#import "NSString+Utility.h"
#import "MDFCache.h"
#import "NSMutableArray+MDF.h"
#import <AFNetworking/AFNetworking.h>

@interface MDFBaseDataModel ()

@property (nonatomic, strong) MDFFileUploadItem *fileParam;
@property (nonatomic, copy) MDFDataUploadBlock uploadPercentBlock; //显示百分比

// 网络请求
@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;

// 返回数据对象
@property (nonatomic, strong) id responseObject;

@property (nonatomic, copy) dispatch_block_t innerLoadSuccessBlock;
@property (nonatomic, strong) NSMutableDictionary *flagForUsedCacheDic;

@end

@implementation MDFBaseDataModel

- (void)dealloc
{
    [_sessionDataTask cancel];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestType = MDFRequestTypePost;
        self.enableCommonParam = YES;
    }
    return self;
}

// 取消加载
- (void)cancel
{
    self.state = MDFBaseModelStateCancel;
    self.completionBlock =  nil;
    self.uploadPercentBlock = nil;
    [self.sessionDataTask cancel];
    self.sessionDataTask = nil;
}

- (void)successBlockCall:(id)responseObject
{
    self.error = nil;
    self.responseObject = responseObject;
    [self _onNetworkSuccess];
}

- (void)failureBlockCall:(NSError *)error
{
    if (--self.retryCount > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self load];
        });
    } else {
        self.error = error;
        [self _onNetworkFail];
    }
}

- (BOOL)load
{
    self.innerLoadSuccessBlock = nil;
    
    if (!self.address) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _onNetworkFail];
        });
        return NO;
    }
    
    return [self loadServerDataWithPolicy];
}

- (BOOL)loadServerDataWithPolicy
{
    self.isLastLoadDataFail = NO;
    
    [self willBeginRequest];
    
    if (self.error) {
        self.error = nil;
    }
    
    self.responseObject = nil;
    _parsedItem = nil;
    
    [self.sessionDataTask cancel];
    self.sessionDataTask = nil;
    
    NSDictionary *allParam = [self allParams];

    __weak typeof(self) weakSelf = self;
    self.state = MDFBaseModelStateLoading;
    
    AFHTTPSessionManager *sessionManager = [[MDFSessionManager sharedInstance] sessionManagerForBaseURL:self.baseURL httpHeader:[self httpHeader]];
    if (self.requestTimeout) {
        sessionManager.requestSerializer.timeoutInterval = self.requestTimeout;
    }
    sessionManager = [self beforeSendRequest:sessionManager];
    NSAssert(sessionManager != nil, @"sessionManager should not be nil");

    if (!self.fileParam) {
        switch (self.requestType) {
            case MDFRequestTypePost: {
                if (self.requestBodyType) {
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.params[@"params"]
                                                                       options:NSJSONWritingPrettyPrinted  error:nil];
                    NSString *url = [self.baseURL stringByAppendingString:self.address];
                    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
                    // 设置"Content-Type"类型 json类型跟后台一致
                    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                    [request setHTTPBody:jsonData];
                    NSDictionary *header = [self httpHeader];
                    [request setValue:header[ORUserAgentId] forHTTPHeaderField:ORUserAgentId];
                    [request setValue:header[ORAuthorizationId] forHTTPHeaderField:ORAuthorizationId];
                    
                    // 全局加密参数
                    // 时间
                    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
                    NSInteger timeStamp = interval*1000 ;

                    NSString *unMd5sign = [NSString stringWithFormat:@"panderZj_panderASDF4n_%@_%@",@"iOS",@(timeStamp)];
                    NSString *sign = unMd5sign.mdf_md5.lowercaseString;

                    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
                    NSString *sencondUnMd5sign = [NSString stringWithFormat:@"%@%@",sign,bundleId];
                    NSString *sencondSign = sencondUnMd5sign.mdf_md5.lowercaseString;

                    [request setValue:@(timeStamp).stringValue forHTTPHeaderField:@"t"];
                    [request setValue:sencondSign forHTTPHeaderField:@"sign"];
                    
                    self.sessionDataTask = [sessionManager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
                        
                    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                        __strong typeof(weakSelf) strongSelf = weakSelf;
                        if (strongSelf) {
                            if (error) {
                                [strongSelf failureBlockCall:error];
                            } else {
                                [strongSelf successBlockCall:responseObject];
                            }
                        }
                    }];
                    [self.sessionDataTask resume];
                } else {
                    self.sessionDataTask = [sessionManager POST:self.address
                                                     parameters:allParam
                                                        headers:nil
                                                       progress:nil
                                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        __strong typeof(weakSelf) strongSelf = weakSelf;
                        if (strongSelf) {
                            strongSelf.responseHeader = ((NSHTTPURLResponse *)task.response).allHeaderFields;
                            [strongSelf successBlockCall:responseObject];
                        }
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        __strong typeof(weakSelf) strongSelf = weakSelf;
                        if (strongSelf) {
                            [strongSelf failureBlockCall:error];
                        }
                    }];
                }
                
                break;
            }
            case MDFRequestTypeGet: {
                self.sessionDataTask = [sessionManager GET:self.address
                                                parameters:self.params
                                                  headers:nil
                                                 progress:^(NSProgress * _Nonnull downloadProgress) {
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
                                                        strongSelf.requestHeader = ((NSHTTPURLResponse *)task.response).allHeaderFields;
                                                        [strongSelf successBlockCall:responseObject];
                                                    }
                                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                    __strong typeof(weakSelf) strongSelf = weakSelf;
                                                    if (strongSelf) {
                                                        [strongSelf failureBlockCall:error];
                                                    }
                                                }];
                break;
            }
            case MDFRequestTypeHead: {
                self.sessionDataTask = [sessionManager HEAD:self.address
                                                 parameters:self.params                                                   headers:nil success:^(NSURLSessionDataTask * _Nonnull task) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    if (strongSelf) {
                        strongSelf.requestHeader = ((NSHTTPURLResponse *)task.response).allHeaderFields;
                        [strongSelf successBlockCall:nil];
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    if (strongSelf) {
                        [strongSelf failureBlockCall:error];
                    }
                }];
                break;
            }
        }
    } else {
        self.sessionDataTask = [sessionManager POST:self.address
                                         parameters:allParam
                                            headers:nil
                          constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                              __strong typeof(weakSelf) strongSelf = weakSelf;
                              [strongSelf constructBody:formData];
                          } progress:^(NSProgress * _Nonnull uploadProgress) {
                              if (weakSelf.uploadPercentBlock) {
                                  CGFloat percent = uploadProgress.fractionCompleted * 100;
                                  weakSelf.uploadPercentBlock(percent);
                              }
                          } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              __strong typeof(weakSelf) strongSelf = weakSelf;
                              if (strongSelf) {
                                  [strongSelf successBlockCall:responseObject];
                              }
                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                              __strong typeof(weakSelf) strongSelf = weakSelf;
                              if (strongSelf) {
                                  [strongSelf failureBlockCall:error];
                              }
                          }];
    }
    
    [self didSendRequest];
    return YES;
}

- (void)constructBody:(id<AFMultipartFormData> )formData
{
    [formData appendPartWithFileData:self.fileParam.fileData name:self.fileParam.name fileName:self.fileParam.fileName mimeType:self.fileParam.mimeType];
}

- (NSDictionary *)getAutoparseObjectWithResponseObject:(NSDictionary *)dictionary
{
    return dictionary;
}

- (void)lnterfaceLogWithSucceed:(BOOL)succeed {}

- (void)_onNetworkSuccess
{
    [self lnterfaceLogWithSucceed:YES];

    self.state = MDFBaseModelStateSuccess;
    if (self.parseCls &&
        [self.parseCls isSubclassOfClass:[MDFBaseItem class]] &&
        [self.responseObject isKindOfClass:[NSDictionary class]]) {
        [self willBeginParseData];
        NSDictionary *realParseObj = [self getAutoparseObjectWithResponseObject:self.responseObject];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            MDFBaseItem *item = [[self.parseCls alloc] init];
            [item parseJSONValue:realParseObj];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //把item赋值收敛到主线程
                self->_parsedItem = item;
                [self handleDataAfterParsed];
                if ([self enableCompleteBlock]) {
                    __strong typeof(self) strongSelfForCallBack = self;
                    if (self.completionBlock) {
                        self.completionBlock(strongSelfForCallBack);
                    }
                }
                if (self.innerLoadSuccessBlock) {
                    self.innerLoadSuccessBlock();
                }
            });
        });
    } else {
        [self handleUnparsedData];
        if ([self enableCompleteBlock]) {
            if (self.completionBlock) {
                self.completionBlock(self);
            }
        }
        if (self.innerLoadSuccessBlock) {
            self.innerLoadSuccessBlock();
        }
    }
    self.isLastLoadDataFail = NO;
}

- (void)_onNetworkFail
{
    [self lnterfaceLogWithSucceed:NO];
    
    _parsedItem = nil;
    self.state = MDFBaseModelStateFail;
    [self handleFail];
    if ([self enableCompleteBlock]) {
        if (self.completionBlock) {
            self.completionBlock(self);
        }
    }
    
    self.isLastLoadDataFail = YES;
}

- (void)handleFail
{
}

- (void)pause
{
    self.state = MDFBaseModelStatePause;
    [self.sessionDataTask suspend];
}

- (void)resume
{
    self.state = MDFBaseModelStateLoading;
    [self.sessionDataTask resume];
}

- (BOOL)isLoading
{
    return (self.state == MDFBaseModelStateLoading);
}

- (NSDictionary *)allParams
{
    NSDictionary *requestParam = self.params ? self.params : @{};
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:requestParam];
    if (!self.enableCommonParam) {
        return dict;
    }
    NSDictionary *commonParam = [self commonParam];
    [dict addEntriesFromDictionary:commonParam];
    
    return dict;
}

- (NSDictionary *)commonParam
{
    return @{};
}

- (NSDictionary *)httpHeader
{
    return @{};
}

- (BOOL)isRequestSuccess
{
    if (self.error || self.state != MDFBaseModelStateSuccess) {
        return NO;
    }
    return YES;
}

- (BOOL)enableCompleteBlock
{
    return YES;
}

- (void)willBeginParseData{}
- (void)handleDataAfterParsed{}
- (void)handleUnparsedData{}
- (void)willBeginRequest{}
- (AFHTTPSessionManager *)beforeSendRequest:(AFHTTPSessionManager *)sessionManager{ return sessionManager; }
- (void)didSendRequest{}

#pragma mark - Properties

- (NSMutableDictionary *)flagForUsedCacheDic
{
    if (!_flagForUsedCacheDic) {
        _flagForUsedCacheDic = [NSMutableDictionary dictionary];
    }
    
    return _flagForUsedCacheDic;
}

@end

@implementation MDFFileUploadItem

- (NSString *)mimeType
{
    if (!_mimeType) {
        return @"image/jpeg";
    }
    return _mimeType;
}

@end
