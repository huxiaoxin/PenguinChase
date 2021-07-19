
#import "PandaMovieLoginDataModel.h"
#import "NSString+AES128.h"
#import <AFNetworking.h>
#import "AppDelegate+ORPush.h"

@implementation PandaMovieLoginItem

@end

@implementation PandaMovieLoginDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORLoginAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [PandaMovieLoginItem class];
        self.disableAutoDismiss = YES;
        self.isAutoShowNetworkErrorToast = NO;
        self.isAutoShowBusinessErrorToast = YES;
        self.requestType = MDFRequestTypePost;
        self.loadTips = @"登录中...";
    }
    return self;
}

- (AFURLSessionManager *)beforeSendRequest:(AFHTTPSessionManager *)sessionManager
{
    NSDictionary *header = [self httpHeader];
        
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [sessionManager.requestSerializer setValue:header[ORUserAgentId] forHTTPHeaderField:ORUserAgentId];
    [sessionManager.requestSerializer setValue:header[ORAuthorizationId] forHTTPHeaderField:ORAuthorizationId];
        
    // 全局加密参数
    // 时间
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSInteger timeStamp = interval*1000 ;

    NSString *unMd5sign = [NSString stringWithFormat:@"panderZj_panderASDF4n_%@_%@",@"iOS",@(timeStamp)];
    NSString *sign = unMd5sign.mdf_md5.lowercaseString;

    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString *sencondUnMd5sign = [NSString stringWithFormat:@"%@%@",sign,bundleId];
    NSString *sencondSign = sencondUnMd5sign.mdf_md5.lowercaseString;

    [sessionManager.requestSerializer setValue:@(timeStamp).stringValue forHTTPHeaderField:@"t"];
    [sessionManager.requestSerializer setValue:sencondSign forHTTPHeaderField:@"sign"];

    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"image/png",@"utf-8", @"text/json", @"text/javascript" ,nil];
    
    
    return sessionManager;
}

- (BOOL)loginAccount:(NSString *)phone code:(NSString *)code
{
    if (self.isLoading) {
        return NO;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = phone;
    params[@"code"] = code;
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    params[@"umengDeviceToken"] = appdelegate.deviceToken;
    self.params = params;
    
    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _loginItem = (PandaMovieLoginItem *)self.parsedItem;
    }
}

@end
