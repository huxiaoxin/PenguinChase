//
//  UIImage+overturn.h
//  GeiNiHua
//
//  Created by VierGhost on 16/8/16.
//  Copyright © 2016年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (overturn)

- (UIImage *)fixOrientation:(UIImage *)aImage;
+ (UIImage *)fixOrientation:(UIImage *)aImage;

@end
