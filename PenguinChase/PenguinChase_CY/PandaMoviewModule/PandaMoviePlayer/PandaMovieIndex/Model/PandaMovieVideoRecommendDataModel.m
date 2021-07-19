

#import "PandaMovieVideoRecommendDataModel.h"

@implementation PandaMovieVideoRecommendItem

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"data"]) {
        return [PandaMovieVideoBaseItem class];
    }
    return [super classForObject:arrayElement inArrayWithPropertyName:propertyName];
}

@end

@implementation PandaMovieVideoRecommendDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORVideoRecommendAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [PandaMovieVideoRecommendItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)fetchRecommendVideo:(NSString *)videoId type:(NSString *)videoType
{
    if (self.isLoading) {
        return NO;
    }
    
    if (!videoType.length) {
        return NO;
    }
    
    NSString *address = [NSString gnh_addressWithString:ORVideoRecommendAddress];
    self.address = [address stringByAppendingFormat:@"/%@", videoType];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = videoId;
    self.params = params;

    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _videoRecommendItem = (PandaMovieVideoRecommendItem *)self.parsedItem;
    }
}

@end
