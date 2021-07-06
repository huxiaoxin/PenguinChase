//
//  PenguinChaseSearchingViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/6.
//

#import "PenguinChaseSearchingViewController.h"
#import "PenguinChaseHomeTableViewCell.h"
@interface PenguinChaseSearchingViewController ()

@end

@implementation PenguinChaseSearchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"搜索结果";
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseHomeTableViewCell * PenguinCell = [PenguinChaseHomeTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
    return PenguinCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RealWidth(120);
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
