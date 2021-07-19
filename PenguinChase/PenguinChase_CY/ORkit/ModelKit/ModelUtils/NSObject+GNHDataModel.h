//
//  NSObject+DataModel.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/14.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "GNHBaseDataModel.h"

@interface NSObject (GNHDataModel)

/**
 * 显示业务通用类型错误
 */
+ (void)gnh_showCommonBussinessDataModelError:(GNHBaseDataModel *)gnhModel;

/**
 * 显示业务通用类型错误并默认文案
 */
+ (void)gnh_showCommonBussinessDataModelError:(GNHBaseDataModel *)gnhModel withDefaultErrorMessage:(NSString *)errorMessage;

/**
 * 显示业务通用类型错误并默认文案并消失回调 (block: showCompleted == YES 为自然结束)
 */
+ (void)gnh_showCommonBussinessDataModelError:(GNHBaseDataModel *)gnhModel withDefaultErrorMessage:(NSString *)errorMessage completedBlock:(dispatch_block_t)completedBlock;

/**
 * 显示业务通用类型错误
 */
- (void)gnh_showCommonBussinessDataModelError:(GNHBaseDataModel *)gnhModel;

/**
 * 显示业务通用类型错误并默认文案
 */
- (void)gnh_showCommonBussinessDataModelError:(GNHBaseDataModel *)gnhModel withDefaultErrorMessage:(NSString *)errorMessage;

/**
 * 显示业务通用类型错误并默认文案并消失回调 (block: showCompleted == YES 为自然结束)
 */
- (void)gnh_showCommonBussinessDataModelError:(GNHBaseDataModel *)gnhModel withDefaultErrorMessage:(NSString *)errorMessage completedBlock:(dispatch_block_t)completedBlock;

/**
 * 是否需要显示业务通用类型错误
 */
- (BOOL)gnh_shouldShowCommonBussinessDataModelError;

@end
