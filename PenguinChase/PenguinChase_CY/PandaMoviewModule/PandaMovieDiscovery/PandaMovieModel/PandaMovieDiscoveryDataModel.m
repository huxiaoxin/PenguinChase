
#import "PandaMovieDiscoveryDataModel.h"

@implementation PandaMovieDiscoveryDataItem

@end


@implementation PandaMovieDiscoveryItem

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"list"]) {
        return [PandaMovieDiscoveryDataItem class];
    }
    return [super classForObject:arrayElement inArrayWithPropertyName:propertyName];
}

@end

@implementation PandaMovieDiscoveryDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORDiscoverDataAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [PandaMovieDiscoveryItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)PandaMoviefetchDiscoverChannelWithPage:(NSInteger)page PandaMovielimit:(NSInteger)limit PandaMovieparams:(NSDictionary *)paramDic
{
    if (self.isLoading) {
        return NO;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = @(page);
    params[@"limit"] = limit > 10 ? @(limit) : @(10);
    params[@"keyword"] = paramDic[@"keyword"];
    params[@"videoType"] = paramDic[@"videoType"];
    params[@"yearType"] = paramDic[@"yearType"];
    params[@"areaType"] = paramDic[@"areaType"];
    params[@"childType"] = paramDic[@"childType"];
    self.params = params;
    
    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _discoveryItem = (PandaMovieDiscoveryItem *)self.parsedItem;
    }
}


@end
