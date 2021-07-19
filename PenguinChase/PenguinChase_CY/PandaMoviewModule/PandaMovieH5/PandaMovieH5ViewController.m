

#import "PandaMovieH5ViewController.h"

@interface PandaMovieH5ViewController ()

@end

@implementation PandaMovieH5ViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.progressTintColor = gnh_color_c;
        self.backItemImgName = @"pandaMoview_left_balck_arrow";
        self.allowsBFNavigationGesture = YES;
        self.isHiddleLeftItemBar = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.superview.backgroundColor = gnh_color_b;
}

@end
