//
//  GNHAlertController.m
//  GeiNiHua
//
//  Created by ChenYuan on 2017/3/17.
//  Copyright © 2017年 GNH. All rights reserved.
//

#import "GNHAlertController.h"
static NSTimeInterval const GNHAlertShowDurationDefault = 1.5f; //toast默认展示时间
#pragma mark - I.GNHAlertActionModel

@interface GNHAlertActionModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) UIAlertActionStyle style;
@end
@implementation GNHAlertActionModel
- (instancetype)init {
    if (self = [super init]) {
        self.title = @"";
        self.style = UIAlertActionStyleDefault;
    }
    return self;
}
@end

/** 配置AlertAction */
typedef void (^GNHAlertActionsConfig)(GNHAlertActionBlock actionBlock);
@interface GNHAlertController ()
@property (nonatomic, strong) NSMutableArray <GNHAlertActionModel *>* gnh_alertActionArray;
@end

@implementation GNHAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (instancetype)gnh_AlertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle {
    GNHAlertController *alertAC = [self alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    alertAC.gnh_AlertAnimated = YES;
    alertAC.toastStyleDuration = GNHAlertShowDurationDefault;
    return alertAC;
}

- (GNHAlertActionTitle)addActionDefaultTitle {
    return ^(NSString *title) {
        GNHAlertActionModel *model = [[GNHAlertActionModel alloc] init];
        model.title = title;
        model.style = UIAlertActionStyleDefault;
        [self.gnh_alertActionArray addObject:model];
        return self;
    };
}

- (GNHAlertActionTitle)addActionCancelTitle {
    //该block返回值不是本类属性，只是局部变量，不会造成循环引用
    return ^(NSString *title) {
        GNHAlertActionModel *model = [[GNHAlertActionModel alloc] init];
        model.title = title;
        model.style = UIAlertActionStyleCancel;
        [self.gnh_alertActionArray addObject:model];
        return self;
    };
}

- (GNHAlertActionTitle)addActionDestructiveTitle {
    return ^(NSString *title) {
        GNHAlertActionModel *model = [[GNHAlertActionModel alloc] init];
        model.title = title;
        model.style = UIAlertActionStyleDestructive;
        [self.gnh_alertActionArray addObject:model];
        return self;
    };
}

- (NSMutableArray<GNHAlertActionModel *> *)gnh_alertActionArray {
    if (_gnh_alertActionArray == nil) {
        _gnh_alertActionArray = [NSMutableArray array];
    }
    return _gnh_alertActionArray;
}

- (GNHAlertActionsConfig)alertActionsConfig {
    return  ^(GNHAlertActionBlock actionBlock) {
        if (self.gnh_alertActionArray.count > 0) {
            __weak typeof(self) weakself = self;
            [self.gnh_alertActionArray enumerateObjectsUsingBlock:^(GNHAlertActionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.title) {
                    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:obj.title style:obj.style handler:^(UIAlertAction * _Nonnull action) {
                        if (actionBlock) {
                            __strong typeof(weakself) strongSelf = weakself;
                            actionBlock(idx, action, strongSelf);
                        }
                    }];
                    [self addAction:alertAction];
                }
            }];
        } else {
            NSTimeInterval duration = self.toastStyleDuration;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:self.gnh_AlertAnimated completion:^{
                    if (self.toastStyleDidDismiss) {
                        self.toastStyleDidDismiss();
                    }
                }];
            });
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

#pragma mark - III.GNHAlertController扩展使用GNHAlertController
@implementation UIViewController (GNHAlertController)

- (void)gnh_showPreferredStyle:(UIAlertControllerStyle)preferredStyle title:(NSString *)title message:(NSString *)message appearanceProcess:(GNHAlertAppearanceProcess)appearanceProcess actionsBlock:(GNHAlertActionBlock)actionsBlock {
    GNHAlertController *alertAC = [GNHAlertController gnh_AlertControllerWithTitle:title message:message preferredStyle:preferredStyle];

    //配置alert action
    if (appearanceProcess) {
        appearanceProcess(alertAC);
    }
    //配置action 响应
    alertAC.alertActionsConfig(actionsBlock);
    //弹出视图
    [self presentViewController:alertAC animated:alertAC.gnh_AlertAnimated completion:^{
        if (alertAC.alertDidShow) {
            alertAC.alertDidShow();
        }
    }];
}

- (void)gnh_showAlertWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(GNHAlertAppearanceProcess)appearanceProcess actionsBlock:(GNHAlertActionBlock)actionsBlock {
    [self gnh_showPreferredStyle:UIAlertControllerStyleAlert title:title message:message appearanceProcess:appearanceProcess actionsBlock:actionsBlock];
}

- (void)gnh_showSheetWithTitle:(NSString *)title message:(NSString *)message appearanceProcess:(GNHAlertAppearanceProcess)appearanceProcess actionsBlock:(GNHAlertActionBlock)actionsBlock {
    
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
        [self gnh_showPreferredStyle:UIAlertControllerStyleAlert title:title message:message appearanceProcess:appearanceProcess actionsBlock:actionsBlock];
    } else {
        [self gnh_showPreferredStyle:UIAlertControllerStyleActionSheet title:title message:message appearanceProcess:appearanceProcess actionsBlock:actionsBlock];
    }
}
@end
