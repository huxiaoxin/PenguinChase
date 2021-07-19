//
//  NSString+LYJS.m
//  shuaidanbao
//
//  Created by ChenYuan on 15/11/17.
//  Copyright © 2015年 sdb. All rights reserved.
//

#import "NSString+LYJS.h"
@implementation NSString (LYJS)
/** javascript false=取消超链接 true=恢复超链接
 function doLinkAll(action) {
    var aLabels = document.getElementsByTagName("a");
    for (var i = 0; i < aLabels.length; i++) {
        if (action) {
           if (aLabels[i].rel) {
              aLabels[i].setAttribute("href", aLabels[i].ref);
           }
        }else {
           aLabels[i].setAttribute("rel", aLabels[i].href);
           aLabels[i].removeAttribute("href");
        }
    }
 }
 */
+ (NSString *)jsForbidLink:(BOOL)flag {
    NSString *jsFlag;
    if (flag) {
        jsFlag = @"false";
    }else {
        jsFlag = @"true";
    }
    NSString *js = [NSString stringWithFormat:@"function doLinkAll(action) { var aLabels = document.getElementsByTagName('a'); for (var i = 0; i < aLabels.length; i++) { if (action) { if (aLabels[i].rel) { aLabels[i].setAttribute('href', aLabels[i].ref); } }else { aLabels[i].setAttribute('rel', aLabels[i].href); aLabels[i].removeAttribute('href'); } } } doLinkAll(%@);", jsFlag];
    return js;
}

+ (instancetype)jsPostRequest {
    //调用格式： gnh_postRequest('URL', {"key": "value"});
    NSString *jsString = @" \
        function gnh_postRequest(path, params) { \
            var method = 'post'; \
            var gnh_hidenField_form = document.createElement('form'); \
            gnh_hidenField_form.setAttribute('method', method); \
            gnh_hidenField_form.setAttribute('action', path); \
            for(var key in params) { \
                if(params.hasOwnProperty(key)) { \
                    var hiddenField = document.createElement('input'); \
                    hiddenField.setAttribute('type', 'hidden'); \
                    hiddenField.setAttribute('name', key); \
                    hiddenField.setAttribute('value', params[key]); \
                    gnh_hidenField_form.appendChild(hiddenField); \
                } \
            } \
            document.body.appendChild(gnh_hidenField_form); \
            gnh_hidenField_form.submit(); \
        }";
    return jsString;

}

+ (NSString *)jsForbidCopy {
    NSString *js = @"document.documentElement.style.webkitUserSelect='none';";
    return js;
}

+ (NSString *)jsForbidMenu {
    // 禁止选择CSS
    NSString *css = @"body{-webkit-user-select:none;-webkit-user-drag:none;-webkit-touch-callout:none;}";
    
    // CSS选中样式取消
    NSMutableString *js = [NSMutableString stringWithFormat:@""];
    [js appendString:@"var style = document.createElement('style');"];
    [js appendString:@"style.type = 'text/css';"];
    [js appendFormat:@"var cssContent = document.createTextNode('%@');", css];
    [js appendString:@"style.appendChild(cssContent);"];
    [js appendString:@"document.body.appendChild(style);"];
    return js;
}

+ (NSString *)jsScrollToTop {
    NSString *js = @"window.scrollTo(0, 0);";
    return js;
}

- (NSDictionary *)paramsFromURL {
    NSUInteger location = [self rangeOfString:@"://"].location;
    if (location == NSNotFound) {
        return nil;
    }
    
    NSString *protocolString = [self substringToIndex:(location)];
    
    NSString *tmpString = [self substringFromIndex:([self rangeOfString:@"://"].location + 3)];
    NSString *hostString = nil;
    
    if (0 < [tmpString rangeOfString:@"/"].length) {
        hostString = [tmpString substringToIndex:([tmpString rangeOfString:@"/"].location)];
    }
    else if (0 < [tmpString rangeOfString:@"?"].length) {
        hostString = [tmpString substringToIndex:([tmpString rangeOfString:@"?"].location)];
    }
    else {
        hostString = tmpString;
    }
    
    NSInteger index;
    if ([self rangeOfString:hostString].location == NSNotFound) {
        index = [self rangeOfString:protocolString].location + [self rangeOfString:protocolString].length;
    } else {
        index = [self rangeOfString:hostString].location + [self rangeOfString:hostString].length;
    }
    
    tmpString = [self substringFromIndex:index];
    NSString *uriString = @"/";
    if (0 < [tmpString rangeOfString:@"/"].length) {
        if (0 < [tmpString rangeOfString:@"?"].length) {
            uriString = [tmpString substringToIndex:[tmpString rangeOfString:@"?"].location];
        }
        else {
            uriString = tmpString;
        }
    }
    
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    if (0 < [self rangeOfString:@"?"].length) {
        NSString *paramString = [self substringFromIndex:([self rangeOfString:@"?"].location + 1)];
        NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
        NSScanner* scanner = [[NSScanner alloc] initWithString:paramString];
        while (![scanner isAtEnd]) {
            NSString* pairString = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
            if (kvPair.count == 2) {
                NSString* key = [[kvPair objectAtIndex:0]
                                 stringByRemovingPercentEncoding];
                NSString* value = [[kvPair objectAtIndex:1]
                                   stringByRemovingPercentEncoding];
                if (key) {
                    pairs[key] = value;
                }
            }
        }
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            pairs, PARAMS,
            protocolString, PROTOCOL,
            hostString, HOST,
            uriString, URI, nil];
}

+ (NSString *)cookieValueWithName:(NSString *)name {
    NSString *jsString = [NSString stringWithFormat:
                          @"function gnhGetCookie(name) {"
                              "var arr,reg=new RegExp('(^| )'+name+'=([^;]*)(;|$)');"
                              "if(arr=document.cookie.match(reg)) {"
                                    "return unescape(arr[2]);"
                              "} else {"
                                    "return null;"
                              "}"
                          "};gnhGetCookie('%@');", name];
    return jsString;
}

+ (NSString *)userAgentWeb {
    return @"navigator.userAgent";
}

+ (NSURL *)URLWithString_LY:(NSString *)str {
    NSURL *url;
    if (str && [str isKindOfClass:[NSString class]] && str.length > 0) {
        url = [NSURL URLWithString:str];
    } else {
        url = nil;
    }
    return url;
}

- (NSURL *)urlWithString
{
    NSURL *url = nil;
    if (self && [self isKindOfClass:[NSString class]] && self.length > 0) {
        
        NSString *urlstr = self;
        if (self.mdf_containsChinese) {
            // 是否包含中文
            urlstr = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//编码
        }
        url = [NSURL URLWithString:urlstr];
    }
    return url;
}

@end
