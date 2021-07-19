//
//  GNHWebKitHeader.h
//  GeiNiHua
//
//  Created by 吴浪 on 2018/6/11.
//  Copyright © 2018年 GNH. All rights reserved.
//

#ifndef GNHWebKitHeader_h
#define GNHWebKitHeader_h

typedef NS_ENUM(NSUInteger, GNHWebFuncType) {
    GNHWebFuncTypeNone, /**< 无功能 */
    GNHWebFuncTypeAlert, /**< 弹框 */
    GNHWebFuncTypeOpenPage, /**< 打开新页面 */
    GNHWebFuncTypeOpenApp, /**< 打开第三方App，如QQ,WeChat微信、打电话 */
    GNHWebFuncTypeLeavePage, /**< 离开当前Web壳 */
    GNHWebFuncTypeShare, /**< 分享 */
    GNHWebFuncTypeGetAppData, /**< H5获取原生数据 */
    GNHWebFuncTypeCameraAndAlbum, /**< 相机&相册 */
    GNHWebFuncTypeTokenAlert, /**< Token失效 */
    GNHWebFuncTypeConfig, /**< 配置Web */
    GNHWebFuncTypeRightAction, /**< 导航栏右侧按钮触发 */
    GNHWebFuncTypeLeftAction, /**< 导航栏左侧按钮触发 */
    GNHWebFuncTypeWebAppear, /**< 其它页面返回Web页面 */
    GNHWebFuncTypeClearCache, /**< 清除缓存 */
    GNHWebFuncTypeReload, /**< 页面重新加载 */
    GNHWebFuncTypeSetAppData, /**< H5设置数据 */
    GNHWebFuncTypeOpenSystemSetting, /**< 打开系统设置 */
    GNHWebFuncTypeMainTabRoutes,/**< 获取底部Tab上第一级页面路由 */
    GNHWebFuncTypeOCRAndLiving,/**< OCR（身份证）and Living（活体） */
    GNHWebFuncTypeSetUserInfo,/**< 设置用户登录信息 */
};

typedef NS_ENUM(NSInteger, GNHWebResultCode) {
    GNHWebResultCodeNone = 99,
    GNHWebResultCodeFail = 0,
    GNHWebResultCodeSucceed = 1,
    GNHWebResultCodeFunctionNotFound = 98,
};

typedef NS_ENUM(NSInteger, GNHWebState) {
    GNHWebStateLoadFront,
    GNHWebStateLoading,
    GNHWebStateLoadFinish,
    GNHWebStateLoadFail,
};

typedef NS_ENUM(NSInteger, GNHWebRight) {
    GNHWebRightNone = 0,
    GNHWebRightShare = 1,
    GNHWebRightClose = 2,
    GNHWebRightRefresh = 3,
    GNHWebRightCustom = 4,
};

typedef NS_ENUM(NSInteger, GNHWebLeft) {
    GNHWebLeftNone = 0,
    GNHWebLeftSignOut = GNHWebLeftNone, /**< 退出当前Web壳 */
    GNHWebLeftBack = 1, /**< 返回上页，根据Web历史 */
    GNHWebLeftCustom = 2,
};

#endif /* GNHWebKitHeader_h */
