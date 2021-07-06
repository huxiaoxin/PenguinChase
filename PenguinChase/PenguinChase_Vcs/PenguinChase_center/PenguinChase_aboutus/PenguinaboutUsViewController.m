//
//  PenguinaboutUsViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/6.
//

#import "PenguinaboutUsViewController.h"
#import <WebKit/WebKit.h>

@interface PenguinaboutUsViewController ()

@end

@implementation PenguinaboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"关于我们";
    WKWebViewConfiguration * PenguinchaseConfigar  = [[WKWebViewConfiguration alloc]init];
    WKWebView * PengunCaseWebs = [[WKWebView alloc]initWithFrame:CGRectMake(0, NaviH, SCREEN_Width, SCREEN_Height-NaviH-GK_SAFEAREA_BTM) configuration:PenguinchaseConfigar];
    PengunCaseWebs.scrollView.showsVerticalScrollIndicator =  NO;
    [self.view addSubview:PengunCaseWebs];
    NSString * PenguinHtmlText  = [[NSBundle mainBundle] pathForResource:@"PenguinAbout" ofType:@"html"];
    [PengunCaseWebs loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:PenguinHtmlText]]];
    // Do any additional setup after loading the view.
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
