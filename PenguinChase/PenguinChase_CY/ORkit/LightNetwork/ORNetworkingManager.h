//
//  ORNetworkingManager.h
//  HaiLang
//
//  Created by ChenYuan on 2020/9/18.
//  Copyright © 2020 ChenYuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ORRequestType) {
    ORRequestTypePost = 0,    // Post
    ORRequestTypeGet ,        // Get
    ORRequestTypeHead,        // HEAD
};

// 下载进度回调block
typedef void (^MDFDataDownloadBlock)(CGFloat percent);

@interface ORNetworkingManager : NSObject
@property (nonatomic, strong) NSMutableDictionary *httpHeader;  // 公共参数

// 下载进度
@property (nonatomic, assign) CGFloat downloadProgress;

//显示百分比
@property (nonatomic, copy) MDFDataDownloadBlock downloadPercentBlock;

+ (instancetype)sharedInstance;

/// 请求
/// @param baseUrl 域名
/// @param UrlAddress 接口地址
/// @param params 请求参数
/// @param requestType 请求类型
/// @param completeBlock 回调block
- (void)requestBaseUrl:(nullable NSString *)baseUrl
           withAddress:(nullable NSString *)UrlAddress
                params:(NSDictionary *)params
            requesType:(ORRequestType)requestType
         completeBlock:(void (^)(id _Nullable, BOOL))completeBlock;
-(BOOL)OssSet;

@end

NS_ASSUME_NONNULL_END
