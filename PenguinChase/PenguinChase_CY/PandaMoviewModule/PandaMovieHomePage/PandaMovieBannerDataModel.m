//
//  ORFetchBannerDataModel.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/20.
//

#import "PandaMovieBannerDataModel.h"

@implementation ORBannerDataItem

@end

@implementation ORBannerItem

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"data"]) {
        return [ORBannerDataItem class];
    }
    return [super classForObject:arrayElement inArrayWithPropertyName:propertyName];
}

@end


@implementation PandaMovieBannerDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORBannerAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [ORBannerItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)fetchBannerWithType:(NSString *)type
{
    if (self.isLoading) {
        return NO;
    }
    
    if (!type.length) {
        return NO;
    }
    
    NSString *address = [NSString gnh_addressWithString:ORBannerAddress];
    self.address = [address stringByAppendingFormat:@"/%@", type];
    
    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _bannerItem = (ORBannerItem *)self.parsedItem;
    }
}


@end
