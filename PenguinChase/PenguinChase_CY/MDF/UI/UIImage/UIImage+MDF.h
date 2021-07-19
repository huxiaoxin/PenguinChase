//
//  UIImage+MDP.h
//  GeiNiHua
//
//  Created by ChenYuan on 17/3/24.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MDF)

// 通过颜色获取图片
+ (UIImage *)mdf_imageWithColor:(UIColor *)color
                   cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)mdf_imageFromColor:(UIColor *)color
                        forSize:(CGSize)size
               withCornerRadius:(CGFloat)radius;

+ (UIImage *)mdf_circularImageWithColor:(UIColor *)color
                                   size:(CGSize)size;

+ (UIImage *)mdf_imageWithColor:(UIColor *)color
                   cornerRadius:(CGFloat)cornerRadius
                    borderColor:(UIColor *)borderColor;

+ (UIImage *)mdf_imageWithColor:(UIColor *)color
                   cornerRadius:(CGFloat)cornerRadius
                    borderWidth:(CGFloat)borderWidth
                    borderColor:(UIColor *)borderColor;

+ (UIImage *)mdf_imageWithColor:(UIColor *)color
                           size:(CGSize)size
                           text:(NSString *)text
                           font:(UIFont *)font
                      textColor:(UIColor *)textColor
                   corderRadius:(CGFloat )cornerRadius;

@end

@interface UIImage (Color)

- (UIColor *)mdf_averageColor;

@end

@interface UIImage (Alpha)

- (BOOL)mdf_hasAlpha;
- (UIImage *)mdf_imageWithAlpha;
- (UIImage *)mdf_transparentBorderImage:(NSUInteger)borderSize;
- (UIImage *)mdf_newBorderMask:(NSUInteger)borderSize size:(CGSize)size;

@end


@interface UIImage (Resize)

- (UIImage *)mdf_croppedImage:(CGRect)bounds;
- (UIImage *)mdf_thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)mdf_resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)mdf_resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)mdf_resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;
- (CGAffineTransform)mdf_transformForOrientation:(CGSize)newSize;
- (UIImage*)mdf_fixOrientation;

@end

@interface UIImage (RoundedCorner)

- (UIImage *)mdf_roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
- (void)mdf_addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight;

@end


@interface UIImage (BlurredFrame)

- (UIImage *)mdf_applyLightBluredAtFrame:(CGRect)frame __attribute__((deprecated));

- (UIImage *)mdf_applyLightEffectAtFrame:(CGRect)frame;
- (UIImage *)mdf_applyExtraLightEffectAtFrame:(CGRect)frame;
- (UIImage *)mdf_applyDarkEffectAtFrame:(CGRect)frame;
- (UIImage *)mdf_applyTintEffectWithColor:(UIColor *)tintColor atFrame:(CGRect)frame;
- (UIImage *)mdf_applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage
                         atFrame:(CGRect)frame;
- (UIImage *)mdf_applyBlurWithRadius:(CGFloat)blurRadius
                 iterationsCount:(NSInteger)iterationsCount
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage
                         atFrame:(CGRect)frame;
@end


@interface UIImage (ImageEffects)

- (UIImage *)mdf_applyLightEffect;
- (UIImage *)mdf_applyExtraLightEffect;
- (UIImage *)mdf_applyDarkEffect;
- (UIImage *)mdf_applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)mdf_applyTintEffectWithColor:(UIColor *)tintColor alpha:(CGFloat)alpha;

- (UIImage *)mdf_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

- (UIImage *)mdf_applyBlurWithRadius:(CGFloat)blurRadius iterationsCount:(NSInteger)iterationsCount tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end


@interface UIImage (Stretch)

- (UIImage *)mdf_stretchableImageByCenter;
- (UIImage *)mdf_stretchableImageByHeightCenter;
- (UIImage *)mdf_stretchableImageByWidthCenter;

@end

