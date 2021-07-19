//
//  UIImageView+LYExt.m
//  Tools
//
//  Created by ChenYuan on 16/3/11.
//  Copyright © 2016年 ChenYuan. All rights reserved.
//

#import "UIImageView+LYExt.h"

@implementation UIImageView (LYExt)
+ (instancetype)ly_ImageViewWithImageName:(NSString *)imageName {
    UIImage *image;
    if (imageName.length > 0) {
        image = [UIImage imageNamed:imageName];
    }else {
        image = nil;
    }
    UIImageView *imageView = [[self alloc] initWithImage:image] ;
    return imageView;
}

@end
