//
//  GNHBaseDataModel.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/14.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "MDFBaseDataModel.h"
#import "GNHBaseItem.h"
#import "NSString+GNHNetworkAddress.h"

typedef NS_ENUM(NSUInteger, GNHDataModelLoadType) {
    GNHDataModelLoadTypeRefresh,   // 刷新数据
    GNHDataModelLoadTypeLoadMore,  // 加载更多数据
    GNHDataModelLoadTypeCommit,    // 提交数据
};

typedef NS_ENUM(NSUInteger, GNHDataModelLoadMessageType) {
    GNHDataModelLoadMessageTypeNormal,   // 一般
    GNHDataModelLoadMessageTypeLogin,    // 登录
    GNHDataModelLoadMessageTypeRegister, // 注册
};

@protocol GNHBaseDataModelProtocol <NSObject>

@required

/** 配置baseUrl
 *
 *  @return baseUrl
 */
- (NSString *)configBaseUrl;

@end

@class GNHBaseDataModel;

@protocol GNHBaseDataModelDelegate <NSObject>

@optional

/** 即将发起提交请求
 *
 *  @param gnhModel model
 */
- (void)willLoadToCommit:(GNHBaseDataModel *)gnhModel;

/** 即将发起刷新请求
 *
 *  @param gnhModel model
 */
- (void)willLoadRefresh:(GNHBaseDataModel *)gnhModel;

/** 即将发起加载更多请求
 *
 *  @param gnhModel model
 */
- (void)willLoadMore:(GNHBaseDataModel *)gnhModel;

@required

/** 即将发起网络请求
 *
 *  @param gnhModel model
 */
- (void)dataModelWillLoad:(GNHBaseDataModel *)gnhModel;

/** 网络请求失败(网络错误)
 *
 *  @param gnhModel model
 */
- (void)networkFailNotify:(GNHBaseDataModel *)gnhModel;

/**  解析数据失败
 *
 *  @param gnhModel model
 */
- (void)parseDataError:(GNHBaseDataModel *)gnhModel;

/**  加载完缓存后，是否自动加载网络数据
 *
 *  @param gnhModel model
 *
 *  @return 是否需要
 */
- (BOOL)shoudAutoRequestAfterLoadCache:(GNHBaseDataModel *)gnhModel;

@end

@interface GNHBaseDataModel : MDFBaseDataModel

#pragma mark - Interface

/**  判断是否成功，包含服务器错误域与网络请求
 *
 *  @return 是否成功
 */
- (BOOL)isServerDataCorrectAndNetworkRequestSuccess;

/**  网络请求头
 *
 *  @return 请求头，dic形式返回
 */
+ (NSMutableDictionary *)requestHead;

/**  获取错误信息
 *
 *  @return 错误信息
 */
- (NSString *)errorUserMessage;

/**  数据请求
 *
 */
- (BOOL)load;

#pragma mark - @property

// 请求域名类型
@property (nonatomic, assign) GNHBaseURLType hostType;

// 是否需要在访问接口的时候检测当前是否有登录账号,默认是YES
@property (nonatomic, assign) BOOL checkLogin;

// 是否在 Model 成功回调后自动 dismiss，默认是NO 即会在成功回调自动 dismiss
@property (nonatomic, assign) BOOL disableAutoDismiss;

// 标记当前是下拉刷新，还是加载更多，默认是下拉刷新
@property (nonatomic, assign) GNHDataModelLoadType loadType;

//Delegate
@property (nonatomic, weak) id<GNHBaseDataModelDelegate> delegate;

// 展示网络错误toast，默认YES
@property (nonatomic, assign) BOOL isAutoShowNetworkErrorToast;

// 展示业务错误toast，默认NO
@property (nonatomic, assign) BOOL isAutoShowBusinessErrorToast;

// 是否回调成功
@property (nonatomic, assign) BOOL isResponseSucess;

// 用户是否是可以操作的
@property (nonatomic, assign) BOOL enableUserInteraction;

// 加载文案
@property (nonatomic, copy) NSString *loadTips;

// 网络请求菊花信息类型
@property (nonatomic, assign) GNHDataModelLoadMessageType messageType;

// 是否加密过
@property (nonatomic, assign) BOOL enableEncrypt;

// 是否加载默认页面
@property (nonatomic, assign) BOOL isShowDefaultView;

// 是否显示加载菊花，默认YES
@property (nonatomic, assign) BOOL isShowSVProgressLoading;

@end
