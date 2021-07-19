#ifndef Header_h
#define Header_h
#define LGDMianColor          [UIColor colorWithHexString:@"#FFCF33"]
#define LGDGaryColor          [UIColor colorWithHexString:@"#9F9FA0"]
#define LGDLightGaryColor     [UIColor colorWithHexString:@"#F5F5F5"]
#define LGDBLackColor         [UIColor blackColor]
#define LGDLightBLackColor    [UIColor colorWithHexString:@"#444444"]
#define LGDTabarColor         [UIColor colorWithHexString:@"#804AB7"]

#define LGDRedColor          [UIColor colorWithHexString:@"#F95B6A"]
#define LGDBlueColor          [UIColor colorWithHexString:@"#25D090"]
#define SCREEN_Height [[UIScreen mainScreen] bounds].size.height
#define SCREEN_Width  [[UIScreen mainScreen] bounds].size.width
#define KBlFont(b)        [UIFont fontWithName:@"DINAlternate-Bold" size:b]
#define KFZPFont(b)        [UIFont fontWithName:@"FZPWJW--GB1-0" size:b]
#define KSysFont(c)      [UIFont systemFontOfSize:c]
#define RealWidth(a)        ((a*1.0)/375.0) * SCREEN_Width

#define K(a)        ((a*1.0)/375.0) * SCREEN_Width
#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IPHONE_X (@available(iOS 11.0, *) ？ [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom > 0.0 : NO )
#define kIs_iPhoneX SCREEN_Width >=375.0f && SCREEN_Height >=812.0f&& kIs_iphone
#define kTabBarHeight (CGFloat)(kIs_iPhoneX?(49.0 + 34.0):(49.0))

#define FilmnavigationHeight  self.navigationController.navigationBar.frame.size.height
#define NaviH (SCREEN_Height >= 812 ? 88 : 64)
#define UserDefaults                    [NSUserDefaults standardUserDefaults]


// 当前设备大小
#define iPhoneWidth [UIScreen mainScreen].bounds.size.width
#define iPhoneHeight [UIScreen mainScreen].bounds.size.height
//自适应大小;这里使用的基于iphone6 的参考适配，可以修改为se/5s  {320, 568}/ 6s {375, 667}/ iphonX {375, 812}
#define kWidth(width)                     iPhoneWidth  * width  / 375.
#define kHeight(height)                  iPhoneHeight * height / 667.
#define kLevelSpace(space)           iPhoneWidth  * space  / 375.      //水平方向距离间距
#define kVertiSpace(space)            iPhoneHeight * space / 667.      //垂直方向距离间距

#define font(R) (R)*(iPhoneWidth)/375.0     //这里是iPhone 6屏幕字体
#define sysFont(f)  [UIFont fontWithName:@"STHeitiSC-Light" size:autoScaleW(f)]

#define CHSYTagPhoneNumberBOOL @"CHSYTagPhoneNumberBOOL" // 闪验判断是否有预手机号
#define CHUserEntersFirstTime @"CHUserEntersFirstTime" // 用户第一次进入启动欢迎页
#define CHWXCodeNotification  @"CHWXCodeNotification"// 微信登录得到code
#define TokenRestNotification  @"TokenRestNotification"// 登录失效
#define TokenRestNotification  @"TokenRestNotification" // 登录失效
#define  AppisHaveactivity     @"AppisHaveactivity"    //底部导航是否开启活动
#define  PageJumpActionNotiCation  @"PageJumpActionNotiCation"    //广告点击跳转通知
#define  AppTabbarActitytapNotiCation  @"AppTabbarActitytapNotiCation"    //底部活动按钮点击
#define CountdowntoAnswers           @"CountdowntoAnswers"//答题倒计时
#define Endofanswer                  @"Endofanswer "//答题结束

#define QMGJDEVID @"1" // devid
#define QMGJAPPID @"1" // appid
#define QMGJV     @"1" // v
    


#pragma mark -- 颜色
#define Color1 HEXCOLOR(0xffffff)
#define Color2 HEXCOLOR(0x333333)
#define Color3 HEXCOLOR(0xf5f5f5)
#define Color4 HEXCOLOR(0x0079FF)
#define Color5 HEXCOLOR(0x999999)
#define Color6 HEXCOLOR(0x0294EC)
#define Color7 HEXCOLOR(0xE3E4E4)
#define Color8 HEXCOLOR(0x666666)
#define Color9 HEXCOLOR(0xeeeeee)
#define Color10 HEXCOLOR(0x0194EC)
#define Color11 HEXCOLOR(0xFFB21E)
#define Color12 HEXCOLOR(0x3EA8E7)
#define Color13 HEXCOLOR(0xF05939)
#define Color14 HEXCOLOR(0xFFB423)
#define Color15 HEXCOLOR(0xFFB11C)
#define Color16 HEXCOLOR(0x1DB1B1)
#define Color17 HEXCOLOR(0xDEDEDE)
#define Color18 HEXCOLOR(0xF8E71C)
#define Color19 HEXCOLOR(0x565656)
#define Color20 HEXCOLOR(0x0096e9)
#define Color21 HEXCOLOR(0xffd149)
#define Color22 HEXCOLOR(0xec3d00)
//#define Color23 HEXCOLOR(0x227fc5)
#define Color24 HEXCOLOR(0xcccccc)
#define Color25 HEXCOLOR(0xffb01a)
#define Color26 HEXCOLOR(0x282828)
#define Color27 HEXCOLOR(0xff0000)
#define Color28 HEXCOLOR(0xED5A3F)
#define Color29 HEXCOLOR(0xd1d1d1)
#define Color30 HEXCOLOR(0x0296EB)
#define Color31 HEXCOLOR(0x989898)
#define Color32 HEXCOLOR(0x898989)
#define Color33 HEXCOLOR(0xf26a52)
#define Color34 HEXCOLOR(0x000000)
#define Color35 HEXCOLOR(0xc8c7cc)
#define Color36 HEXCOLOR(0x12bdbd)
#define Color37 HEXCOLOR(0xd8d8d8)
#define Color38 HEXCOLOR(0x656565)
#define Color39 HEXCOLOR(0xee5541)
#define Color40 HEXCOLOR(0xff5555)
#define Color41 HEXCOLOR(0xfa3c39)
#define Color42 HEXCOLOR(0x0BA1F0)
#define Color43 HEXCOLOR(0x0598ea)
#define Color44 HEXCOLOR(0x2BA6F0)
#define Color45 HEXCOLOR(0x308dd3)
#define Color46 HEXCOLOR(0x129DEB)
#define Color47 HEXCOLOR(0x151515)
#define Color48 HEXCOLOR(0x41B1EF)
#define Color49 HEXCOLOR(0xED4B55)
#define Color50 HEXCOLOR(0xF16F77)
#define Color51 HEXCOLOR(0x83CAF4)
#define Color52 HEXCOLOR(0x0395ED)
#define Color53 HEXCOLOR(0xF53434)
#define Color54 HEXCOLOR(0x46B6FA)
#define Color55 HEXCOLOR(0xFFB432)
#define Color56 HEXCOLOR(0xF8F8F8)
#define Color57 HEXCOLOR(0x9B9B9B)
#define Color58 HEXCOLOR(0xB2B2B2)
#define Color59 HEXCOLOR(0xFBFBFB)
#define Color60 HEXCOLOR(0x939393)
#define Color61 HEXCOLOR(0xF5A623)
#define Color62 HEXCOLOR(0xDBDBDB)
#define Color63 HEXCOLOR(0xF0F0F0)
#define Color64 HEXCOLOR(0xE6B708)
#define Color65 HEXCOLOR(0x00A0DE)
#define Color66 HEXCOLOR(0xE03636)
#define Color67 HEXCOLOR(0xEFEFF1)
#define Color68 HEXCOLOR(0x3F3F3F)
#define Color69 HEXCOLOR(0xFFEAEA)
#define Color70 HEXCOLOR(0xEDEDED)
#define Color71 HEXCOLOR(0x0768DB)
#define Color72 HEXCOLOR(0x808080)
#define Color73 HEXCOLOR(0xd81e06)
#define Color74 HEXCOLOR(0xFF4040)
#define Color75 HEXCOLOR(0xCAEAFF)
#define Color76 HEXCOLOR(0x979797)
#define Color77 HEXCOLOR(0xE97300)
#define Color78 HEXCOLOR(0xF1F1F1)
#define Color79 HEXCOLOR(0x4A4A4A)
#define Color80 HEXCOLOR(0xFFFCF2)
#define Color81 HEXCOLOR(0x232323)
#define Color82 HEXCOLOR(0xEBEBEB)
#define Color83 HEXCOLOR(0xFFF8E9)
#define Color84 HEXCOLOR(0x262628)
#define Color85 HEXCOLOR(0xC2C4CA)
#define Color86 HEXCOLOR(0xE20000)
#define Color87 HEXCOLOR(0xF2F2F2)
#define Color88 HEXCOLOR(0xdddddd)
#define Color89 HEXCOLOR(0xD0021B)
#define Color90 HEXCOLOR(0x494949)
#define Color91 HEXCOLOR(0xCBCBCB)
#define Color92 HEXCOLOR(0xF7F8FA)
#define Color93 HEXCOLOR(0x1F1F1F)
#define Color94 HEXCOLOR(0x323643)
#define Color95 HEXCOLOR(0xFFF3DC)
#define Color96 HEXCOLOR(0xFFD052)
#define Color97 HEXCOLOR(0x736FFF)
#define Color98 HEXCOLOR(0xEA6F58)
#define Color99 HEXCOLOR(0xFFD943)
#define Color100 HEXCOLOR(0x6453E1)
#define Color101 HEXCOLOR(0xAB9CFF)
#define Color102 HEXCOLOR(0x6A93F8)
#define Color103 HEXCOLOR(0x8BADFF)
#define Color104 HEXCOLOR(0x505BE2)
#define Color105 HEXCOLOR(0x91BBFF)
#define Color106 HEXCOLOR(0xF77321)
#define Color107 HEXCOLOR(0x4F73F5)
#define Color108 HEXCOLOR(0xF3F3F3)
#define Color109 HEXCOLOR(0x10A0D1)


#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);

#else

#define NSLog(FORMAT, ...) nil

#endif


//#ifdef DEBUG
//
//#define NSLog(fmt, ...) NSLog((@"%s [Line %d] "fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
//
//#else
//
//#define NSLog(...)
//
//#endif


//#ifdef DEBUG
//#define NSLog(...) NSLog(__VA_ARGS__)
//#else
//#define NSLog(...)
//#endif

#endif /* Header_h */




