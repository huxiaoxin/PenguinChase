

#import "PandaMovieFavoriteListDataModel.h"

@implementation PandaMovieFavoriteListDataItem

@end

@implementation PandaMovieFavoriteListItem

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"list"]) {
        return [PandaMovieFavoriteListDataItem class];
    }
    return [super classForObject:arrayElement inArrayWithPropertyName:propertyName];
}

@end

@implementation PandaMovieFavoriteListDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORFavoriteListAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [PandaMovieFavoriteListItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)fetchFavoriteWithPage:(NSInteger)page limit:(NSInteger)limit
{
    if (self.isLoading) {
        return NO;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"page"] = @(page);
    params[@"limit"] = limit > 10 ? @(limit) : @(10);

    self.params = params;
    
    return [super load];
}

- (void)handleDataAfterParsed
{
    [super handleDataAfterParsed];
    
    if ([self.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
        _favoriteListItem = (PandaMovieFavoriteListItem *)self.parsedItem;
    }
}

@end

