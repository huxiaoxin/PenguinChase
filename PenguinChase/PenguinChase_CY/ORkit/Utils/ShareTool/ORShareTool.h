//
//  ORShareTool.h
//  ZhangYuTV
//
//  Created by i mac on 15/9/1.
//  Copyright (c) 2015年 金小白 . All rights reserved.
//  社会化分享工具类

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "ORSingleton.h"

/**分享结果类型*/
typedef NS_ENUM(NSUInteger, ShareResultType) {
    ShareResultTypeSuccess,//分享成功
    ShareResultTypeFail    //分享失败
};

/**分享结果回调*/
typedef void(^ShareResultBlock)(ShareResultType result);

/**社会化分享工具类，使用时需要获取单例*/
@interface ORShareTool : ORSingleton

/**在传入控制器弹出分享界面*/
- (void)shareWithData:(NSString *)title
             imageUrl:(NSString *)imageUrl
          description:(NSString *)desc
           contentUrl:(NSString *)contentUrl
           miniappId:(NSString *)miniappId  // // 小程序id
         miniappPath:(NSString *)miniappPath
          useMiniapp:(BOOL)useMiniapp  // 是否使用小程序
         resultBlock:(ShareResultBlock)shareResultBlock;

@end

@interface ORShareToolButton : UIButton

@property (copy, nonatomic) NSString *platformName;
@property (strong, nonatomic) UIImage *platformIconImage;
@property (strong, nonatomic) UIImage *platformIconHightLightImage;
@property (assign, nonatomic, getter=isInstalled) BOOL installed;

@end
