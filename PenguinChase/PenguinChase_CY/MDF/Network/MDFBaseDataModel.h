//
//  MDFBaseDataModel.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/9.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDFNetworkModelProtocol.h"

@class MDFBaseDataModel, AFHTTPSessionManager, AFHTTPRequestSerializer, MDFBaseItem;

typedef NS_ENUM(NSUInteger, MDFRequestType) {
    MDFRequestTypePost = 0,    // Post
    MDFRequestTypeGet ,        // Get
    MDFRequestTypeHead,        // HEAD
};

// 下载进度回调block
typedef void (^MDFDataDownloadBlock)(CGFloat percent);

// 上传进度回调block
typedef void (^MDFDataUploadBlock)(CGFloat percent);

@interface MDFBaseDataModel : NSObject <MDFNetworkModelProtocol>
{
    @protected AFHTTPRequestOperation *_request;
    @protected Class _parseCls;
    @protected MDFBaseItem *_parsedItem;
}

#pragma mark - lifeCycle
//获取自动解析的对象,dictionary是网络返回的json格式数据
- (NSDictionary *)getAutoparseObjectWithResponseObject:(NSDictionary *)dictionary;

// 开始发起请求
- (void)willBeginRequest;

// 发起请求之前
- (AFHTTPSessionManager *)beforeSendRequest:(AFHTTPSessionManager *)sessionManager;

// 网络请求发送
- (void)didSendRequest;

// 开始解析返回数据
- (void)willBeginParseData;

// 返回数据解析完成
- (void)handleDataAfterParsed NS_REQUIRES_SUPER;

// 处理返回数据不合法或者不解析的数据
- (void)handleUnparsedData;

// 处理所有的错误，包括网络错误、json解析错误，具体可以查看error属性返回的数据
- (void)handleFail;

// 是否允许执行completeBlock回调方法，底层默认返回YES
- (BOOL)enableCompleteBlock;

// 日志信息输出格式配置, succeed（YES/NO）请求成功/失败
- (void)lnterfaceLogWithSucceed:(BOOL)succeed;

// 数据获取是否成功
- (BOOL)isRequestSuccess;

#pragma mark - @property
// 网络数据的地址（域名或IP）
@property (nonatomic, strong) NSString *baseURL;

// 接口名称
@property (nonatomic, copy) NSString *address;

// 网络数据POST的参数
@property (nonatomic, strong) NSDictionary *params;

// 网络请求是否配置commonParam，默认配置YES
@property (nonatomic, assign) BOOL enableCommonParam;

// 解析数据类型
@property (nonatomic, assign) Class parseCls;

// 当前数据获取的网络状态
@property (nonatomic, assign) MDFBaseModelState state;

// AFHTTPRequestOperation 错误信息
@property (nonatomic, strong) NSError *error;

// 请求requestHeader
@property (nonatomic, strong) NSDictionary *requestHeader;

// 请求超时时间
@property (nonatomic, assign) NSUInteger requestTimeout;

// 请求responseHeader
@property (nonatomic, strong) NSDictionary *responseHeader;

// 获取网络数据回调
@property (nonatomic, copy) MDFBaseNetworkModelCompletionBlock completionBlock;

// 返回的数据对象
@property (nonatomic, strong, readonly) MDFBaseItem *parsedItem;

//上次加载是否失败
@property (nonatomic, assign) BOOL isLastLoadDataFail;

// 拉取失败后重试次数 默认0，大于0会尝试多次拉取直到0
@property (nonatomic, assign) NSInteger retryCount;

// 是否支持gzip压缩
@property (nonatomic, assign) BOOL useGzipCompression;

// 请求类型
@property (nonatomic, assign) MDFRequestType requestType;

// 请求参数类型
@property (nonatomic, assign) BOOL requestBodyType;  // 通过body传参

// 下载进度
@property (nonatomic, assign) CGFloat downloadProgress;

//显示百分比
@property (nonatomic, copy) MDFDataDownloadBlock downloadPercentBlock;

// 公共的参数
- (NSDictionary *)commonParam;

// httpHeaders
- (NSDictionary *)httpHeader;

@end

typedef void (^MDFDataUploadBlock)(CGFloat percent);

@interface MDFFileUploadItem : NSObject

@property (nonatomic, copy) NSString *mimeType; //default image/jpeg
@property (nonatomic, copy) NSString *fileName; //文件名称
@property (nonatomic, copy) NSString *name;     //名称
@property (nonatomic, strong) NSData *fileData; //数据

@end

@interface MDFBaseDataModel (FileUploadModelAdpater)

@property (nonatomic, strong) MDFFileUploadItem *fileParam;
@property (nonatomic, copy) MDFDataUploadBlock uploadPercentBlock; //显示百分比

@end
