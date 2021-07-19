

#import "GNHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PandaMoviewCellinfoType) {
    PandaMoviewCellTypePortrail = 0, // 头像
    PandaMoviewCellTypeNickName,     // 昵称
};

@interface PandaMoviewuserinfoCellitem : GNHBaseItem

@property (nonatomic, assign) PandaMoviewCellinfoType cellType;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *anchorUrl; // 图片url
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@end

@interface PandaMoviewuserInfoTableViewCell : GNHBaseTableViewCell

@end

NS_ASSUME_NONNULL_END
