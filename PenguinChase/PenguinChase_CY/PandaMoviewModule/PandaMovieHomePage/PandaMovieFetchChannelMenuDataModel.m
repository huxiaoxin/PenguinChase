

#import "PandaMovieFetchChannelMenuDataModel.h"

@implementation PandaMovieChannelMenuDataItem

@end

@implementation FilmFactoryChannelMenuItem

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"data"]) {
        return [PandaMovieChannelMenuDataItem class];
    }
    return [super classForObject:arrayElement inArrayWithPropertyName:propertyName];
}

@end

@implementation PandaMovieFetchChannelMenuDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORIndexChannelMenuAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [FilmFactoryChannelMenuItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)fetchChannelMenuWithScene:(NSString *)scene
{
    if (self.isLoading) {
        return NO;
    }
    
    if (!scene.length) {
        return NO;
    }
    
    NSString *address = [NSString gnh_addressWithString:ORIndexChannelMenuAddress];
    self.address = [address stringByAppendingFormat:@"/%@", scene];
        
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"scene"] = scene;
//    self.params = params;
    
    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _channelMenuItem = (FilmFactoryChannelMenuItem *)self.parsedItem;
    }
}


@end

