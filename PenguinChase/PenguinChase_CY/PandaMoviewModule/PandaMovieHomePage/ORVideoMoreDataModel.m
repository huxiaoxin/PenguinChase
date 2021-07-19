//
//  ORRecommecListDataModel.m
//  OrangeVideo
//
//  Created by chenyuan on 2021/1/14.
//

#import "ORVideoMoreDataModel.h"

@implementation ORVideoMoreDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORMoreChannelDataAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [PandaMovieIndexChannelItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)fetchHomeChannelWithPage:(NSInteger)page limit:(NSInteger)limit scene:(NSString *)scene sceneType:(NSString *)sceneType
{
    if (self.isLoading) {
        return NO;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = @(page);
    params[@"limit"] = limit > 10 ? @(limit) : @(15);
    params[@"scene"] = scene;
    params[@"sceneType"] = sceneType;

    self.params = params;
    
    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _videoMoreItem = (PandaMovieIndexChannelItem *)self.parsedItem;
    }
}

@end
