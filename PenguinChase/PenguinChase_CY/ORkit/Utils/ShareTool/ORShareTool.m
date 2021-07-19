//
//  ORShareTool.m
//  ZhangYuTV
//
//  Created by i mac on 15/9/1.
//  Copyright (c) 2015年 金小白 . All rights reserved.
//

#import "ORShareTool.h"
#import <UMShare/UMShare.h>
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "ORShareReportDataModel.h"

@interface ORShareTool ()

@property (copy, nonatomic) ShareResultBlock shareResultBlock;
@property (strong, nonatomic) UIView *shareBgView;
@property (strong, nonatomic) NSMutableArray *platformArray;

@property (nonatomic, strong) ORShareReportDataModel *shareChannelDataModel; // 分享
@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, copy) NSString *desc; // 描述
@property (nonatomic, copy) NSString *contentUrl; // 内容URL
@property (nonatomic, copy) NSString *imageUrl; // 内嵌图片URL
@property (strong, nonatomic) UIImage *defaultImage; // 默认图片
@property (nonatomic, copy) NSString *miniappId; // 小程序id
@property (nonatomic, copy) NSString *miniappPath; // 小程序绝对路径
@property (nonatomic, assign) BOOL useMiniapp; // 是否使用小程序

@property (nonatomic, strong) ORShareToolButton *selectShareToolButton;  // 选择的按钮

@end

@implementation ORShareTool


- (void)shareWithData:(NSString *)title
             imageUrl:(NSString *)imageUrl
          description:(NSString *)desc
           contentUrl:(NSString *)contentUrl
            miniappId:(NSString *)miniappId
          miniappPath:(NSString *)miniappPath
           useMiniapp:(BOOL)useMiniapp
          resultBlock:(ShareResultBlock)shareResultBlock
{
    self.imageUrl = imageUrl;
    // 分享内嵌图片，需要确定
    if (!self.imageUrl.length) {
        self.defaultImage = [UIImage imageNamed:@"logo"];
    }
    self.title = title;
    self.desc = desc;
    self.contentUrl = contentUrl;
    self.miniappId = miniappId;
    self.miniappPath = miniappPath;
    self.useMiniapp = useMiniapp;
    self.shareResultBlock = shareResultBlock;

    [self setUpViewWithView:[self appWindow]];
}

- (void)setUpViewWithView:(UIView *)view
{
    UIView *bgView = [UIView new];
    bgView.backgroundColor = RGBA_COLOR(0, 0, 0, 0.7);
    [view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    self.shareBgView = bgView;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButtonClick)];
    [bgView addGestureRecognizer:tapGes];
    
    UIView *bottomBgView = [UIView new];
    bottomBgView.backgroundColor = RGBA_HexCOLOR(0xf5f5f5, 0.94);
    [bgView addSubview:bottomBgView];
    [bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(bgView);
        make.height.mas_equalTo(159);
    }];
    
    UIButton *cancelButton = [UIButton new];
    cancelButton.backgroundColor = [UIColor whiteColor];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelButton setTitleColor:RGBA_HexCOLOR(0x484848, 1.0) forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消分享" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomBgView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(bottomBgView);
        make.height.mas_equalTo(51);
    }];
    
    GNHWeakSelf;
    __block ORShareToolButton *tmpButton;
    [self.platformArray enumerateObjectsUsingBlock:^(ORShareToolButton *shareButton, NSUInteger idx, BOOL * _Nonnull stop) {
        [bottomBgView addSubview:shareButton];
        [shareButton addTarget:weakSelf action:@selector(shareButtonClickRequest:) forControlEvents:UIControlEventTouchUpInside];

        if (idx == 0) {
            [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(bottomBgView).offset(10.0f);
                make.left.mas_equalTo(bottomBgView.mas_left).offset(15.0f);
                make.height.mas_equalTo(108);
            }];
            
        } else {
            [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tmpButton);
                make.left.equalTo(tmpButton.mas_right);
                make.size.equalTo(tmpButton);
                if (idx == weakSelf.platformArray.count - 1) {
                    make.right.equalTo(bottomBgView.mas_right);
                }
            }];
        }
        
        tmpButton = shareButton;
    }];
}

- (void)shareButtonClickRequest:(ORShareToolButton *)button
{
    if (!button.isInstalled) {
        return;
    }
    self.selectShareToolButton = button;
    
    // 1微信, 2微信朋友圈, 3QQ
    NSInteger type = 0;
    if ([button.platformName isEqualToString:@"微信"]) {
        type = 1;
    } else if ([button.platformName isEqualToString:@"朋友圈"]) {
        type = 2;
    } else if ([button.platformName isEqualToString:@"QQ"]) {
        type = 3;
    } else if ([button.platformName isEqualToString:@"QQ空间"]) {
        type = 4;
    }
        
    [self shareButtonClick:button];
}

- (void)shareButtonClick:(ORShareToolButton *)button
{
    GNHWeakSelf;

    if (!button.isInstalled) {
        return;
    }
    
    UMSocialPlatformType platformType = UMSocialPlatformType_UnKnown;
    if ([button.platformName isEqualToString:@"QQ"]) {
        platformType = UMSocialPlatformType_QQ;
    }
    
    if ([button.platformName isEqualToString:@"QQ空间"]) {
        platformType = UMSocialPlatformType_Qzone;
    }

    if ([button.platformName isEqualToString:@"微信"]) {
        platformType = UMSocialPlatformType_WechatSession;
    }

    if ([button.platformName isEqualToString:@"朋友圈"]) {
        platformType = UMSocialPlatformType_WechatTimeLine;
    }
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    
    NSData *imageDate = [NSData dataWithContentsOfURL:self.imageUrl.urlWithString];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.title descr:self.desc thumImage:self.imageUrl.length ? imageDate : self.defaultImage];
    //设置网页地址
    shareObject.webpageUrl = self.contentUrl;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    if (self.useMiniapp) {
        // 小程序分享
        UMSocialMessageObject *miniappMessageObject = [UMSocialMessageObject messageObject];
        UMShareMiniProgramObject *shareObject = [UMShareMiniProgramObject shareObjectWithTitle:self.title descr:self.desc thumImage:self.imageUrl.length ? self.imageUrl : self.defaultImage];
        shareObject.webpageUrl = self.contentUrl;
        shareObject.userName = self.miniappId;
        shareObject.path = self.miniappPath;
        miniappMessageObject.shareObject = shareObject;
        
        UIImage *image = [UIImage imageNamed:@"logo"];
        NSData *data = UIImageJPEGRepresentation(image, 1);
        shareObject.hdImageData = data;
        shareObject.miniProgramType = UShareWXMiniProgramTypeRelease; // 可选体验版和开发板
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:miniappMessageObject currentViewController:nil completion:^(id data, NSError *error) {
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            } else {
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                } else {
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
        }];
    } else {
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil  completion:^(id result, NSError *error) {
            if (error) {
                weakSelf.shareResultBlock(ShareResultTypeFail);
            } else {
                weakSelf.shareResultBlock(ShareResultTypeSuccess);
            }
        }];
    }
    
    [self cancelButtonClick];
}

- (void)cancelButtonClick
{
    [self.shareBgView removeFromSuperview];
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
}

- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelError:gnhModel];
    if ([gnhModel isKindOfClass:[ORShareReportDataModel class]]) {
       [SVProgressHUD showInfoWithStatus:@"获取分享数据失败~"];
    }
}

#pragma mark - properties

- (UIWindow *)appWindow
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    //app Window的windowLevel默认是UIWindowLevelNormal
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    return window;
}

- (NSMutableArray *)platformArray {
    if (!_platformArray || !_platformArray.count) {
        _platformArray = [NSMutableArray array];
        
        if ([WXApi isWXAppInstalled]) {
            ORShareToolButton *wxButton = [ORShareToolButton new];
            wxButton.platformIconImage = [UIImage imageNamed:@"pandaMoview_wechat_iocn"];
            wxButton.platformIconHightLightImage = [UIImage imageNamed:@"pandaMoview_wechat_iocn"];
            wxButton.platformName = @"微信";
            wxButton.installed = [WXApi isWXAppInstalled];
            [_platformArray addObject:wxButton];
        }
        
        if ([WXApi isWXAppInstalled]) {
            ORShareToolButton *wxSessionButton = [ORShareToolButton new];
            wxSessionButton.platformIconImage = [UIImage imageNamed:@"padnaMoview_Friedn_icon"];
            wxSessionButton.platformIconHightLightImage = [UIImage imageNamed:@"padnaMoview_Friedn_icon"];
            wxSessionButton.platformName = @"朋友圈";
            wxSessionButton.installed = [WXApi isWXAppInstalled];
            [_platformArray addObject:wxSessionButton];
        }

        if ([TencentOAuth iphoneQQInstalled]) {
            ORShareToolButton *qqButton = [ORShareToolButton new];
            qqButton.platformIconImage = [UIImage imageNamed:@"pandaMoiew_QQ_icon"];
            qqButton.platformIconHightLightImage = [UIImage imageNamed:@"pandaMoiew_QQ_icon"];
            qqButton.platformName = @"QQ";
            qqButton.installed = [TencentOAuth iphoneQQInstalled];
            [_platformArray addObject:qqButton];
        }
        
        if ([TencentOAuth iphoneQQInstalled]) {
            ORShareToolButton *qqzoneButton = [ORShareToolButton new];
            qqzoneButton.platformIconImage = [UIImage imageNamed:@"pandaMoview_QQ_Zone_icon"];
            qqzoneButton.platformIconHightLightImage = [UIImage imageNamed:@"pandaMoview_QQ_Zone_icon"];
            qqzoneButton.platformName = @"QQ空间";
            qqzoneButton.installed = [TencentOAuth iphoneQQInstalled];
            [_platformArray addObject:qqzoneButton];
        }
    }
    
    return _platformArray;
}

- (ORShareReportDataModel *)shareChannelDataModel
{
    if (!_shareChannelDataModel) {
        _shareChannelDataModel = [self produceModel:[ORShareReportDataModel class]];
    }
    return _shareChannelDataModel;
}

@end

@interface ORShareToolButton ()

@property (strong, nonatomic) UIImageView *platformIconImageView;
@property (strong, nonatomic) UILabel *platformNameLabel;

@end

@implementation ORShareToolButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.platformNameLabel = [UILabel new];
        self.platformNameLabel.textAlignment = NSTextAlignmentCenter;
        self.platformNameLabel.font = [UIFont systemFontOfSize:13];
        self.platformNameLabel.textColor = [UIColor blackColor];
        [self addSubview:self.platformNameLabel];
        [self.platformNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self).offset(-20);
            make.height.mas_equalTo(13);
        }];
        
        self.platformIconImageView = [UIImageView new];
        self.platformIconImageView.contentMode = UIViewContentModeBottom;
        [self addSubview:self.platformIconImageView];
        [self.platformIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.bottom.equalTo(self.platformNameLabel.mas_top).offset(-9);
        }];
    }
    return self;
}

- (void)setPlatformName:(NSString *)platformName {
    _platformName = platformName;
    
    self.platformNameLabel.text = platformName;
}

- (void)setPlatformIconImage:(UIImage *)platformIconImage {
    _platformIconImage = platformIconImage;
    
    self.platformIconImageView.image = platformIconImage;
}

- (void)setPlatformIconHightLightImage:(UIImage *)platformIconHightLightImage {
    _platformIconHightLightImage = platformIconHightLightImage;
    
    self.platformIconImageView.highlightedImage = platformIconHightLightImage;
}

- (void)setInstalled:(BOOL)installed {
    _installed = installed;
    
    self.platformIconImageView.highlighted = !installed;
}


@end
