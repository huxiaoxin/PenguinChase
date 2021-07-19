//
//  ORUploadFileDataModel.h
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/12/8.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ORUploadFileCompleteHandler)(BOOL isSuccess, NSString * __nullable url);

@interface ORUploadFileItem : GNHRootBaseItem

@property (nonatomic, copy) NSString *orangeFileName; // 源文件上传地址
@property (nonatomic, copy) NSString *orangeFileSuffix; // 源文件的类型, jpeg····
@property (nonatomic, copy) NSString *url; // 文件对应URL地址

@end

@interface ORUploadFileDataModel : GNHBaseDataModel

@property (nonatomic, copy) ORUploadFileCompleteHandler completeHandler;
@property (nonatomic, strong) ORUploadFileItem *uploadFileItem;

- (BOOL)uploadFile:(NSData *)fileData andFileName:(NSString *)fileName andFileType:(NSString *)fileType uploadType:(NSString *)uploadType;

@end

NS_ASSUME_NONNULL_END
