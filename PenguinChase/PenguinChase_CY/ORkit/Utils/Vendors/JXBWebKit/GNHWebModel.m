//
//  GNHWebModel.m
//  GeiNiHua
//
//  Created by 吴浪 on 2017/11/29.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "GNHWebModel.h"
#import "GNHWebKitHeader.h"

static NSString *const kWebFuncTypeAlert = @"Alert";
static NSString *const kWebFuncTypeOpenPage = @"OpenPage";
static NSString *const kWebFuncTypeOpenApp = @"OpenApp";
static NSString *const kWebFuncTypeShare = @"Share";
static NSString *const kWebFuncTypeGetAppData = @"GetAppData";
static NSString *const kWebFuncTypeSetAppData = @"SetAppData";
static NSString *const kWebFuncTypeTokenAlert = @"TokenAlert";
static NSString *const kWebFuncTypeConfig = @"Config";
static NSString *const kWebFuncTypeRightAction = @"RightLabel";
static NSString *const kWebFuncTypeLeftAction = @"LeftLabel";
static NSString *const kWebFuncTypeWebAppear = @"WebAppear";
static NSString *const kWebFuncTypeLeavePage = @"LeavePage";
static NSString *const kWebFuncTypeOpenSystemSetting = @"OpenSystemSetting";
static NSString *const kWebFuncTypeCameraAndAlbum = @"CameraAndAlbum";
static NSString *const kWebFuncTypeReload = @"Reload";
static NSString *const kWebFuncTypeClearCache = @"ClearCache";
static NSString *const kWebFuncTypeMainTabRoutes = @"gnhHDMainTabRoutes";
static NSString *const kWebFuncTypeOCRAndLiving = @"OCRAndLiving";
static NSString *const kWebFuncTypeSetUserInfo = @"SetUserInfo";

#pragma mark - GNHWebLabelItem
@implementation GNHWebLabelItem
@end

#pragma mark - GNHWebItem
@implementation GNHWebItem
@end

#pragma mark - GNHWebModel
@interface GNHWebModel()
@property (nonatomic, strong, class, readonly) NSDictionary<NSString *, NSNumber *> *funTypeDict;
@end
@implementation GNHWebModel

+ (instancetype)webModelWithFuncType:(GNHWebFuncType)type {
    GNHWebModel *model = [[self alloc] init];
    model->_funType = type;
    return model;
}

- (void)setType:(NSString *)type {
    _type = [type copy];
    NSNumber *funType = [self.class funTypeDict][_type?:@""];
    _funType = (GNHWebFuncType)funType.unsignedIntegerValue;
}

+ (NSString *)webFuncType:(GNHWebFuncType)type {
    __block NSString *funcType = @"None";
    [[self.class funTypeDict] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSNumber * _Nonnull obj, BOOL * _Nonnull stop) {
        if (type == obj.unsignedIntegerValue) {
            funcType = key;
            *stop = YES;
        }
    }];
    return funcType;
}

+ (NSDictionary<NSString *,NSNumber *> *)funTypeDict {
    static NSMutableDictionary *kFunTypeDict = nil;
    if (!kFunTypeDict) {
        kFunTypeDict = [NSMutableDictionary dictionary];
        kFunTypeDict[kWebFuncTypeAlert] = @(GNHWebFuncTypeAlert);
        kFunTypeDict[kWebFuncTypeOpenPage] = @(GNHWebFuncTypeOpenPage);
        kFunTypeDict[kWebFuncTypeShare] = @(GNHWebFuncTypeShare);
        kFunTypeDict[kWebFuncTypeOpenApp] = @(GNHWebFuncTypeOpenApp);
        kFunTypeDict[kWebFuncTypeLeavePage] = @(GNHWebFuncTypeLeavePage);
        kFunTypeDict[kWebFuncTypeCameraAndAlbum] = @(GNHWebFuncTypeCameraAndAlbum);
        kFunTypeDict[kWebFuncTypeClearCache] = @(GNHWebFuncTypeClearCache);
        kFunTypeDict[kWebFuncTypeReload] = @(GNHWebFuncTypeReload);
        kFunTypeDict[kWebFuncTypeGetAppData] = @(GNHWebFuncTypeGetAppData);
        kFunTypeDict[kWebFuncTypeTokenAlert] = @(GNHWebFuncTypeTokenAlert);
        kFunTypeDict[kWebFuncTypeConfig] = @(GNHWebFuncTypeConfig);
        kFunTypeDict[kWebFuncTypeRightAction] = @(GNHWebFuncTypeRightAction);
        kFunTypeDict[kWebFuncTypeLeftAction] = @(GNHWebFuncTypeLeftAction);
        kFunTypeDict[kWebFuncTypeWebAppear] = @(GNHWebFuncTypeWebAppear);
        kFunTypeDict[kWebFuncTypeSetAppData] = @(GNHWebFuncTypeSetAppData);
        kFunTypeDict[kWebFuncTypeOpenSystemSetting] = @(GNHWebFuncTypeOpenSystemSetting);
        kFunTypeDict[kWebFuncTypeMainTabRoutes] = @(GNHWebFuncTypeMainTabRoutes);
        kFunTypeDict[kWebFuncTypeOCRAndLiving] = @(GNHWebFuncTypeOCRAndLiving);
        kFunTypeDict[kWebFuncTypeSetUserInfo] = @(GNHWebFuncTypeSetUserInfo);
        //兼容旧标识
        kFunTypeDict[@"Tokenalert"] = kFunTypeDict[kWebFuncTypeTokenAlert];
    }
    return kFunTypeDict;
}

- (void)dealloc {
//    NSLog(@"-->");
}

@end
