//
//  UIButton+Associate.m
//  99fenqi-Beta1
//
//  Created by VierGhost on 15/7/15.
//  Copyright (c) 2015年 dingli. All rights reserved.
//

#import "UIButton+Associate.h"
#import <objc/runtime.h>

char* const ASSOCIATION_STRING_USER_INFO = "ASSOCIATION_STRING_USER_INFO";
char* const ASSOCIATION_STRING_USER_INFO2 = "ASSOCIATION_STRING_USER_INFO2";
@implementation UIButton (Associate)

- (void)setUserInfo:(NSString *)userInfo {
    objc_setAssociatedObject(self, &ASSOCIATION_STRING_USER_INFO, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)getUserInfo {
    return objc_getAssociatedObject(self, &ASSOCIATION_STRING_USER_INFO);
}
- (void)setUserInfo2:(NSDictionary *)userInfo2 {
    objc_setAssociatedObject(self, &ASSOCIATION_STRING_USER_INFO2, userInfo2, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSDictionary *)getUserInfo2 {
    return objc_getAssociatedObject(self, &ASSOCIATION_STRING_USER_INFO2);
}

@end
