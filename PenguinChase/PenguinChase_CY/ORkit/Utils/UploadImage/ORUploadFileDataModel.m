//
//  ORUploadFileDataModel.m
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/12/8.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#import "ORUploadFileDataModel.h"
#import <CoreServices/CoreServices.h>
#import <AFNetworking.h>

@implementation ORUploadFileItem

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"data"]) {
        return [NSString class];
    }
    
    return [super classForObject:arrayElement inArrayWithPropertyName:propertyName];
}

@end

@interface ORUploadFileDataModel ()

@end
@implementation ORUploadFileDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORUploadFileAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [ORUploadFileItem class];
    }
    return self;
}

- (BOOL)uploadFile:(NSData *)fileData andFileName:(NSString *)fileName andFileType:(NSString *)fileType uploadType:(nonnull NSString *)uploadType
{
    if (self.isLoading) {
        return NO;
    }
    
    if (!fileData) {
        return NO;
    }
    
    MDFFileUploadItem *fileUploadItem = [[MDFFileUploadItem alloc] init];
    fileUploadItem.fileData = fileData;
    fileUploadItem.name = @"file";
    fileUploadItem.fileName = fileName;
    fileUploadItem.mimeType = AFContentTypeForPathExtension(fileType);
    
    self.fileParam = fileUploadItem;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uploadType"] = uploadType; // AVATAR, IDCARD
    self.params = params;
    
    return [super load];
}

static inline NSString * AFContentTypeForPathExtension(NSString *extension) {
#ifdef __UTTYPE__
    NSString *UTI = (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)extension, NULL);
    NSString *contentType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)UTI, kUTTagClassMIMEType);
    if (!contentType) {
        return @"multipart/form-data";
    } else {
        return contentType;
    }
#else
#pragma unused (extension)
    return @"application/octet-stream";
#endif
}

- (AFHTTPSessionManager *)beforeSendRequest:(AFHTTPSessionManager *)sessionManager
{
    AFHTTPSessionManager *session = [super beforeSendRequest:sessionManager];
    [session.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    return session;
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _uploadFileItem = (ORUploadFileItem *)self.parsedItem;
    }
}


@end
