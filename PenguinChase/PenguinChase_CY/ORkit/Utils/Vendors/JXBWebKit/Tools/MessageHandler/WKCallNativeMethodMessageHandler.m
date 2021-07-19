
#import "WKCallNativeMethodMessageHandler.h"
#import "WKMessageHandlerHelper.h"
#import "WKMessageHandlerDispatch.h"
#import "GNHWebJSModel.h"
#import "ORShareToolManager.h"

@implementation WKCallNativeMethodMessageHandler

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //获取到js脚本传过来的参数
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:message.body];
    
#warning modify by chenyuan 20200721
    NSString *type = params[@"type"];
    
    if ([type isEqualToString:@"Config"]) {
        // 配置
        NSDictionary *configDic = params[@"info"][@"rightLabel"];
        if (configDic) {
            // 配置导航栏
            // 暂时只配置 右侧按钮
            [[NSNotificationCenter defaultCenter] postNotificationName:kWebViewFuctionActionKey object:nil userInfo:@{@"rightLabel":configDic}];
        }
    } else if ([type isEqualToString:@"GetAppData"]) {
        // 注入token 数据
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        
        NSMutableDictionary *paramsInfo = [NSMutableDictionary dictionary];
        paramsInfo[@"code"] = @(1);
        paramsInfo[@"mark"] = params[@"info"][@"mark"];
        paramsInfo[@"token"] = ORShareAccountComponent.accesstoken;
        paramsInfo[@"userId"] = @(ORShareAccountComponent.uid).stringValue;

        paramDic[@"info"] = paramsInfo;
        paramDic[@"platform"] = @"iOS";
        paramDic[@"type"] =  params[@"type"];

        NSString *paramsJsonStr = paramDic.mdf_jsonEncodedKeyValueString;
        NSString *callbackString = [NSString stringWithFormat:@"window.callBackContext(%@)", paramsJsonStr];
            
        if ([[NSThread currentThread] isMainThread]) {
            [message.webView evaluateJavaScript:callbackString completionHandler:^(id object, NSError * _Nullable error) {
                NSLog(@"evaluateJavaScript error : %@",error);
            }];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [message.webView evaluateJavaScript:callbackString completionHandler:^(id object, NSError * _Nullable error) {
                    NSLog(@"evaluateJavaScript error : %@",error);
                }];
            });
        }
    } else if ([type isEqualToString:@"Share"]) {
        NSDictionary *info = params[@"info"];
        ORSharePlatform *inforItem = [[ORSharePlatform alloc] init];
        inforItem.title = info[@"title"];
        inforItem.content = info[@"content"];
        inforItem.imgpath = info[@"imgpath"];
        inforItem.basepath = info[@"basepath"];
        inforItem.type = info[@"type"];
        
        if ([info[@"type"] isEqualToString:@"saveImage"]) {
            // 保存到相册
            inforItem.gnh_platform = ORSharePlatformTypeSaveImage;
        } else if ([info[@"type"] isEqualToString:@"WechatMoments"]) {
            // 微信朋友圈
            inforItem.gnh_platform = ORSharePlatformTypeWechatMoments;
        } else if ([info[@"type"] isEqualToString:@"Wechat"]) {
            // 微信
           inforItem.gnh_platform = ORSharePlatformTypeWechat;
        } else if ([info[@"type"] isEqualToString:@"QQ"]) {
            // QQ
           inforItem.gnh_platform = ORSharePlatformTypeQQ;
        } else if ([info[@"type"] isEqualToString:@"QZone"]) {
            // QQ 空间
           inforItem.gnh_platform = ORSharePlatformTypeQZone;
        } else if ([info[@"type"] isEqualToString:@"SinaWeibo"]) {
            // 微博
           inforItem.gnh_platform = ORSharePlatformTypeSinaWeibo;
        } else if ([info[@"type"] isEqualToString:@"Message"]) {
            // 短信
           inforItem.gnh_platform = ORSharePlatformTypeMessage;
        } else if ([info[@"type"] isEqualToString:@"copyShare"]) {
            // 粘贴
           inforItem.gnh_platform = ORSharePlatformTypeCopy;
        }
        [ORShareToolManager sharePlatform:inforItem completion:^(ORSharePlatform * _Nullable platform, ORShareToolResult result, NSString * _Nullable message) {
            if (result == ORShareToolResultSucceed && message.length) {
                [SVProgressHUD showSuccessWithStatus:message];
            }
        }];
    } else if ([type isEqualToString:@"Wechat"]) {
       // 绑定微信
        [[NSNotificationCenter defaultCenter] postNotificationName:kWebViewFuctionActionKey object:nil userInfo:@{@"type":type}];
   }
    
    //获取callback的identifier
    NSString *identifier = params[@"identifier"];
    
    params[@"success"] = ^(NSDictionary *result){
        [WKMessageHandlerHelper callbackWithResult:@"success" resultData:result identifier:identifier message:message];
    };
    
    params[@"fail"] = ^(NSDictionary *result){
        [WKMessageHandlerHelper callbackWithResult:@"fail" resultData:result identifier:identifier message:message];
    };
    
    params[@"progress"] = ^(NSDictionary *result){
        [WKMessageHandlerHelper callbackWithResult:@"progress" resultData:result identifier:identifier message:message];
    };
    
    params[@"isFromH5"] = @(YES);
    params[@"webview"] = message.webView;
    
    NSString *targetName = params[@"targetName"];
    NSString *actionName = params[@"actionName"];
    
    if ([actionName isKindOfClass:[NSString class]] && actionName.length > 0) {
        [[WKMessageHandlerDispatch sharedInstance] performTarget:targetName action:actionName params:params shouldCacheTarget:YES];
    }
}

@end
