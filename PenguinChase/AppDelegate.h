//
//  AppDelegate.h
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/24.
//

#import <UIKit/UIKit.h>
#import "PandaMovieTabBarController.h"
#import "PenguinChase_BaseTabbarViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
// 返回AppDelegate
+ (AppDelegate *)shareDelegate;
@property (strong, nonatomic) UIWindow * window;
@property (nonatomic, assign) BOOL isShouldOrientationMaskAll;
@property (nonatomic, weak, readonly) PenguinChase_BaseTabbarViewController *tabBarViewController; /**< RootViewController */
@end

