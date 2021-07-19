//
//  ORFetchSubChanelMenuDataModel.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/14.
//

#import "PandaMovieFetchSubChanelMenuDataModel.h"

@implementation ORSubChannelMenuDataItem

@end

@implementation ORSubChannelMenuItem

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"data"]) {
        return [ORSubChannelMenuDataItem class];
    }
    return [super classForObject:arrayElement inArrayWithPropertyName:propertyName];
}

@end

@implementation PandaMovieFetchSubChanelMenuDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORSubChannelMenuAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [ORSubChannelMenuItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)fetchChannelMenuWithType:(NSString *)type
{
    if (self.isLoading) {
        return NO;
    }
    
    if (!type.length) {
        return NO;
    }
    
    NSString *address = [NSString gnh_addressWithString:ORSubChannelMenuAddress];
    self.address = [address stringByAppendingFormat:@"/%@", type];
       
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"type"] = type;
//    self.params = params;
    
    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _subChannelMenuItem = (ORSubChannelMenuItem *)self.parsedItem;
    }
}

@end
