
#import "PandaMovieVideoBaseItem.h"

@implementation PandaMovieVideoBaseItem

- (NSString *)JSONKeyForProperty:(NSString *)propertyKey
{
    if ([propertyKey isEqualToString:@"idStr"]) {
        return @"id";
    }
    return [super JSONKeyForProperty:propertyKey];
}

@end
