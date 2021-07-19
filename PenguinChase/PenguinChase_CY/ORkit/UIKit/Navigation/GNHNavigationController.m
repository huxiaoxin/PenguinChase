//
//  ORNavigationController.m
//  ZhangYuSports
//
//  Created by ChenYuan on 2018/11/1.
//  Copyright © 2018年 ChenYuan. All rights reserved.
//

#import "GNHNavigationController.h"

@interface GNHNavigationController ()

@end

@implementation GNHNavigationController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.translucent = YES;
    self.navigationBar.barTintColor = LGDViewBJColor;
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Override Public Method

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    }
    [super pushViewController:viewController animated:animated];
}

@end
