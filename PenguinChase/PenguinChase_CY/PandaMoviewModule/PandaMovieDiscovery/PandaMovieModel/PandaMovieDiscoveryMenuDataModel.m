
#import "PandaMovieDiscoveryMenuDataModel.h"

@implementation PandaMovieDiscoveryTypeItem

@end

@implementation PandaMovieDiscoveryMenuItem

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"channelTypes"] ||
        [propertyName isEqualToString:@"areaTypes"] ||
        [propertyName isEqualToString:@"yearTypes"]) {
        return [PandaMovieDiscoveryTypeItem class];
    }
    return [super classForObject:arrayElement inArrayWithPropertyName:propertyName];
}

@end

@implementation PandaMovieDiscoveryMenuDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORDiscoverConfigAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [PandaMovieDiscoveryMenuItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)PandaMoviefetchDiscoveryMenu:(NSString *)type
{
    if (self.isLoading) {
        return NO;
    }
    
    NSString *address = [NSString gnh_addressWithString:ORDiscoverConfigAddress];
    if (type.length) {
        self.address = [address stringByAppendingFormat:@"/%@", type];
    } else {
        self.address = [address stringByAppendingString:@"/all"];
    }
    
    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _discoveryMenuItem = (PandaMovieDiscoveryMenuItem *)self.parsedItem;
    }
}


@end
