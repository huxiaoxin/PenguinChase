//
//  GNHPlaceHolderImage.m
//  GeiNiHua
//
//  Created by 蔡儒楠 on 2017/12/26.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "GNHPlaceHolderImage.h"

static CGFloat const centerImgWidth = 174.f / 2.f;
static CGFloat const centerImgHeight = 77.f / 2.f;

@implementation GNHPlaceHolderImage

+ (UIImage *)composedPlaceHolderImage:(CGRect)frame mask:(GNHPlaceHolderImageMaskType)maskType {
    
    if (frame.size.width == 0 || frame.size.height == 0) {
        return [UIImage imageNamed:@"placeholder_centerimg"];
    }
    
    UIImage *centerImg = [UIImage imageNamed:@"placeholder_centerimg"];
   
    NSString *maskImgString = @"";
    if (maskType == GNHPlaceHolderImageMaskTypeLight) {
        maskImgString = @"placeholder_imgmask_white";
    } else if (maskType == GNHPlaceHolderImageMaskTypeGray) {
        maskImgString = @"placeholder_imgmask_gray";
    } else {
        maskImgString = @"placeholder_imgmask_gray";
    }

    UIImage *maskImg = [self clipImage:[UIImage imageNamed:maskImgString] Width:frame.size.width Height:frame.size.height];
    
    CGImageRef maskImgRef = maskImg.CGImage;
    CGFloat maskImgRefWidth = CGImageGetWidth(maskImgRef);
    CGFloat maskImgRefHeight = CGImageGetHeight(maskImgRef);

    CGFloat centerImgBeginPointX = (maskImgRefWidth - centerImgWidth) / 2.f;
    CGFloat centerImgBeginPointH = (maskImgRefHeight - centerImgHeight) / 2.f;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(maskImgRefWidth, maskImgRefHeight), YES, [UIScreen mainScreen].scale);
    [maskImg drawInRect:CGRectMake(0, 0, maskImgRefWidth, maskImgRefHeight)];
    [centerImg drawInRect:CGRectMake(centerImgBeginPointX, centerImgBeginPointH, centerImgWidth, centerImgHeight)];
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImg;
}

+ (UIImage *)clipImage:(UIImage *)targetImg Width:(CGFloat)width Height:(CGFloat)height {

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), YES, 1);
    
    // 首页超宽图片兼容处理
    CGRect targetRect = CGRectMake(0, 0, width, height);
    if (width / height > 3.5) {
        targetRect.size.height = height * 2;
    } else if (height / width > 3.5) {
        targetRect.size.width = width * 2;
    }

    // 将图片按照指定大小绘制
    [targetImg drawInRect:targetRect];
    
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

@end
