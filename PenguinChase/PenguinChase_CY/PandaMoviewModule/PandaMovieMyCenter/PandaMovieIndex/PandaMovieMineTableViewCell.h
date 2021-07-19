
#import "GNHBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PandaMovieMineCellType) {
    PandaMovieMineCellTypeHistoryRecord = 0, // 观看历史
    PanDaMovieMineCellTypeDownload, // 我的下载
    PandaMovieMineCellTypeMineFavorite, // 我的收藏
    PandaMovieMineCellTypeFeedback,     // 意见反馈
    PandaMovieMineCellTypeShare,        // 应用分享
    PandaMovieMineCellTypeAboutMe,      // 关于我们
    PandaMovieMineCellTypeSetting,      // 系统设置
};

@interface PandaMovieMineCellItem : GNHBaseItem

@property (nonatomic, assign) PandaMovieMineCellType cellType; // 类型
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *redirectUrl;
@property (nonatomic, assign) BOOL isBeginSeperator;  // 开始分隔
@property (nonatomic, assign) BOOL isEndSeperator;  // 结束分隔

@end

@interface PandaMovieMineTableViewCell : GNHBaseTableViewCell

@end

NS_ASSUME_NONNULL_END
