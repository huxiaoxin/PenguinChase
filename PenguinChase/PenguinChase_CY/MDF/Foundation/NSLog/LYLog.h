//
//  LYLog.h
//  JavaScriptCoreDemo
//
//  Created by ChenYuan on 16/4/27.
//  Copyright © 2016年 jinguangbi. All rights reserved.
//

/** 打印日志格式 */
#ifdef __OBJC__

#ifdef DEBUG
#define NSLog(format, ...) do { \
    fprintf(stderr, "<%s : %d-Line> %s\n", \
    [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
    __LINE__, __func__); \
    (NSLog)((format), ##__VA_ARGS__); \
    fprintf(stderr, "--->˚<---\n"); \
} while (0)
#else
#define NSLog(...) {}
#endif

#endif

