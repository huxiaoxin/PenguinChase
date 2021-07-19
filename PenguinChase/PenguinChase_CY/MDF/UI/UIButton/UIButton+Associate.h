//
//  UIButton+Associate.h
//  99fenqi-Beta1
//
//  Created by VierGhost on 15/7/15.
//  Copyright (c) 2015年 dingli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Associate)

- (void)setUserInfo:(NSString *)userInfo;
- (void)setUserInfo2:(NSDictionary *)userInfo2;

- (NSString *)getUserInfo;
- (NSDictionary *)getUserInfo2;

@end
