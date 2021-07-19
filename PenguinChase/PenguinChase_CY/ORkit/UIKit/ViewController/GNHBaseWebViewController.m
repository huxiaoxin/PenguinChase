//
//  GNHBaseWebViewController.m
//  ZhangYuSports
//
//  Created by ChenYuan on 2019/1/26.
//  Copyright © 2019年 ChenYuan. All rights reserved.
//

#import "GNHBaseWebViewController.h"

@interface GNHBaseWebViewController ()

@end

@implementation GNHBaseWebViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.progressTintColor = gnh_color_c;
        self.backItemImgName = @"pandaMoview_left_balck_arrow";
        self.allowsBFNavigationGesture = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.superview.backgroundColor = gnh_color_b;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
