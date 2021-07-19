//
//  GNHWebModel.h
//  GeiNiHua
//
//  Created by 吴浪 on 2017/11/29.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "GNHWebKitHeader.h"

#pragma mark - GNHWebLabelItem
@interface GNHWebLabelItem : NSObject
@property (nonatomic, copy) NSString *title;/**< 文案 */
@property (nonatomic, copy) NSString *func;/**< 功能 */
@property (nonatomic, copy) NSString *mark;/**< 标识 */
@end

#pragma mark - GNHWebItem
@interface GNHWebItem : NSObject
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userId51;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *loginState;/**< 登录状态 */
@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *code;/**< 状态码 */
@property (nonatomic, copy) NSString *message;/**< 信息 */
@property (nonatomic, copy) NSString *brand;/**< 品牌 */
@property (nonatomic, copy) NSString *mark;/**< 标识 */
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) BOOL auth;/**< 授权 */
@property (nonatomic, copy) NSString *imageBase64;/**< 图片base64编码 */
@property (nonatomic, copy) NSString *title;/**< 标题 */
@property (nonatomic, copy) NSString *content;/**< 详细内容 */
@property (nonatomic, copy) NSString *imgpath;/**< 图片路径 */
@property (nonatomic, copy) NSString *basepath;/**< 链接地址 */
@property (nonatomic, copy) NSString *type;/**< 平台类型（WechatMoments微信朋友圈，Wechat微信,QQ， QZone空间，SinaWeibo微博，Message短信,粘贴：copyShare ,保存相册：saveImage），NavigationBar（导航栏）, 【Android：none正常页面, file pdf/word页面)】 */
@property (nonatomic, strong) NSArray *sharing;
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appName;

@property (nonatomic, strong) GNHWebLabelItem *titleLabel;
/**
 "func" 0-关闭Web壳 1-按历史返回 2-自定义
 */
@property (nonatomic, strong) GNHWebLabelItem *leftLabel;
/**
 "func" 0-默认没有 1-分享 2-关闭 3-刷新 4-自定义
 */
@property (nonatomic, strong) GNHWebLabelItem *rightLabel;

@end

#pragma mark - GNHWebModel
@interface GNHWebModel : NSObject

@property (nonatomic, assign, readonly) GNHWebFuncType funType;/**< 功能 */
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *platform;
@property (nonatomic, strong) GNHWebItem *info;/**< 数据集合 */
@property (nonatomic, copy) NSString *h5_tasksId;/**< 任务ID */

+ (instancetype)webModelWithFuncType:(GNHWebFuncType)funcType;

/**
 根据方法类型返回对应的标识字符串

 @param type 功能方法类型
 @return 功能标识字符串
 */
+ (NSString *)webFuncType:(GNHWebFuncType)type;

@end
