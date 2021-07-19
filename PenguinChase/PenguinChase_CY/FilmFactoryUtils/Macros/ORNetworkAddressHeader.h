

#ifndef ORNetworkAddressHeader_h
#define ORNetworkAddressHeader_h


#pragma mark - 升级&更新

static NSString *const ORUpgradeAddress = @"orange/v1/app/config/upgrade"; // app升级弹窗/检测更新时接口

#pragma mark - 首页

static NSString *const ORIndexChannelMenuAddress = @"orange/v1/app/config/type/list"; // 首页频道菜单
static NSString *const ORMoreChannelDataAddress = @"orange/v1/app/config/home"; // 更多接口
static NSString *const ORSubChannelMenuAddress = @"orange/v1/app/config/type/child/type"; // 分类子菜单配置
static NSString *const ORBannerAddress = @"orange/v1/app/config/banner/list"; // banner
static NSString *const ORSearchChannelAddress = @"orange/v1/app/search/search"; // 搜索
static NSString *const ORSearchHotKeyAddress = @"orange/v1/app/search/search/hotspot"; // 热门搜索
static NSString *const ORChannelDataAddress = @"orange/v1/app/video/page"; // 列表数据
static NSString *const ORChannelSceneDataAddress = @"orange/v1/app/config/scene"; // 首页场景数据

#pragma mark - 热点

static NSString *const ORHotChannelAddress = @"orange/v1/app/hotspot/page"; // 热点数据
static NSString *const ORHotDetailAddress = @"orange/v1/app/hotspot/detail"; // 热点详情数据
static NSString *const ORHotVideoRecommendAddress = @"orange/v1/app/hotspot/recommend"; // 热点视频推送

#pragma mark - 发现

static NSString *const ORDiscoverConfigAddress = @"orange/v1/app/config/discover"; // 发现列表配置
static NSString *const ORDiscoverDataAddress = @"orange/v1/app/video/discover"; // 发现列表数据


#pragma mark - 登录 & 注册

static NSString *const ORLoginAddress = @"orange/v1/app/login/login"; // 登录
static NSString *const ORFetchSMSCodeAddress = @"orange/v1/app/login/sms/vCode"; // 验证码接口
static NSString *const ORAutoLoginAddress = @"orange/v1/app/login/auto/login"; // 自动登录

#pragma mark - 我的

static NSString *const ORFetchWatchRecordAddress = @"orange/v1/app/video/history/page"; // 观看记录
static NSString *const ORDeleteWatchRecordAddress = @"orange/v1/app/video/history/remove"; // 删除观看记录

static NSString *const ORFeedbackAddress = @"orange/v1/app/feedBack/release"; // 意见反馈
static NSString *const ORUserInformAddress = @"orange/v1/app/userInfo"; // 用户信息

static NSString *const ORFavoriteListAddress = @"orange/v1/app/favourite/page"; // 收藏列表
static NSString *const ORAddFavoriteAddress = @"orange/v1/app/favourite/fav"; // 添加收藏
static NSString *const ORDeleteFavoriteAddress = @"orange/v1/app/favourite/remove"; // 取消收藏
static NSString *const ORUpdateUserInformAddress = @"orange/v1/app"; // 修改用户信息

static NSString *const ORAddPraiseAddress = @"orange/v1/app/video/video/like"; // 用户点赞
static NSString *const ORRemovePraiseAddress = @"orange/v1/app/video/video/like/remove"; // 取消点赞

#pragma mark - 视频
static NSString *const ORVideoPageAddress = @"orange/v1/app/video/page"; // 获取视频列表接口
static NSString *const ORVideoRecommendAddress = @"orange/v1/app/video/recommend"; // 详情页视频推荐接口
static NSString *const ORVideoDetailAddress = @"orange/v1/app/video/detail"; // 获取视频详情
static NSString *const ORVideoReportAddress = @"orange/v1/app/video/history/history/report"; // 视频历史上报


#pragma mark - 上传
static NSString *const ORUploadFileAddress = @"orange/v1/app/file/upload"; // 上传
static NSString *const ORShareReportAddress = @"orange/v1/app/video/share/report"; // 分享上报

#endif /* ORNetworkAddressHeader_h */
