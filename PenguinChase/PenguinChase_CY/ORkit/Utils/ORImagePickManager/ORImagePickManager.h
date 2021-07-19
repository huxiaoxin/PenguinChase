//
//  ORImagePickManager.h
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/12/6.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#import "ORSingleton.h"
#import <Photos/Photos.h>
#import "ZYImagePicker.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ORImagePickManagerHandler)(NSArray <PHAsset *> *assets, NSArray <NSString *> *identifiers, NSArray *thumbnailImages);

typedef void(^ZYImagePickImageHandler)(UIImage *image, ZYFormData *imageData);

@interface ORImagePickManager : ORSingleton
/**
 获取头像照片（相机、相册），需要裁剪

 @param completeHandler 回调
 */
- (void)pickCircleImage:(ZYImagePickImageHandler)completeHandler;

/**
 获取方形照片（相机、相册）

 @param completeHandler 回调，
 */
- (void)pickSquareImage:(ZYImagePickImageHandler)completeHandler;

- (void)pickImage:(ZYImagePickImageHandler)completeHandler;

// 拍摄照片
- (void)pickCameraImage:(ORImagePickManagerHandler)completeHandler;

@end

NS_ASSUME_NONNULL_END
