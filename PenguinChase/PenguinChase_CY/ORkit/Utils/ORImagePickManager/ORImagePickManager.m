//
//  ORImagePickManager.m
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/12/6.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#import "ORImagePickManager.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "SVProgressHUD+ZY.h"

@interface ORImagePickManager () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) NSMutableArray *saveAssetIds;
@property (nonatomic, strong) NSMutableArray *thumbnailImages;
@property (nonatomic, assign) CGSize assetSize;

@property (nonatomic, copy) ORImagePickManagerHandler completeHandler;
@property (nonatomic, copy) ZYImagePickImageHandler imageCompleteHandler;
@property (nonatomic, strong) ZYImagePicker *imagePicker;

@property(nonatomic, strong) UIImagePickerController *ipc;

@end

@implementation ORImagePickManager

#pragma mark -- UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSLog(@"imageSize: %lf, %lf", image.size.width, image.size.height);
        // 如果方向不对
        if (image.imageOrientation != UIImageOrientationUp) {
            image = [image fixOrientation:image];
        }
        
        //当image从相机中获取的时候存入相册中
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
            if (status == PHAuthorizationStatusAuthorized) {
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            } else if (status == PHAuthorizationStatusNotDetermined) {
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                     if (status == PHAuthorizationStatusAuthorized) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
                         });
                     }
                 }];
            } else {
                [self.ipc dismissViewControllerAnimated:YES completion:^{
                    [SVProgressHUD showInfoWithStatus:@"没有相册访问权限"];
                }];
            }
        }
    }
}

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (error) {
        NSLog(@"保存失败");
    } else{
        NSLog(@"保存成功");
        
        NSMutableArray *assets = [self GetALLphotosUsingPohotKit];
        if (assets.count > 0) {
            //获取最后一张图片
            PHAsset *asset = assets[assets.count - 1];
            CGFloat sizeHeight = (kScreenWidth - 3.0) / 4;
            CGSize assetSize = CGSizeMake(sizeHeight, sizeHeight);
            
            NSMutableArray *thumail = [NSMutableArray array];
            PHImageRequestOptions *options = [PHImageRequestOptions new];
            options.synchronous = true;
            options.networkAccessAllowed = true;
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:assetSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                [thumail mdf_safeAddObject:result];
            }];
            self.completeHandler(@[asset], @[asset.localIdentifier], thumail);
        }
    }
    [self.ipc dismissViewControllerAnimated:YES completion:nil];
}

-(NSMutableArray*)GetALLphotosUsingPohotKit
{
    NSMutableArray *arr = [NSMutableArray array];
    // 所有智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (NSInteger i = 0; i < smartAlbums.count; i++) {
        // 是否按创建时间排序
        PHFetchOptions *option = [[PHFetchOptions alloc] init];
        option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
        PHCollection *collection = smartAlbums[i];
        //遍历获取相册
        
        NSLog(@"%@", collection.localizedTitle);
        
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            if ([collection.localizedTitle isEqualToString:@"All Photos"] || [collection.localizedTitle isEqualToString:@"Camera Roll"] || [collection.localizedTitle isEqualToString:@"相机胶卷"] || [collection.localizedTitle isEqualToString:@"所有照片"] || [collection.localizedTitle isEqualToString:@"最近项目"]) {
                PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
                PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
                NSArray *assets;
                if (fetchResult.count > 0) {
                    // 某个相册里面的所有PHAsset对象
                    assets = [self getAllPhotosAssetInAblumCollection:assetCollection ascending:YES ];
                    [arr addObjectsFromArray:assets];
                }
            }
        }
    }
    //返回相机胶卷内的所有照片数组
    return arr;
}

- (NSArray *)getAllPhotosAssetInAblumCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending
{
    // 存放所有图片对象
    NSMutableArray *assets = [NSMutableArray array];
    // 是否按创建时间排序
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    // 获取所有图片对象
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    // 遍历
    [result enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
        [assets addObject:asset];
    }];
    return assets;
}

#pragma mark - ZYImagePicker delegate

- (void)pickCameraImage:(ORImagePickManagerHandler)completeHandler
{
    UIViewController *viewController = [UIViewController mdf_toppestViewController];
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSLog(@"无权限访问摄像头");
        return;
    }
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.ipc.sourceType = sourceType;
        self.ipc.modalPresentationStyle = UIModalPresentationFullScreen;
        [viewController presentViewController:self.ipc animated:YES completion:^{
            self.ipc.delegate = self;
        }];
        self.ipc.delegate = self;
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
    self.completeHandler = completeHandler;
}

- (void)pickImage:(ZYImagePickImageHandler)completeHandler
{
    GNHWeakSelf;
    UIViewController *viewController = [UIViewController mdf_toppestViewController];
    [viewController gnh_showSheetWithTitle:nil message:nil appearanceProcess:^(GNHAlertController *alertMaker) {
        alertMaker.addActionDefaultTitle(@"从相册选择");
        alertMaker.addActionDefaultTitle(@"拍照");
        alertMaker.addActionCancelTitle(@"取消");
    } actionsBlock:^(NSInteger index, UIAlertAction *action, GNHAlertController *alertMaker) {
        GNHWeakObj(viewController);
        if ([action.title isEqualToString:@"拍照"]) {
            [weakSelf.imagePicker cameraPhotoWithController:weakviewController compressWidth:500.0f formDataBlock:^(UIImage *image, ZYFormData *formData) {
                if (completeHandler) {
                      completeHandler(image, formData);
                  }
            }];
        } else if ([action.title isEqualToString:@"从相册选择"]) {
            [weakSelf.imagePicker libraryPhotoWithController:weakviewController compressWidth:500 formDataBlock:^(UIImage *image, ZYFormData *formData) {
                if (completeHandler) {
                    completeHandler(image, formData);
                }
            }];
        }
    }];
}

- (void)pickCircleImage:(ZYImagePickImageHandler)completeHandler
{
    GNHWeakSelf;
    UIViewController *viewController = [UIViewController mdf_toppestViewController];
    [viewController gnh_showSheetWithTitle:@"上传头像" message:nil appearanceProcess:^(GNHAlertController *alertMaker) {
        alertMaker.addActionDefaultTitle(@"从相册选择");
        alertMaker.addActionDefaultTitle(@"拍照");
        alertMaker.addActionCancelTitle(@"取消");
    } actionsBlock:^(NSInteger index, UIAlertAction *action, GNHAlertController *alertMaker) {
        GNHWeakObj(viewController);
        if ([action.title isEqualToString:@"拍照"]) {
            [weakSelf.imagePicker cameraPhotoWithController:weakviewController cropSize:CGSizeMake(200, 200) imageScale:2 isCircular:true formDataBlock:^(UIImage *image, ZYFormData *formData) {
                if (completeHandler) {
                    completeHandler(image, formData);
                }
            }];
        } else if ([action.title isEqualToString:@"从相册选择"]) {
            [weakSelf.imagePicker libraryPhotoWithController:weakviewController cropSize:CGSizeMake(200, 200) imageScale:2 isCircular:true formDataBlock:^(UIImage *image, ZYFormData *formData) {
                if (completeHandler) {
                    completeHandler(image, formData);
                }
            }];
        }
    }];
}

- (void)pickSquareImage:(ZYImagePickImageHandler)completeHandler {
    GNHWeakSelf;
    UIViewController *viewController = [UIViewController mdf_toppestViewController];
    [viewController gnh_showSheetWithTitle:nil message:nil appearanceProcess:^(GNHAlertController *alertMaker) {
        alertMaker.addActionDefaultTitle(@"从相册选择");
        alertMaker.addActionDefaultTitle(@"拍照");
        alertMaker.addActionCancelTitle(@"取消");
    } actionsBlock:^(NSInteger index, UIAlertAction *action, GNHAlertController *alertMaker) {
        GNHWeakObj(viewController);
        if ([action.title isEqualToString:@"拍照"]) {
            [weakSelf.imagePicker cameraPhotoWithController:weakviewController cropSize:CGSizeMake(200, 200) imageScale:2 isCircular:false formDataBlock:^(UIImage *image, ZYFormData *formData) {
                if (completeHandler) {
                    completeHandler(image, formData);
                }
            }];
        } else if ([action.title isEqualToString:@"从相册选择"]) {
            [weakSelf.imagePicker libraryPhotoWithController:weakviewController cropSize:CGSizeMake(200, 200) imageScale:2 isCircular:false formDataBlock:^(UIImage *image, ZYFormData *formData) {
                if (completeHandler) {
                    completeHandler(image, formData);
                }
            }];
        }
    }];
}

#pragma mark - Properties

- (ZYImagePicker *)imagePicker
{
    if (!_imagePicker) {
        _imagePicker = [[ZYImagePicker alloc] init];
    }
    return _imagePicker;
}

- (UIImagePickerController *)ipc
{
    if (!_ipc) {
        _ipc = [[UIImagePickerController alloc] init];
        _ipc.allowsEditing = false;
    }
    return _ipc;
}

@end
