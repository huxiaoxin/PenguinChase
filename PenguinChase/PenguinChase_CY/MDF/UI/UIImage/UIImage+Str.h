//
//  UIImage+Str.h
//  99fenqi
//
//  Created by ChenYuan on 16/5/6.
//  Copyright © 2016年 dingli. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImage (Str)

/** 通过base64字符串创建一张图片 */
+ (nullable instancetype)imageWithBase64:(NSString *)imageStr;
+ (void)imageWithBase64:(NSString *)imageStr completion:(void (^ __nullable)(UIImage * _Nullable image))completion;
/** 图片转化为base64字符串 */
- (nullable NSString *)base64;

@end
NS_ASSUME_NONNULL_END
