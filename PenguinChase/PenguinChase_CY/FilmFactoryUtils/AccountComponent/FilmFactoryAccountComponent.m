
#import "FilmFactoryAccountComponent.h"
#import <UMPush/UMessage.h>

static NSString *const ZYUserInfoKey = @"UserInfoKey"; //用户数据存储key
static NSString *const ZYCurrentUserKey = @"CurrentUserKey"; // 用户信息
static NSString *const ZYCurrentAccountToken = @"CurrentAccountToken"; // token
static NSString *const ZYLastLoginAccount = @"LastLoginPhoneNumber";// 最后一次登录账号

@implementation FilmFactoryBriefMemberItem
@end

@interface FilmFactoryAccountComponent ()

@property (nonatomic, strong) MDFDBStorage *storage;
@property (nonatomic, strong) FilmFactoryBriefMemberItem *memberItem;
@property (nonatomic, strong) NSMutableDictionary *userInfo;

@end

@implementation FilmFactoryAccountComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
        _storage = [[MDFDBStorage alloc] initWithNameSpace:[self nameSpaceString]];
        [self refreshAccountData];
    }
    return self;
}

- (NSString *)nameSpaceString
{
    return [NSString stringWithFormat:@"%@",ZYUserInfoKey];
}

- (void)refreshAccountData
{
    if ([self.storage isExistObjectForKey:ZYCurrentUserKey]) {
        _memberItem = [self.storage objectForKey:ZYCurrentUserKey error:nil];
        _userInfo = [[self.storage userInfoForKey:ZYCurrentUserKey error:nil] mutableCopy];
        _userInfo = (_userInfo) ? : [NSMutableDictionary dictionary];
    } else {
        _memberItem = nil;
        _userInfo = nil;
    }
}

#pragma mark - storeData

- (void)storeUserItem:(FilmFactoryBriefMemberItem *)loginUserInfo
{
    [self storeUserItem:loginUserInfo accountChangeNotify:YES];
}

- (void)storeUserItem:(FilmFactoryBriefMemberItem *)loginUserInfo accountChangeNotify:(BOOL)notify
{
    NSError *error = nil;
    if (loginUserInfo) {
        [self.storage setObject:loginUserInfo forKey:ZYCurrentUserKey error:&error];
    } else {
        [self.storage removeObjectForKey:ZYCurrentUserKey error:&error];
    }
    NSAssert(error == nil, @"账号操作失败");
    [self refreshAccountData];
    
    if (loginUserInfo && notify) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ORLoginUserInfoChangedNotification object:nil];
    }
}

- (void)storeAccessToken:(NSString *)token
{
    _userInfo = _userInfo ? : [NSMutableDictionary dictionary];
    [self.userInfo mdf_safeSetObject:token forKey:ZYCurrentAccountToken];
    [self.storage setUserInfo:self.userInfo forKey:ZYCurrentUserKey error:nil];
}

- (void)storeLastLoginAccount:(NSString *)account
{
    [self.storage setObject:account forKey:ZYLastLoginAccount error:nil];
}


#pragma mark - Properties

- (NSString *)fetchAccesstoken
{
    return self.userInfo[ZYCurrentAccountToken];
}

- (NSUInteger)fetchUserID
{
    return self.memberItem.uid;
}

- (NSString *)fetchNickName
{
    return self.memberItem.nickName;
}

- (NSString *)fetchPortraitUrl
{
    return self.memberItem.portraitUrl;
}

- (NSString *)fetchAccountNumber
{
    return [self.storage objectForKey:ZYLastLoginAccount error:nil];
}

- (void)logout
{
    // 标记推送
    [UMessage removeAlias:@(self.memberItem.uid).stringValue type:@"USER_PUSH" response:^(id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
        }
    }];
    
    self.userInfo = nil;
    self.memberItem = nil;
    
    [self storeUserItem:nil];
    [self storeAccessToken:nil];
    
    // 删除cookie
    NSHTTPCookieStorage *sharedCookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieTmpArray = [NSArray arrayWithArray:[sharedCookies cookies]];
    for (NSHTTPCookie *cookie in cookieTmpArray) {
        [sharedCookies deleteCookie:cookie];
    }
    
    // 退出登录通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ORAccountLogoutNotification object:nil];
}

#pragma mark - Public

- (BOOL)checkLogin:(BOOL)gotoLogin
{
    // 检测登录态
    if (self.accesstoken.length) {
        return YES;
    } else {
        // 强制去登陆态
        if (gotoLogin) {
            [[NSNotificationCenter defaultCenter] postNotificationName:ORAccountForceToLoginNotification object:nil];
        }
        return NO;
    }
}

+ (BOOL)checkLogin:(BOOL)gotoLogin
{
    return [[self sharedInstance] checkLogin:gotoLogin];
}

@end
