//
//  WKWebView+SyncConfigUA.m
//  JXBWebKit
//
//  Created by jinxiubo on 2018/5/23.
//  Copyright © 2018年 jinxiubo. All rights reserved.
//

#import "WKWebView+SyncUserAgent.h"

@implementation WKWebView (SyncUserAgent)

- (void)syncCustomUserAgentWithType:(CustomUserAgentType)type customUserAgent:(NSString *)customUserAgent {
    
    if (!customUserAgent || customUserAgent.length <= 0) {
        NSLog(@"WKWebView (SyncConfigUserAgent) config with invalid string");
        return;
    }
    
    [self evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSString *webviewUserAgent = response;
        NSArray *array = [webviewUserAgent componentsSeparatedByString:@"version=1.0"];
        webviewUserAgent = array.firstObject;

        NSDate *date = [NSDate date];
        NSTimeInterval interval = date.timeIntervalSince1970;
        unsigned long long ti = interval*1000;
        NSNumber *timeInterval = [NSNumber numberWithUnsignedLongLong:ti];

        NSString *userAgent = [NSString stringWithFormat:@"%@,%@,%@", webviewUserAgent, @"version=1.0", timeInterval];
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":userAgent, @"User-Agent":userAgent}];
        
        
        if(type == CustomUserAgentTypeDefault){
            if (@available(iOS 9.0, *)) {
                self.customUserAgent = userAgent;
            }else{
                NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:userAgent, @"UserAgent", nil];
                [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
            }
        }else if(type == CustomUserAgentTypeReplace){
            NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:customUserAgent, @"UserAgent", nil];
            if (@available(iOS 9.0, *)) {
                self.customUserAgent = customUserAgent;
            }else{
                [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
            }
        }else if (type == CustomUserAgentTypeAppend){
            NSString *appUserAgent = [NSString stringWithFormat:@"%@-%@", userAgent, customUserAgent];
            
            if (@available(iOS 9.0, *)) {
                self.customUserAgent = appUserAgent;
            }else{
                NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:appUserAgent, @"UserAgent", nil];
                [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
            }
        }else{
            NSLog(@"WKWebView (SyncConfigUA) config with invalid type :%@", @(type));
        }
    }];
}

@end
