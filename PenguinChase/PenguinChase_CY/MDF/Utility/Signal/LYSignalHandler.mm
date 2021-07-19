//
//  LYSignalHandler.m
//  99fenqi
//
//  Created by ChenYuan on 16/5/13.
//  Copyright © 2016年 dingli. All rights reserved.
//

#import "LYSignalHandler.h"
#import <UIKit/UIKit.h>
#import <libkern/OSAtomic.h>
#import <execinfo.h>

NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey = @"UncaughtExceptionHandlerAddressesKey";
volatile int32_t UncaughtExceptionCount = 0; /**< 当前处理的异常个数 */
volatile int32_t UncaughtExceptionMaximum = 10; /**< 最大能够处理的异常个数 */
const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;

@interface LYSignalHandler () {
    BOOL _isDismissed;
}
- (void)HandleException:(NSException *)exception;
+ (NSArray *)backtrace;
@end

NSString *getAppInfo();

/** 捕获信号后的回答函数 */
void HandleException(int signo) {
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaximum) {
        return;
    }
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:signo] forKey:UncaughtExceptionHandlerSignalKey];
    
    NSArray *callStack = [LYSignalHandler backtrace];
    userInfo[UncaughtExceptionHandlerAddressesKey] = callStack;
    
    
    NSException *ex = [NSException exceptionWithName:UncaughtExceptionHandlerSignalExceptionName reason:[NSString stringWithFormat:@"Signal %d was raised.\n%@", signo, getAppInfo()] userInfo:userInfo];
    //处理异常消息
    [[LYSignalHandler sharedLYSignalHandler] performSelectorOnMainThread:@selector(HandleException:)withObject:ex waitUntilDone:YES];
}

/** 获取错误日志 */
NSString *getAppInfo() {
    NSString *app_name = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey];
    NSString *shortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *device = [UIDevice currentDevice].model;
    NSString *os_name = [UIDevice currentDevice].systemName;
    NSString *os_version = [UIDevice currentDevice].systemVersion;
    UIUserInterfaceIdiom udid = [UIDevice currentDevice].userInterfaceIdiom;
    
    NSString *appInfo = [NSString stringWithFormat:@"App : %@ %@(%@)\nDevice : %@\nOS Version : %@ %@\nUDID : %ld\n", app_name, shortVersion, version, device, os_name, os_version, (long)udid];
    NSLog(@"Crash!!!! %@", appInfo);
    return appInfo;
}




@implementation LYSignalHandler
singleton_implementation(LYSignalHandler)

+ (void)registerSignalHandler {
    //注册程序由于abort()函数调用发生的程序中止信号
    signal(SIGABRT, HandleException);
    //注册程序由于非法指令产生的程序中止信号
    signal(SIGILL, HandleException);
    //注册程序由于无效内存的引用导致的程序中止信号
    signal(SIGSEGV, HandleException);
    //注册程序由于浮点数异常导致的程序中止信号
    signal(SIGFPE, HandleException);
    //注册程序由于内存地址未对齐导致的程序中止信号
    signal(SIGBUS, HandleException);
    //程序通过端口发送消息失败导致的程序中止信号
    signal(SIGPIPE, HandleException);
}

//处理异常用到的方法
- (void)HandleException:(NSException *)exception {
    /**
     *  获取异常崩溃信息
     */
    NSArray *callStack = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *content = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@\ncallStackSymbols1:\n%@",name,reason, [[exception userInfo] objectForKey:UncaughtExceptionHandlerAddressesKey], callStack];
    [LYSignalHandler sendMailWithContent:content];
    
    
    NSString *title = @"程序出现问题啦";
    NSString *message = [NSString stringWithFormat:@"你可以尝试继续，但应用程序可能不稳定!"];
    NSString *cancelTitle = @"放弃";
    NSString *otherTitle = @"继续";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    [alert show];

    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    //当接收到异常处理消息时，让程序开始runloop，防止程序死亡
    while (!_isDismissed) {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
    //当点击弹出视图的Cancel按钮哦,isDimissed ＝ YES,上边的循环跳出
    CFRelease(allModes);
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:UncaughtExceptionHandlerSignalExceptionName]) {
        kill(getpid(), [[[exception userInfo] objectForKey:UncaughtExceptionHandlerSignalKey] intValue]);
    } else {
        [exception raise];
    }

}

+ (NSArray *)backtrace {
    void *callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    
    for (i = UncaughtExceptionHandlerSkipAddressCount;
         i < UncaughtExceptionHandlerSkipAddressCount + UncaughtExceptionHandlerReportAddressCount; i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    return backtrace;
}


- (void)alertView:(UIAlertView *)anAlertView clickedButtonAtIndex:(NSInteger)anIndex {
    //因为这个弹出视图只有一个Cancel按钮，所以直接进行修改isDimsmissed这个变量了
    if (0 == anIndex) {
        _isDismissed = YES;
    } else {
        _isDismissed = NO;
    }
}

void UncaughtExceptionHandler(NSException *exception) {
    /**
     *  获取异常崩溃信息
     */
    NSArray *callStack = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *content = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[callStack componentsJoinedByString:@"\n"]];
    
    /**
     *  把异常崩溃信息发送至开发者邮件
     */
    [LYSignalHandler sendMailWithContent:content];
}

+ (void)setDefaultHander {
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
}

/** 将错误信息发送至mail */
+ (void)sendMailWithContent:(NSString *)content {
    NSMutableString *mailUrl = [NSMutableString stringWithFormat:@"mailto:%@", DEVELOPER_MAIL];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:mailUrl]]) {
        [mailUrl appendString:@"?subject=程序异常崩溃，请配合发送异常报告，谢谢合作！"];
        [mailUrl appendFormat:@"&body=%@", content];
        // 打开地址
        NSCharacterSet *allowedCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| "] invertedSet];
        NSString *mailPath = [mailUrl stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];        
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailPath] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailPath]];
        }
        
    }else {
        NSLog(@"邮箱地址错误");
    }
}


@end


