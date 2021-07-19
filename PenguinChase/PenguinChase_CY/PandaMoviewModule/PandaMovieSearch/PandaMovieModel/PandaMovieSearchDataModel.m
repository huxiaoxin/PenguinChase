
#import "PandaMovieSearchDataModel.h"

@implementation PandaMovieSearchItem

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"list"]) {
        return [PandaMovieVideoBaseItem class];
    }
    return [super classForObject:arrayElement inArrayWithPropertyName:propertyName];
}

@end

@implementation PandaMovieSearchDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORSearchChannelAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [PandaMovieSearchItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)searchWithKeyword:(NSString *)keyword page:(NSInteger)page limit:(NSInteger)limit params:(NSDictionary *)paramDic
{
    if (self.isLoading) {
        return NO;
    }
    
    if (!keyword.length || !page || !limit) {
        return NO;
    }
    NSString *videoType = paramDic[@"videoType"];
    if (videoType.length) {
        NSString *address = [NSString gnh_addressWithString:ORSearchChannelAddress];
        self.address = [address stringByAppendingFormat:@"/%@", videoType];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"keyword"] = keyword;
    params[@"page"] = @(page);
    params[@"limit"] = @(limit);
    
    params[@"childType"] = paramDic[@"childType"];
    params[@"yearType"] =  paramDic[@"yearType"];
    params[@"areaType"] = paramDic[@"areaType"];;

    self.params = params;
    
    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _searchItem = (PandaMovieSearchItem *)self.parsedItem;
    }
}


@end
