//
//  ORUploadFileManager.h
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/12/8.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORUploadFileDataModel.h"
#import "ZYFormData.h"

@class PHAsset;

NS_ASSUME_NONNULL_BEGIN


@interface ORUploadFileManager : ORSingleton


/**
 上传照片、视频

 @param asset 照片、视频索引
 @param completeHandler 回调block
 @param uploadType 上传类型
 */
- (void)uploadFileManager:(PHAsset *)asset completeHandler:(ORUploadFileCompleteHandler)completeHandler uploadType:(NSString *)uploadType;


/**
 上传照片

 @param formData 照片格式化数据
 @param completeHandler 回调block
 @param uploadType 上传类型
 
 @return 请求是否发送，YES-发送，NO-失败
 */
- (BOOL)uploadImageManager:(ZYFormData *)formData completeHandler:(ORUploadFileCompleteHandler)completeHandler uploadType:(NSString *)uploadType;

@end

NS_ASSUME_NONNULL_END
