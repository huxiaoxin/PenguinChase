
#import "FilmFactoryUMConfig.h"
#import <UMCommon/MobClick.h>
#import <UMCommon/UMCommon.h>
#import "ORMainAPI.h"
#import "SVProgressHUD+ZY.h"

#import <UMCommon/UMCommon.h>

@implementation FilmFactoryUMConfig

#pragma mark - LifeCycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self umAnalyticsConfig];
    }
    return self;
}

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)umAnalyticsConfig {
    [UMConfigure initWithAppkey:umengAccesskey channel:ORchannel];
}

+ (void)analytics:(NSString *)event attributes:(NSDictionary *)attributes {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"user_id"] = @([FilmFactoryAccountComponent sharedInstance].fetchUserID).stringValue;
    if (attributes.count) {
        [dict addEntriesFromDictionary:attributes];
    }
    [MobClick event:event attributes:dict];
#ifdef DEBUG
    if ([FilmFactoryUMConfig shared].um_deubg) {
        [[[UIAlertView alloc] initWithTitle:nil message:dict.mdf_jsonEncodedKeyValueString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }
#endif
}
+ (void)analytics:(NSString *)event label:(NSString *)label
{
    if (event.length) {
        [MobClick event:event label:label];
    #ifdef DEBUG
        if ([FilmFactoryUMConfig shared].um_deubg) {
            [[[UIAlertView alloc] initWithTitle:nil message:label delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }
    #endif
    }
}
@end

