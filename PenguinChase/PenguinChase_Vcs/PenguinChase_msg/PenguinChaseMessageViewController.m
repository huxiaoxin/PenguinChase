//
//  PenguinChaseMessageViewController.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/28.
//

#import "PenguinChaseMessageViewController.h"
#import "PenguinChaseMessageTableViewCell.h"
#import "PenguinChasesystemMessageTableViewCell.h"
#import "PenguinsystemMessageModel.h"
#import "PenguinChaseZanComentViewController.h"
#import "PenguinChaseKefuViewController.h"
#import "PenguinChaseNotificationViewController.h"
@interface PenguinChaseMessageViewController ()
@property(nonatomic,strong) NSMutableArray * PenguinChasesysMessageDataArr;
@property(nonatomic,strong) NSMutableArray * PenguinChaseDataArr;
@end

@implementation PenguinChaseMessageViewController
- (NSMutableArray *)PenguinChaseDataArr{
    if (!_PenguinChaseDataArr) {
        _PenguinChaseDataArr = [NSMutableArray array];
    }
    return _PenguinChaseDataArr;
}
- (NSMutableArray *)PenguinChasesysMessageDataArr{
    if (!_PenguinChasesysMessageDataArr) {
        _PenguinChasesysMessageDataArr = [NSMutableArray array];
        PenguinsystemMessageModel * messageModel = [[PenguinsystemMessageModel alloc]init];
        messageModel.img = @"zan_hong";
        messageModel.Name = @"赞";
        messageModel.messageNums = @"11";
        [_PenguinChasesysMessageDataArr addObject:messageModel];
        
        
        PenguinsystemMessageModel * messageModel1 = [[PenguinsystemMessageModel alloc]init];
        messageModel1.img = @"pinglunzan";
        messageModel1.Name = @"评论";
        messageModel1.messageNums = @"0";
        [_PenguinChasesysMessageDataArr addObject:messageModel1];
        
        
        PenguinsystemMessageModel * messageModel2 = [[PenguinsystemMessageModel alloc]init];
        messageModel2.img = @"xitongxiaoxi";
        messageModel2.Name = @"系统消息";
        messageModel2.messageNums = @"1";
        [_PenguinChasesysMessageDataArr addObject:messageModel2];
        
        PenguinsystemMessageModel * messageModel3 = [[PenguinsystemMessageModel alloc]init];
        messageModel3.img = @"zaixiankefuicon";
        messageModel3.Name = @"在线客服";
        messageModel3.messageNums = @"0";
        [_PenguinChasesysMessageDataArr addObject:messageModel3];
        
    }
    return _PenguinChasesysMessageDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"消息中心";
    self.PenguinChaseTableView.frame = CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, GK_SCREEN_WIDTH, GK_SCREEN_HEIGHT-GK_TABBAR_HEIGHT-GK_STATUSBAR_NAVBAR_HEIGHT);
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.PenguinChasesysMessageDataArr.count;
    }else{
        return 0;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PenguinChasesystemMessageTableViewCell * penguinCell = [PenguinChasesystemMessageTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
        penguinCell.penguinMessageModel = self.PenguinChasesysMessageDataArr[indexPath.row];
        return penguinCell;
    }else{
        PenguinChaseMessageTableViewCell * penguinCell = [PenguinChaseMessageTableViewCell PenguinChasecreateCellWithTheTableView:tableView AndTheIndexPath:indexPath];
        return penguinCell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            PenguinChaseZanComentViewController * pengZanvc = [[PenguinChaseZanComentViewController alloc]init];
            pengZanvc.index = 0;
            pengZanvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pengZanvc animated:YES];
        }else if (indexPath.row == 1){
            PenguinChaseZanComentViewController * pengZanvc = [[PenguinChaseZanComentViewController alloc]init];
            pengZanvc.index = 1;
            pengZanvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pengZanvc animated:YES];
            
        }else if (indexPath.row == 2){
            PenguinChaseNotificationViewController * penguinNotiVc = [[PenguinChaseNotificationViewController alloc]init];
            penguinNotiVc.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:penguinNotiVc animated:YES];
        }else if (indexPath.row == 3){
            PenguinChaseKefuViewController  * penguinkefuVc = [[PenguinChaseKefuViewController alloc]init];
            penguinkefuVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:penguinkefuVc animated:YES];
        }
    }else{
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return RealWidth(60);
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
