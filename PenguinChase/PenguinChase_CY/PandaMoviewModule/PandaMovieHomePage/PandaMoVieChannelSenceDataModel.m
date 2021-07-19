//
//  ORChannelSenceDataModel.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/3/22.
//

#import "PandaMoVieChannelSenceDataModel.h"

@implementation ORChannelSenceDataItem

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"videoDtoList"]) {
        return [PandaMovieVideoBaseItem class];
    }
    return [super classForObject:arrayElement inArrayWithPropertyName:propertyName];
}

@end

@implementation ORChannelSenceItem

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"data"]) {
        return [ORChannelSenceDataItem class];
    }
    return [super classForObject:arrayElement inArrayWithPropertyName:propertyName];
}

@end

@implementation PandaMoVieChannelSenceDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORChannelSceneDataAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [ORChannelSenceItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)fetchChannelSenceDataWithType:(NSString *)type
{
    if (self.isLoading) {
        return NO;
    }
    
    if (!type.length) {
        return NO;
    }
    
    NSString *address = [NSString gnh_addressWithString:ORChannelSceneDataAddress];
    self.address = [address stringByAppendingFormat:@"/%@", type];
    
    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _channelSenceItem = (ORChannelSenceItem *)self.parsedItem;
    }
}


@end
