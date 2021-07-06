//
//  PenguinChase_BaseViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/28.
//

#import "PenguinChase_BaseViewController.h"
#import "PenguinChaseLoginViewController.h"
@interface PenguinChase_BaseViewController ()

@end

@implementation PenguinChase_BaseViewController
-(void)PenguinChase_showLoginVc{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        PenguinChaseLoginViewController  * penguinLoginVc = [PenguinChaseLoginViewController new];
        
        UINavigationController * penguinNav = [UINavigationController rootVC:penguinLoginVc];
        [self presentViewController:penguinNav animated:YES completion:nil];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
