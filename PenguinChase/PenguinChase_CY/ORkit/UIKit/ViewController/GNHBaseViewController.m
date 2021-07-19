//
//  GNHBaseViewController.m
//  GeiNiHua
//
//  Created by ChenYuan on 2016/10/9.
//  Copyright © 2016年 GNH. All rights reserved.
//

#import "GNHBaseViewController.h"
#import "NSObject+GNHDataModel.h"
#import "AppDelegate.h"

@interface GNHBaseViewController ()

@property (nonatomic, strong) NSMutableArray *models;

@end

@implementation GNHBaseViewController

#pragma mark - Deallocated

- (void)dealloc
{
    if (_models) {
        [_models enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[GNHBaseDataModel class]]) {
                [(GNHBaseDataModel *)obj cancel];
            }
        }];
    }
}

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = LGDViewBJColor;
    
    self.models = [NSMutableArray array];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

//    self.tabBarController.tabBar.superview.backgroundColor = gnh_color_b;

    UIImage *image = [[UIImage imageNamed:@"pandaMoview_leff_white_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationController.navigationBar setBackIndicatorImage:image];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:image];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction:)];
    self.navigationItem.backBarButtonItem = backItem;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupNotifications];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.isViewDidAppeared = YES;
    self.isViewAppearing = YES;

    if (self.viewDidAppearBlock) {
        self.viewDidAppearBlock();
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    
    self.isViewAppearing = NO;
    if (self.isMovingFromParentViewController || self.isBeingDismissed || self.navigationController.isMovingFromParentViewController) {
        [self viewControllerWillDisappear];
    }
    
    if (self.viewWillDisappearBlock) {
        self.viewWillDisappearBlock();
    }
    
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    if (self.isMovingFromParentViewController || self.isBeingDismissed || self.navigationController.isMovingFromParentViewController) {
        [self viewControllerDidDisappear];
    }
    
    [super viewDidDisappear:animated];
}

- (void)viewControllerWillDisappear {}
- (void)viewControllerDidDisappear {}

#pragma mark - Setup

- (void)setupNotifications {}
- (void)setupDataModels {}

- (__kindof NSArray *)autoShowSVPWithDataModel
{
    return nil;
}

- (BOOL)viewControllerAppearAtFirstTime
{
    return (self.isMovingToParentViewController || self.isBeingPresented);
}

- (void)setIsShouldOrientationMaskAll:(BOOL)isShouldOrientationMaskAll
{
    AppDelegate *delegate = [AppDelegate shareDelegate];
    delegate.isShouldOrientationMaskAll = isShouldOrientationMaskAll;
}

#pragma mark - GNHBaseDataModelDelegate

- (void)dataModelWillLoad:(GNHBaseDataModel *)gnhModel
{
    if ([self autoShowSVPWithDataModel] && gnhModel.isShowSVProgressLoading) {
        NSString *status = gnhModel.loadTips.length ? gnhModel.loadTips : @"加载中...";
        BOOL flag = NO;
        for (GNHBaseDataModel *model in [self autoShowSVPWithDataModel]) {
            if (gnhModel == model) {
                flag = YES;
                break;
            }
        }
        if (flag) {
            if (gnhModel.enableUserInteraction) {
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
                [SVProgressHUD showWithStatus:status];
            } else {
                [SVProgressHUD showWithStatus:status];
            }
        }
    }
}

- (void)networkFailNotify:(GNHBaseDataModel *)gnhModel
{
    if (gnhModel.error && gnhModel.isAutoShowNetworkErrorToast) {
        [self gnh_showCommonBussinessDataModelError:gnhModel];
    }
}

- (void)parseDataError:(GNHBaseDataModel *)gnhModel
{
}

- (BOOL)shoudAutoRequestAfterLoadCache:(GNHBaseDataModel *)gnhModel
{
    return NO;
}

#pragma mark - Action

- (void)leftButtonAction:(UIButton *)btn
{
    [ORMainAPI leaveCurrentPage:self animated:YES completion:nil];
}

- (void)rightButtonAction:(UIButton *)btn {}

- (void)titleButtonAction:(UIButton *)btn {}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

#pragma mark - model & network UIs

@implementation GNHBaseViewController (Model)

// 配置mdoel GNHBaseDataModel
- (__kindof GNHBaseDataModel *)produceModel:(Class)modelClass
{
    GNHBaseDataModel *rawModel = [[modelClass alloc] init];
    [self.models mdf_safeAddObject:rawModel];
    rawModel.delegate = self;
    
    __weak typeof(self) weakself = self;
    [rawModel setCompletionBlock:^(id <MDFNetworkModelProtocol> model){
        GNHBaseDataModel *gnhModel = (GNHBaseDataModel *)model;
        GNHRootBaseItem *baseItem = nil;
        if ([gnhModel.parsedItem isKindOfClass:[GNHRootBaseItem class]]) {
            baseItem = (GNHRootBaseItem *)gnhModel.parsedItem;
        }
        
        // 兜底SVProgressHUD 模态请求后dissmiss逻辑异常
        if (!gnhModel.disableAutoDismiss && gnhModel.isResponseSucess) {
            [SVProgressHUD dismiss];
        }
        
        // 网络数据
        if (gnhModel.isServerDataCorrectAndNetworkRequestSuccess) {
            [weakself handleDataModelSuccess:gnhModel];
        } else {
            if (gnhModel.isShowDefaultView && gnhModel.error) {
                // error page
            }
            [weakself handleDataModelError:gnhModel];
        }
    }];
    
    return rawModel;
}

// 请求成功
- (void)handleDataModelSuccess:(GNHBaseDataModel *)gnhModel{}

// 请求失败
- (void)handleDataModelError:(GNHBaseDataModel *)gnhModel
{
    if (gnhModel.isAutoShowBusinessErrorToast) {
        [self gnh_showCommonBussinessDataModelError:gnhModel];
    }
}

@end
