//
//  PenguinChaseBangdanViewController.m
//  PenguinChase
//
//  Created by codehzx on 2021/7/3.
//

#import "PenguinChaseBangdanViewController.h"
#import "PenguinChaseBangdanTableViewCell.h"
@interface PenguinChaseBangdanViewController ()

@end

@implementation PenguinChaseBangdanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"热门榜单";
    self.PenguinChaseTableView.estimatedRowHeight = RealWidth(150);
    
    
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseBangdanTableViewCell * penguinCell =  [PenguinChaseBangdanTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    return penguinCell;
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
