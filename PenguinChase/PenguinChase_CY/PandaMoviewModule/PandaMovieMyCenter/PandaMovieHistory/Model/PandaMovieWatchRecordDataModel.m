
#import "PandaMovieWatchRecordDataModel.h"

@implementation PandaMovieWatchRecordDataItem

- (NSString *)JSONKeyForProperty:(NSString *)propertyKey
{
    if ([propertyKey isEqualToString:@"idStr"]) {
        return @"id";
    }
    return [super JSONKeyForProperty:propertyKey];
}

@end

@implementation PandaMovieWatchRecordItem

- (Class)classForObject:(id)arrayElement inArrayWithPropertyName:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"list"]) {
        return [PandaMovieWatchRecordDataItem class];
    }
    return [super classForObject:arrayElement inArrayWithPropertyName:propertyName];
}

@end

@implementation PandaMovieWatchRecordDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.address = [NSString gnh_addressWithString:ORFetchWatchRecordAddress];
        self.hostType = GNHBaseURLTypeClient;
        self.parseCls = [PandaMovieWatchRecordItem class];
        self.isAutoShowNetworkErrorToast = NO;
        self.requestType = MDFRequestTypeGet;
    }
    return self;
}

- (BOOL)fetchWatchRecordWithPage:(NSInteger)page limit:(NSInteger)limit
{
    if (self.isLoading) {
        return NO;
    }
    
    if (!ORShareAccountComponent.accesstoken.length) {
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
        _watchRecordItem = (PandaMovieWatchRecordItem *)self.parsedItem;
    }
}


@end

