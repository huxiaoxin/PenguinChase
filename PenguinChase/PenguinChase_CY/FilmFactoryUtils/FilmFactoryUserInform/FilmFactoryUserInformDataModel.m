
#import "FilmFactoryUserInformDataModel.h"

@implementation PandaMoviewuserInfoItem

@end

@implementation FilmFactoryUserInformDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORUserInformAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [PandaMoviewuserInfoItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.isAutoShowBusinessErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)FilmFactoryfetchUserInform
{
    if (self.isLoading) {
        return NO;
    }
    
    if (!ORShareAccountComponent.accesstoken.length) {
        return NO;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = ORShareAccountComponent.accesstoken;
    self.params = params;
    
    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _userInformItem = (PandaMoviewuserInfoItem *)self.parsedItem;
    }
}


@end
