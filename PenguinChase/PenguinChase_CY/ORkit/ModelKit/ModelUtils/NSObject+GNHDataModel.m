//
//  NSObject+DataModel.m
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/14.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "NSObject+GNHDataModel.h"

static NSString *const GNHNetworkStatusError = @"网络不佳，请检查您的网络设置";
static NSString *const GNHNetworkRequestError = @"服务正忙，请稍后重试";

@implementation NSObject (GNHDataModel)

+ (void)gnh_showCommonBussinessDataModelError:(GNHBaseDataModel *)gnhModel
{
    [[[self alloc] init] gnh_showCommonBussinessDataModelError:gnhModel];
}

+ (void)gnh_showCommonBussinessDataModelError:(GNHBaseDataModel *)gnhModel withDefaultErrorMessage:(NSString *)errorMessage
{
    [[[self alloc] init] gnh_showCommonBussinessDataModelError:gnhModel withDefaultErrorMessage:errorMessage];
}

+ (void)gnh_showCommonBussinessDataModelError:(GNHBaseDataModel *)gnhModel withDefaultErrorMessage:(NSString *)errorMessage completedBlock:(dispatch_block_t)completedBlock
{
    [[[self alloc] init] gnh_showCommonBussinessDataModelError:gnhModel withDefaultErrorMessage:errorMessage completedBlock:completedBlock];
}

- (void)gnh_showCommonBussinessDataModelError:(GNHBaseDataModel *)gnhModel
{
    [self gnh_showCommonBussinessDataModelError:gnhModel withDefaultErrorMessage:nil];
}

- (void)gnh_showCommonBussinessDataModelError:(GNHBaseDataModel *)gnhModel withDefaultErrorMessage:(NSString *)errorMessage
{
    [self gnh_showCommonBussinessDataModelError:gnhModel withDefaultErrorMessage:errorMessage completedBlock:nil];
}

- (void)gnh_showCommonBussinessDataModelError:(GNHBaseDataModel *)gnhModel withDefaultErrorMessage:(NSString *)errorMessage completedBlock:(dispatch_block_t)completedBlock
{
    // 不需要显示toast时，直接return 
    if (![self gnh_shouldShowCommonBussinessDataModelError]){
        return;
    }
    
    // 反复load数据的时候，可能会收到NSURLErrorCancelled(-999)的错误，而数据是正常得到的，此时不显示错误提示
    if (gnhModel.error.code == NSURLErrorCancelled) {
        return;
    }
    
    NSString *errorMsg = GNHNetworkRequestError;
    if (errorMessage.length) {
        errorMsg = errorMessage;
    } else if (gnhModel.error.code == NSURLErrorNotConnectedToInternet) {
        errorMsg = GNHNetworkStatusError;
    }
    GNHRootBaseItem *rootBaseItem = (GNHRootBaseItem *)gnhModel.parsedItem;
    if (rootBaseItem && [rootBaseItem isKindOfClass:[GNHRootBaseItem class]]) {
        if (rootBaseItem.msg.length) {
            errorMsg = rootBaseItem.msg;
        }
    }
    [SVProgressHUD showInfoWithStatus:errorMsg];
}

- (BOOL)gnh_shouldShowCommonBussinessDataModelError
{
    return YES;
}

@end
