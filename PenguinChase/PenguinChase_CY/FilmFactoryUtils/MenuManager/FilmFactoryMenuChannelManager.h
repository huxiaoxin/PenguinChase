
#import "ORSingleton.h"
#import "PandaMovieFetchChannelMenuDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilmFactoryMenuChannelManager : ORSingleton

@property (nonatomic, strong) FilmFactoryChannelMenuItem *channelMenuItem;

- (NSInteger)getVideoUserId:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
