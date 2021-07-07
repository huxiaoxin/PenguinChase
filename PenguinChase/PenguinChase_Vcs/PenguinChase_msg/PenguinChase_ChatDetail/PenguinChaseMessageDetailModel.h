
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PenguinChaseMessageDetailModel : NSObject
@property(nonatomic,copy)   NSString * msgname;
@property(nonatomic,assign) NSInteger  userID;
@property(nonatomic,copy)   NSString *imgUrl;
@property(nonatomic,assign) BOOL  msgisMe;
@property(nonatomic,assign) CGFloat CellHeight;

@end

NS_ASSUME_NONNULL_END
