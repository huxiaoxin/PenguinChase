

#import "FilmFactoryPlayerManager.h"
#import "PandaMoVieVideoPlayerViewController.h"

@implementation FilmFactoryPlayerManager

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] mdf_safeAddObserver:self selector:@selector(jumpChannelNotification:) name:kORJumpChannelNotificationKey object:nil];
    }
    return self;
}

- (void)jumpChannelNotification:(NSNotification *)notification
{
    NSDictionary *params = notification.userInfo;
    NSString *videoId = params[@"videoId"];
    NSString *type = params[@"type"];
    NSString *coverUrl = params[@"coverUrl"];

    
    [self jumpChannelWith:videoId type:type cover:coverUrl];
}

- (void)jumpChannelWith:(NSString *)videoId type:(NSString *)type cover:(NSString *)coverUrl
{
    PandaMoVieVideoPlayerViewController *playerVC = [[PandaMoVieVideoPlayerViewController alloc] init];
    playerVC.videoId = videoId;
    playerVC.videotype = type;
    playerVC.coverUrl = coverUrl;
    [[UIViewController mdf_toppestViewController].navigationController pushViewController:playerVC animated:YES];
}


@end
