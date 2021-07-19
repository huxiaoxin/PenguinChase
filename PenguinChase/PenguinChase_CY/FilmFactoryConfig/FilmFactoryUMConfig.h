
#import "ORSingleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface FilmFactoryUMConfig : ORSingleton
@property (nonatomic, assign) BOOL um_deubg;

+ (void)analytics:(NSString *)event attributes:(NSDictionary *)attributes;
+ (void)analytics:(NSString *)event label:(NSString *)label;
@end

NS_ASSUME_NONNULL_END
