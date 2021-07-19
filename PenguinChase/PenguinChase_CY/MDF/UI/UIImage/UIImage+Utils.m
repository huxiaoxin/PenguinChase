//
//  UIImage+Utils.m
//  WNCompany
//
//  Created by gaoxin on 15/1/13.
//  Copyright (c) 2015年 SimGao. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

+ (NSData *)reSizeImageData:(UIImage *)sourceImage widthAndHeightMaxSize:(CGFloat)widthAndHeightMaxSize maxSize:(CGFloat)maxSize {
    UIImage *image = [sourceImage scaleImageWithImgLength:widthAndHeightMaxSize];
    return [UIImage compressImage:image toMaxLength:maxSize];
}

+ (NSData *)compressImage:(UIImage *)image toMaxLength:(NSInteger)maxLength{
    CGFloat compress = 0.9f;
    NSData *data = UIImageJPEGRepresentation(image, compress);
    
    while (data.length > maxLength && compress > 0.1) {
        compress -= 0.1f;
        
        data = UIImageJPEGRepresentation(image, compress);
    }
    return data;
}

- (NSData *)ly_compressImageToByte:(NSInteger)maxLength {
    CGFloat compress = 1;
    NSData *data = UIImageJPEGRepresentation(self, compress);
    if (data.length < maxLength) {
        return data;
    }
    
    CGFloat min = 0;
    CGFloat max = 1;
    for (NSInteger i = 0; i < 6; i++) {
        compress = (max + min) * 0.5;
        data = UIImageJPEGRepresentation(self, compress);
        if (data.length < maxLength * 0.9) {
            min = compress;
        } else if (data.length > maxLength) {
            max = compress;
        } else {
            break;
        }
    }
    if (data.length < maxLength) {
        return data;
    }
    
    NSUInteger lastDataLength = 0;
    UIImage *resultImage = [UIImage imageWithData:data];
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake(resultImage.size.width * sqrtf(ratio), resultImage.size.height * sqrtf(ratio));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compress);
    }
    return data;
}


// 等比例缩放
- (instancetype)scaleToSize:(CGSize)size {
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1) {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    } else {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (CGSize)getScaleSizeByWidth:(CGFloat)width
{
    float tmpWid = width;
    float tmpHei = (self.size.height/self.size.width) * tmpWid;
    return CGSizeMake(tmpWid, tmpHei);
}

#pragma mark - 返回一张可自由拉伸的图片
+ (instancetype)resizedImage:(UIImage *)image
{
    return [self resizedImage:image left:0.5 top:0.5];
}

#pragma mark - 返回一张可自由拉伸的图片,以左上角为扩展点
+ (instancetype)resizedLeftImage:(UIImage *)image {
    return [self resizedImage:image left:0.1 top:0.1];
}

+ (instancetype)resizedImage:(UIImage *)image left:(CGFloat)left top:(CGFloat)top {
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

/** 返回一张该图片宽、高都在imgLength范围内的新图片 */
- (instancetype)scaleImageWithImgLength:(CGFloat)imgLength {
    CGFloat newWidth = 0.0f;
    CGFloat newHeight = 0.0f;
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    
    if (width > imgLength || height > imgLength){
        
        if (width > height) {
            
            newWidth = imgLength;
            newHeight = newWidth * height / width;
            
        }else if(height > width){
            newHeight = imgLength;
            newWidth = newHeight * width / height;
            
        }else{
            newWidth = imgLength;
            newHeight = imgLength;
        }
        
    }else {
        return self;
    }
    
    
    CGRect rect = CGRectMake(0, 0, newWidth, newHeight);
    
    // 开始上下文 目标大小是 这么大
    UIGraphicsBeginImageContext(rect.size);
    
    // 在指定区域内绘制图像
    [self drawInRect:rect];
    
    // 从上下文中获得绘制结果
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文返回结果
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (instancetype)imageWithBase64:(NSString *)imageStr {
    UIImage *image;
    if (imageStr.length > 0) {
        NSData *decodeImageData = [[NSData alloc] initWithBase64EncodedString:imageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
        if (decodeImageData) {
            image = [self imageWithData:decodeImageData];
        }
    }else {
        NSLog(@"base64字符串为''");
    }
    return image;
}

+ (void)imageWithBase64:(NSString *)imageStr completion:(void (^)(UIImage *))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [self imageWithBase64:imageStr];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
        }
    });
}

- (NSString *)base64 {
    NSData *data = UIImageJPEGRepresentation(self, 1.0f);
    NSString *encodeImageStr = [data base64EncodedStringWithOptions:0];
    return encodeImageStr;
}

@end
