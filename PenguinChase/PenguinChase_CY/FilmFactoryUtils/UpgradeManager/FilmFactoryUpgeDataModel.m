
#import "FilmFactoryUpgeDataModel.h"

@implementation FilmFactoryUpgradeItem

@end

@implementation FilmFactoryUpgeDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORUpgradeAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [FilmFactoryUpgradeItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)fetchUpgradeInfo
{
    if (self.isLoading) {
        return NO;
    }
    
    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _upgradeItem = (FilmFactoryUpgradeItem *)self.parsedItem;
    }
}


@end
