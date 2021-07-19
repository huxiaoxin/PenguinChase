//
//  UIImageView+LYExt.h
//  Tools
//
//  Created by ChenYuan on 16/3/11.
//  Copyright © 2016年 ChenYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LYExt)

/** 快速创建ImageView
 *
 *  @param  imageName  图片名
 *
 *  @return ImageView  返回ImageView对象
 */
+ (instancetype)ly_ImageViewWithImageName:(NSString *)imageName;

@end
