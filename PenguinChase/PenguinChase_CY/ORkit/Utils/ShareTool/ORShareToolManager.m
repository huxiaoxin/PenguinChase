//
//  ORShareToolManager.m
//  ZhangYuSports
//
//  Created by ChenYuan on 2019/1/13.
//  Copyright © 2019年 ChenYuan. All rights reserved.
//

#import "ORShareToolManager.h"
#import <UMShare/UMShare.h>

@import Photos;
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
#import "ORMainAPI.h"

static NSString *const kGNHTxt_Share_Succeed = @"分享成功";
static NSString *const kGNHTxt_Share_NotInstallWX = @"您未安装微信";
static NSString *const kGNHTxt_Share_NotInstallQQ = @"您未安装QQ";
static NSString *const kGNHTxt_Share_Fail = @"无法进行分享";
static NSString *const kGNHTxt_Share_NullContent = @"内容为空";
static NSString *const kGNHTxt_Share_NotSaveImage = @"当前图片不可保存";
static NSString *const kGNHTxt_Share_SucceedCopy = @"粘贴成功";
static NSString *const kGNHTxt_Share_SucceedSavePicToLibrary = @"已保存到相册，快去发朋友圈邀请好友赚钱吧！";


@implementation ORSharePlatform

@end

@interface ORShareToolManager ()

@end

@implementation ORShareToolManager

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - Init ShareSDK
/**
 初始化sharesdk
 */
- (void)registerShareSDK
{
    //设置AppKey & LaunchOptions
    [UMConfigure initWithAppkey:umengAccesskey channel:ORchannel];
    
    //配置微信平台的Universal Links
    //微信和QQ完整版会校验合法的universalLink，不设置会在初始化平台失败
    [UMSocialGlobal shareInstance].universalLinkDic = @{@(UMSocialPlatformType_WechatSession):UniversalLinks,
                                                        @(UMSocialPlatformType_QQ):tencentUniversalLinks
                                                        };
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:WechatAppKey appSecret:WeChatAppSecret redirectURL:@"https://m.iorange99.com"];
    
    /*设置小程序回调app的回调*/
    [[UMSocialManager defaultManager] setLauchFromPlatform:(UMSocialPlatformType_WechatSession) completion:^(id userInfoResponse, NSError *error) {
        NSLog(@"setLauchFromPlatform:userInfoResponse:%@",userInfoResponse);
    }];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:tencentAppID/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"https://m.iorange99.com"];
}

#pragma mark share

+ (void)sharePlatform:(ORSharePlatform *)platform completion:(ORShareBlock)completion {
    UMSocialPlatformType type = UMSocialPlatformType_UnKnown;
    switch (platform.gnh_platform) {
        case ORSharePlatformTypeWechatMoments:
            type = UMSocialPlatformType_WechatTimeLine;
            break;
        case ORSharePlatformTypeWechat:
            type = UMSocialPlatformType_WechatSession;
            break;
        case ORSharePlatformTypeQQ:
            type = UMSocialPlatformType_QQ;
            break;
        case ORSharePlatformTypeQZone:
            type = UMSocialPlatformType_Qzone;
            break;
        case ORSharePlatformTypeSinaWeibo:
            type = UMSocialPlatformType_Sina;
            break;
        case ORSharePlatformTypeMessage:
            type = UMSocialPlatformType_Sms;
            break;
        case ORSharePlatformTypeCopy:
        case ORSharePlatformTypeSaveImage:
        case ORSharePlatformTypeNone:
        default:
            type = UMSocialPlatformType_UnKnown;
            break;
    }
    if (type != UMSocialPlatformType_UnKnown) {
        [self shareType:type platform:platform completion:completion];
    } else {
        [self shareOtherType:platform.gnh_platform platform:platform completion:completion];
    }
}

+ (void)shareType:(UMSocialPlatformType)type platform:(ORSharePlatform *)platform completion:(ORShareBlock)completion {
    //创建分享对象
    UMSocialMessageObject *messageObject = [self socialMessageObject:platform type:type];
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id result, NSError *error) {
        NSString *msg = nil;
        ORShareToolResult resultType = ORShareToolResultNone;
        if (error) {
            resultType = ORShareToolResultFail;
            msg = error.userInfo[@"error_message"];
            if (msg.length < 5) {
                msg = kGNHTxt_Share_Fail;
            }
        } else {
            msg = kGNHTxt_Share_Succeed;
            resultType = ORShareToolResultSucceed;
        }
        if (completion) {
            completion(platform, resultType, msg);
        }
    }];
}

/** 构建特定平台分享内容 */
+ (UMSocialMessageObject *)socialMessageObject:(ORSharePlatform *)platform type:(UMSocialPlatformType)type {
    NSString *title = platform.title;
    NSString *content = platform.content;
    NSString *imgpath = platform.imgpath;
    NSString *shareURLString = platform.basepath;
    NSArray *images = nil;
    if (imgpath.length > 0) {
        images = @[imgpath];
    }
    shareURLString = [ORMainAPI stringAddingPercentEscapesChineseSpace:shareURLString];
        
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:imgpath];
    //设置网页地址
    shareObject.webpageUrl = shareURLString;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    return messageObject;
}


+ (void)shareOtherType:(ORSharePlatformType)type platform:(ORSharePlatform *)platform completion:(ORShareBlock)completion {
    switch (type) {
        case ORSharePlatformTypeCopy:
            [self copyPlatform:platform completion:completion];
            break;
        case ORSharePlatformTypeSaveImage:
            [self savePlatform:platform completion:completion];
            break;
        default:
            completion(platform, ORShareToolResultNone, nil);
            break;
    }
}

+ (void)savePlatform:(ORSharePlatform *)platform completion:(ORShareBlock)completion {
    if ([platform.imgpath hasPrefix:@"http"]) {
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSString URLWithString_LY:platform.imgpath] options:SDWebImageContinueInBackground progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (!error && finished && image) {
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    [PHAssetChangeRequest creationRequestForAssetFromImage:image];
                } completionHandler:^(BOOL success, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *msg;
                        ORShareToolResult result;
                        if (success) {
                            result = ORShareToolResultSucceed;
                            msg = kGNHTxt_Share_SucceedSavePicToLibrary;
                        }else {
                            result = ORShareToolResultFail;
                            msg = kGNHTxt_Share_NotSaveImage;
                        }
                        if (completion) {
                            completion(platform, result, msg);
                        }
                    });
                }];
            } else {
                if (completion) {
                    completion(platform, ORShareToolResultFail, kGNHTxt_Share_NotSaveImage);
                }
            }
        }];
    } else if (platform.imgpath.length) {
        UIImage *image = [UIImage imageWithBase64:platform.imgpath];
        if (image) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *msg;
                    ORShareToolResult result;
                    if (success) {
                        result = ORShareToolResultSucceed;
                        msg = kGNHTxt_Share_SucceedSavePicToLibrary;
                    }else {
                        result = ORShareToolResultFail;
                        msg = kGNHTxt_Share_NotSaveImage;
                    }
                    if (completion) {
                        completion(platform, result, msg);
                    }
                });
            }];
        } else {
            if (completion) {
                completion(platform, ORShareToolResultFail, kGNHTxt_Share_NotSaveImage);
            }
        }
    }
    else {
        if (completion) {
            completion(platform, ORShareToolResultFail, kGNHTxt_Share_NotSaveImage);
        }
    }
}

+ (void)copyPlatform:(ORSharePlatform *)platform completion:(ORShareBlock)completion {
    NSString *content = [NSString stringWithFormat:@"%@ %@", platform.content, platform.basepath];
    NSString *msg;
    ORShareToolResult succeed;
    if (content) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.strings = @[content];
        msg = kGNHTxt_Share_SucceedCopy;
        succeed = ORShareToolResultSucceed;
    } else {
        msg = kGNHTxt_Share_NullContent;
        succeed = ORShareToolResultFail;
    }
    if (completion) {
        completion(platform, succeed, msg);
    }
}

@end
