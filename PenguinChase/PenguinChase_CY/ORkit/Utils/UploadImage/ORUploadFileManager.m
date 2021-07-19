//
//  ORUploadFileManager.m
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/12/8.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#import "ORUploadFileManager.h"
#import <Photos/Photos.h>
#import "UIImage+overturn.h"
#import "SVProgressHUD+ZY.h"

typedef void(^ZYCompressFileCompleteBlock)(NSData *data);

@interface ORUploadFileManager ()

@property (nonatomic, copy) ORUploadFileCompleteHandler completeHandler;
@property (nonatomic, strong) AVAsset *asset;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, copy) NSString *uploadType;

@end

@implementation ORUploadFileManager

- (void)uploadFileManager:(PHAsset *)asset completeHandler:(ORUploadFileCompleteHandler)completeHandler uploadType:(nonnull NSString *)uploadType
{
    self.uploadType = uploadType;
    if (asset.mediaType == PHAssetMediaTypeVideo) {
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHVideoRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        options.networkAccessAllowed = YES;
        [[PHImageManager defaultManager] requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            NSURL *fileRUL = [asset valueForKey:@"URL"];
            NSString *videoName = fileRUL.absoluteString.lastPathComponent;
            [self compressVideo:asset andVeidoName:videoName completeBlock:^(NSData *data) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (data) {
                        ORUploadFileDataModel *uploadFileDataModel = [self produceModel:[ORUploadFileDataModel class]];
                        uploadFileDataModel.completeHandler = completeHandler;
                        [uploadFileDataModel uploadFile:data andFileName:videoName andFileType:@"multipart/form-data" uploadType:uploadType];
                    } else {
                        if (completeHandler) {
                            completeHandler(NO, nil);
                        }
                    }
                });
            }];
        }];
    } else {
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
        option.networkAccessAllowed = YES;
        option.resizeMode = PHImageRequestOptionsResizeModeNone;
        option.synchronous = YES;
        option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
        //其他格式的图片，直接请求压缩后的图片
        [imageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                UIImage *image = [UIImage fixOrientation:result];
                NSData *imageData = [image ly_compressImageToByte:10.0 * 1024 * 1024];
                image = [UIImage imageWithData:imageData];
                NSString *imgName = @((NSInteger)([NSDate timeIntervalSinceReferenceDate] * 1000)).stringValue;
                imgName = [imgName stringByAppendingString:@".jpeg"];
                self.image = image;
                self.completeHandler = completeHandler;
                self.imgName = imgName;
                ORUploadFileDataModel *uploadFileDataModel = [self produceModel:[ORUploadFileDataModel class]];
                uploadFileDataModel.completeHandler = completeHandler;
                [uploadFileDataModel uploadFile:imageData andFileName:imgName andFileType:@"multipart/form-data" uploadType:uploadType];
            } else {
                if (self.completeHandler) {
                    self.completeHandler(NO, nil);
                }
            }
        }];
    }
}


- (CGFloat)fileSize:(NSURL *)path
{
    return [[NSData dataWithContentsOfURL:path] length]/1024.00 /1024.00;
}

- (void)compressVideo:(AVAsset *)asset andVeidoName:(NSString *)videoName completeBlock:(ZYCompressFileCompleteBlock)completeBlock
{
    //保存至沙盒路径
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *vedioPathStr = [pathDocuments stringByAppendingPathComponent:videoName];
    
    NSError *error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:vedioPathStr]) {
        [[NSFileManager defaultManager] removeItemAtPath:vedioPathStr error:&error];
    }
    
    //转码配置
    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    exportSession.shouldOptimizeForNetworkUse = YES;
    exportSession.outputURL = [NSURL fileURLWithPath:vedioPathStr];
    exportSession.outputFileType = AVFileTypeMPEG4;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        AVAssetExportSessionStatus exportStatus = exportSession.status;
        switch (exportStatus) {
            case AVAssetExportSessionStatusFailed: {
                NSError *exportError = exportSession.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                [SVProgressHUD showError:@"压缩失败..." completion:^{
                    if (completeBlock) {
                        completeBlock(nil);
                    }
                }];
                break;
            }
            case AVAssetExportSessionStatusCompleted: {
                NSLog(@"视频转码成功");
                [SVProgressHUD showSuccess:@"压缩成功..." completion:^{
                    NSData *data = [NSData dataWithContentsOfFile:vedioPathStr];
                    if (completeBlock) {
                        completeBlock(data);
                    }
                }];
                break;
            }
            default:
                break;
        }
    }];
}

#pragma mark - Upload Image

- (BOOL)uploadImageManager:(ZYFormData *)formData completeHandler:(ORUploadFileCompleteHandler)completeHandler uploadType:(nonnull NSString *)uploadType
{
    ORUploadFileDataModel *uploadFileDataModel = [self produceModel:[ORUploadFileDataModel class]];
    uploadFileDataModel.completeHandler = completeHandler;
    return [uploadFileDataModel uploadFile:formData.data andFileName:formData.filename andFileType:formData.mimeType uploadType:uploadType];
}

#pragma mark - Handle Data

- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelSuccess:gnhModel];
    if ([gnhModel isKindOfClass:[ORUploadFileDataModel class]]) {
        // 回调block，修改图片状态
        ORUploadFileDataModel *dataModel = (ORUploadFileDataModel *)gnhModel;
        NSString *url = dataModel.uploadFileItem.url;
        if (dataModel.completeHandler) {
            dataModel.completeHandler(YES, url);
        }
    }
}

- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    [super handleDataModelError:gnhModel];
    if ([gnhModel isKindOfClass:[ORUploadFileDataModel class]]) {
        // 回调block，修改图片状态
        ORUploadFileDataModel *dataModel = (ORUploadFileDataModel *)gnhModel;
        NSString *msg = dataModel.uploadFileItem.msg;
        if (!msg.length) {
            msg = @"服务繁忙，请稍后重试";
        }
        [SVProgressHUD dismiss];
        [SVProgressHUD showError:msg completion:^{
            if (dataModel.completeHandler) {
                dataModel.completeHandler(NO, nil);
            }
        }];
    }
}

@end
