//
//  UIImage+Image.h
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-11.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 通过图片名获取图片
 注意：设置图片为空时，注意要设置image属性为nil,而非图片名为nil，否则会报：CUICatalog: Invalid asset name supplied: (null)
 */
#define MYNewImage(image) (image.length > 0 ? [UIImage imageNamed:image] : nil)

typedef enum MYImagePlace{//水印的位置
    MYImagePlaceWithLeftTop = 0,
    MYImagePlaceWithLeftBottom = 1,
    MYImagePlaceWithRightTop = 2,
    MYImagePlaceWithRightBottom = 3
}MYImagePlace;
@interface UIImage (Image)
/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (instancetype)resizableImage:(NSString *)name;
/**
 *  打水印（四个方位）
 *
 *  @param bg    背景图片名字
 *  @param logo  水印名字
 *  @param place 水印的位置（LeftTop，LeftBottom，RightTop，RightBottom)
 *  @param scale 水印的放缩比例
 */
+ (instancetype)waterImageWithBgNamed:(NSString *)bg
                         andLogoNamed:(NSString *)logo
                         andLogoPlace:(MYImagePlace)place
                         andLogoScale:(CGFloat)scale;
/**
 *  圆形裁剪（裁剪图片中心部分）
 *
 *  @param name        原图片名字
 *  @param borderWidth 边缘宽度
 *  @param borderColor 边缘背景色
 */
+ (instancetype)circleImageWithNamed:(NSString *)name
                      andBorderWidth:(CGFloat)borderWidth
                      andBorderColor:(UIColor *)borderColor;
/**
 *  屏幕截屏
 *
 *  @param view  截屏区域
 */
+ (instancetype)captureWithView:(UIView *)view;
/**
 *  返回一张可自由拉伸的图片
 */
+ (instancetype)resizedImageWithNamed:(NSString *)name;

/**
 *  返回一张可以随意拉伸边缘不变形的图片
 *
 *  @param name              图片名字
 *  @param imageResizingMode  拉伸模式   UIImageResizingModeTile 平铺,UIImageResizingModeStretch 拉长,
 */
+ (instancetype)resizableImageNamed:(NSString *)name
                       resizingMode:(UIImageResizingMode)imageResizingMode;


/** 获取图片的主色调 */
- (UIColor *)mostColor;

/** 获取App启动图片 */
+ (UIImage *)mdf_theLaunchImage;

@end

@interface UIImage (MDFTintColor)
/**
 纯色图片改变颜色
 
 @param color 颜色
 @return image
 */
- (instancetype)mdf_imagePureChangeColor:(UIColor *)color;
/**
 非纯色图片改变颜色
 
 @param color 颜色
 @return image
 */
- (instancetype)mdf_imageGradientChangeColor:(UIColor *)color;

@end

@interface UIImage (MDFQRCode)

/** 识别二维码 */
- (NSString *)mdf_readQRCode;

/** 生成二维码 */
+ (instancetype)mdf_QRCodeWithString:(NSString *)string;

@end

