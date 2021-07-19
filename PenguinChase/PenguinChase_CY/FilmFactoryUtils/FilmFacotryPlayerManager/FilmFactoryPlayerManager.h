

#import "ORSingleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilmFactoryPlayerManager : ORSingleton

- (void)jumpChannelWith:(NSString *)videoId type:(NSString *)channelType cover:(NSString *)coverUrl;

@end

NS_ASSUME_NONNULL_END
