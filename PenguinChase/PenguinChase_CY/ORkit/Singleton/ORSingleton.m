//
//  ORSingleton.m
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/11/3.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#import "ORSingleton.h"

@interface ORSingleton ()

@property (nonatomic, strong) NSMutableArray *models;

@end

@implementation ORSingleton

- (void)dealloc
{
    if (_models) {
        [_models enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[GNHBaseDataModel class]]) {
                [(GNHBaseDataModel *)obj cancel];
            }
        }];
    }
}

- (NSMutableArray *)models
{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

@end

#pragma mark - model & network UIs

@implementation ORSingleton (Model)

// 配置mdoel GNHBaseDataModel
- (GNHBaseDataModel*)produceModel:(Class)modelClass
{
    GNHBaseDataModel* rawModel = [[modelClass alloc] init];
    [self.models mdf_safeAddObject:rawModel];
    
    __weak typeof(self) weakself = self;
    [rawModel setCompletionBlock:^(id <MDFNetworkModelProtocol> model){
        GNHBaseDataModel *gnhModel = (GNHBaseDataModel *)model;
        GNHRootBaseItem *baseItem = nil;
        if ([gnhModel.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
            baseItem = (GNHRootBaseItem *)gnhModel.parsedItem;
        }
        
        // 兜底SVProgressHUD 模态请求后dissmiss逻辑异常
        if (!gnhModel.disableAutoDismiss && gnhModel.isResponseSucess) {
            [SVProgressHUD dismiss];
        }
        
        // 网络数据
        if (gnhModel.isServerDataCorrectAndNetworkRequestSuccess) {
            [weakself handleDataModelSuccess:gnhModel];
        } else {
            [weakself handleDataModelError:gnhModel];
        }
    }];
    
    return rawModel;
}

//请求成功
- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    
}

//请求失败
- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    
}

@end
