

#import "PandaMovieHotVideoDetailDataModel.h"

@implementation PandaMovieHotVideoDetailItem

- (NSString *)JSONKeyForProperty:(NSString *)propertyKey
{
    if ([propertyKey isEqualToString:@"idStr"]) {
        return @"id";
    }
    return [super JSONKeyForProperty:propertyKey];;
}

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"episodes"]) {
        return [PandaMovieVideoBaseItem class];
    }
    return [super classForObject:arrayElement inArrayWithPropertyName:propertyName];
}

@end

@implementation PandaMovieHotVideoDetailDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORHotDetailAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [PandaMovieHotVideoDetailItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)PandaMoviefetchVideoDetialWithId:(NSString *)videoId
{
    if (self.isLoading) {
        return NO;
    }
    
    if (!videoId.length) {
        return NO;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = videoId;
    self.params = params;
    
    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _hotVideoDetailItem = (PandaMovieHotVideoDetailItem *)self.parsedItem;
    }
}

@end
