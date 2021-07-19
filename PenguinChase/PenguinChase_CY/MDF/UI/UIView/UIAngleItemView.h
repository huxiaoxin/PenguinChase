//
//  UIAngleItemView.h
//  ZhangYuSports
//
//  Created by bingbai on 2019/11/25.
//  Copyright © 2019 ChenYuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAngleItemView : UIImageView{
    UILabel* countLa;
}

@property(nonatomic,strong) UILabel* countLa;

-(void)toChangeAngleFrameWith:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
