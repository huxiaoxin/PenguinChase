

#import "PandaMovieSearchHotDataModel.h"

@implementation PandaMovieSearchHotKeyItem

@end

@implementation PandaMovieSearchHotDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORSearchHotKeyAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [PandaMovieSearchHotKeyItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)PandaMoviehotKeywords
{
    if (self.isLoading) {
        return NO;
    }
    
    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _searchHotKeyItem = (PandaMovieSearchHotKeyItem *)self.parsedItem;
    }
}

@end
