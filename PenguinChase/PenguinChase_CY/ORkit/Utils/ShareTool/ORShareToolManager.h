//
//  ORShareToolManager.h
//  ZhangYuSports
//
//  Created by ChenYuan on 2019/1/13.
//  Copyright © 2019年 ChenYuan. All rights reserved.
//

#import "ORSingleton.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ORShareToolResult) {
    ORShareToolResultNone,
    ORShareToolResultSucceed,/**< 成功 */
    ORShareToolResultFail,/**< 失败 */
    ORShareToolResultShareCancel,/**< 取消操作 */
    ORShareToolResultUICancel,/**< 取消操作界面 */
};

typedef NS_ENUM(NSUInteger, ORSharePlatformType) {
    ORSharePlatformTypeNone = 0,
    ORSharePlatformTypeWechatMoments,/**< 微信朋友圈 */
    ORSharePlatformTypeWechat,/**< 微信好友 */
    ORSharePlatformTypeQQ,/**< QQ好友 */
    ORSharePlatformTypeQZone,/**< QZone */
    ORSharePlatformTypeSinaWeibo,/**< 新浪微博 */
    ORSharePlatformTypeMessage,/**< 短信 */
    ORSharePlatformTypeCopy,/**< 复制 */
    ORSharePlatformTypeSaveImage,/**< 保存图片 */
};

@interface ORSharePlatform : NSObject

@property (nonatomic, copy, readonly) NSString *gnh_icon;/**< 平台图标 */
@property (nonatomic, copy, readonly) NSString *gnh_name;/**< 平台名称 */
@property (nonatomic, assign) ORSharePlatformType gnh_platform;/**< 分享平台 */

@property (nonatomic, copy) NSString *title;/**< 活动标题 */
@property (nonatomic, copy) NSString *content;/**< 活动内容 */
@property (nonatomic, copy) NSString *imgpath;/**< 活动图片地址 */
@property (nonatomic, copy) NSString *basepath;/**< 活动链接地址 */
@property (nonatomic, copy) NSString *type; //平台类型（WechatMoments微信朋友圈，Wechat微信,QQ， QZone空间，SinaWeibo微博，Message短信,粘贴：copyShare ,保存相册：saveImage）

@property (nonatomic, strong) NSDictionary *userInfo;

@end

typedef void(^ORShareBlock)(ORSharePlatform * _Nullable platform, ORShareToolResult result, NSString * _Nullable message);
typedef void(^ORShareDidClickBlock)(ORSharePlatform *platform);

@interface ORShareToolManager : ORSingleton

- (void)registerShareSDK;
+ (void)sharePlatform:(ORSharePlatform *)platform completion:(ORShareBlock)completion;

@end

NS_ASSUME_NONNULL_END
