//
//  FilmFactoryMenuChannelManager.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/27.
//

#import "FilmFactoryMenuChannelManager.h"

#define ORMenuChannelKey @"MenuChannelKey"

@interface FilmFactoryMenuChannelManager ()

@property (nonatomic, strong) PandaMovieFetchChannelMenuDataModel *fetchChannelMenuDataModel; // 主菜单

@property (nonatomic, strong) NSMutableDictionary *menuDictory;
@property (nonatomic, strong) AFNetworkReachabilityManager *manager;

@end

@implementation FilmFactoryMenuChannelManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *dic =  (NSDictionary *)[ORUserDefaults objectForKey:ORMenuChannelKey];
        self.menuDictory = [dic mutableCopy];
        if (!self.menuDictory) {
            self.menuDictory = [NSMutableDictionary dictionary];
        }
        
        [self checkNetwork];
    }
    return self;
}

- (NSInteger)getVideoUserId:(NSString *)key
{
    NSString *value = [self.menuDictory mdf_stringForKey:key];
    if (!value.length) {
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        NSInteger valueId = interval;
        value = @(valueId).stringValue;
        [self.menuDictory mdf_safeSetObject:value forKey:key];
        
        [ORUserDefaults setObject:self.menuDictory forKey:ORMenuChannelKey];
        [ORUserDefaults synchronize];
    }
    
    return [value integerValue];
}

- (void)checkNetwork
{
    GNHWeakSelf;
    // 第一次进入界面
    // 检测网络
    [self hasNetwork:^(bool has) {
        if (!has) {
            // 没有网络
            [SVProgressHUD showInfoWithStatus:@"当前网络不可用，请检测您的网络设置"];
        } else {
            // 获取频道分类
            [weakSelf.fetchChannelMenuDataModel fetchChannelMenuWithScene:@"home"];
            
            //结束监听
            [weakSelf.manager stopMonitoring];
        }
    }];
}

- (void)hasNetwork:(void(^)(bool has))hasNet
{
    //创建网络监听对象
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    self.manager = manager;
    //开始监听
    [manager startMonitoring];
    //监听改变
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
                hasNet(NO);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                hasNet(YES);
                break;
        }
    }];
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
    
    if ([gnhModel isMemberOfClass:[PandaMovieFetchChannelMenuDataModel class]]) {
        // 存储数据
        [FilmFactoryMenuChannelManager sharedInstance].channelMenuItem = self.fetchChannelMenuDataModel.channelMenuItem;
    }
}

- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelError:gnhModel];
}

- (PandaMovieFetchChannelMenuDataModel *)fetchChannelMenuDataModel
{
    if (!_fetchChannelMenuDataModel) {
        _fetchChannelMenuDataModel = [self produceModel:[PandaMovieFetchChannelMenuDataModel class]];
    }
    return _fetchChannelMenuDataModel;
}

@end
