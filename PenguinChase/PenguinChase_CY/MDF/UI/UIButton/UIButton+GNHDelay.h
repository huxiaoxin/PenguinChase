//
//  UIButton+GNHDelay.h
//  GeiNiHua
//
//  Created by ChenYuan on 2017/3/17.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (GNHDelay)

@property (nonatomic, assign) NSTimeInterval clickDurationTime;
@property (nonatomic, assign) BOOL isIgnoreEvent;

@end
