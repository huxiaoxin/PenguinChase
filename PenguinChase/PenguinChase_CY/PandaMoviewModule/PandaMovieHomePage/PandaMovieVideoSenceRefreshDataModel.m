//
//  PandaMovieVideoSenceRefreshDataModel.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/3/22.
//

#import "PandaMovieVideoSenceRefreshDataModel.h"

@implementation ORVideoSenceItem

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"data"]) {
        return [PandaMovieVideoBaseItem class];
    }
    return [super classForObject:arrayElement inArrayWithPropertyName:propertyName];
}

@end

@implementation PandaMovieVideoSenceRefreshDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORChannelSceneDataAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [ORVideoSenceItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)fetchChannelSenceDataWithType:(NSString *)senceType videoType:(NSString *)vidoeType
{
    if (self.isLoading) {
        return NO;
    }
    
    if (!senceType.length || !vidoeType.length) {
        return NO;
    }
    
    NSString *address = [NSString gnh_addressWithString:ORChannelSceneDataAddress];
    self.address = [address stringByAppendingFormat:@"/%@/%@", vidoeType, senceType];
    
    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _videoSenceItem = (ORVideoSenceItem *)self.parsedItem;
    }
}

@end
