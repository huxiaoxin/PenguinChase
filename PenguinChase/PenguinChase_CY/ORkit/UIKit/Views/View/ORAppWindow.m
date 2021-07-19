//
//  ORAppWindow.m
//  AiQiu
//
//  Created by ChenYuan on 2020/6/2.
//  Copyright © 2020 lesports. All rights reserved.
//

#import "ORAppWindow.h"

@implementation ORAppWindow

/** 获取当前Window */
+ (UIWindow *)appWindow
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    //app Window的windowLevel默认是UIWindowLevelNormal
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    return window;
}

@end
