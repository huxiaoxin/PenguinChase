//
//  ORPushManager.m
//  ZhangYuSports
//
//  Created by ChenYuan on 2019/2/17.
//  Copyright © 2019 ChenYuan. All rights reserved.
//

#import "ORPushManager.h"
#import "PandaMovieH5ViewController.h"

@implementation ORPushManager

- (void)handleNotification:(NSDictionary *)dataDic
{
    // 0:站内h5 1:打开直播间 2:动动h5 3:站外h5
    NSInteger type = 0;
    NSString *redirectLink = @"";
    NSDictionary *customDic = nil;
    if (dataDic[@"custom"]) {
        customDic = dataDic[@"custom"];
        redirectLink = [customDic objectForKey:@"redirectUrl"];
        type = [[customDic objectForKey:@"type"] integerValue];
    } else {
        type = [[dataDic objectForKey:@"type"] integerValue];
        redirectLink = [dataDic objectForKey:@"redirectUrl"];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        switch (type) {
            case 0: {
                UIViewController *vc = [[PandaMovieH5ViewController alloc] initWithURL:redirectLink.urlWithString];
                vc.edgesForExtendedLayout = UIRectEdgeNone;
                [[UIViewController mdf_toppestViewController].navigationController pushViewController:vc animated:YES];
                
                break;
            }
            default:
                [ORMainAPI openScheme:redirectLink completion:nil]; // 浏览器打开
                break;
        }
    });
}

@end
