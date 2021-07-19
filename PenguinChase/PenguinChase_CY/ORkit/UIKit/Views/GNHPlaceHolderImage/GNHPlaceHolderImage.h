//
//  GNHPlaceHolderImage.h
//  GeiNiHua
//
//  Created by 蔡儒楠 on 2017/12/26.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GNHPlaceHolderImageMaskType) {
    GNHPlaceHolderImageMaskTypeDefault = 1 << 0, // 默认灰色趁色
    GNHPlaceHolderImageMaskTypeLight = 1 << 1, // 白色底部遮罩
    GNHPlaceHolderImageMaskTypeGray = 1 << 2, // 灰色底部遮罩
};

@interface GNHPlaceHolderImage : UIImage

+ (UIImage *)composedPlaceHolderImage:(CGRect)frame mask:(GNHPlaceHolderImageMaskType)maskType;

@end
