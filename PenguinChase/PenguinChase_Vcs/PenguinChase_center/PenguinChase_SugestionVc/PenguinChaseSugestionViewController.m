
#import "PenguinChaseSugestionViewController.h"
#import <UITextView+ZWPlaceHolder.h>
#import <UITextView+ZWLimitCounter.h>
#import "PenguinChaseAdviceCollectionCell.h"
#import <RITLPhotos.h>
#import <HUPhotoBrowser/HUPhotoBrowser.h>
@interface PenguinChaseSugestionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,RITLPhotosViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,PenguinChaseCollectionCellDelegate>
@property(nonatomic,strong) UIScrollView * PenguinSugestionScrollView;
@property(nonatomic,strong) UICollectionView * PenguinChaseSugestonCollectioinView;
@property(nonatomic,strong) NSMutableArray * PenguinChaseSugestonDataArr;
@property(nonatomic,strong) UILabel * PenguinChaseSugestonToplbs;
@property(nonatomic,strong) UIImagePickerController *PenguinChaseSugestonPickVers;
@property(nonatomic,strong) UIButton * PenguinChaseSugestonBtn;
@property(nonatomic,strong) UITextView * PenguinChaseSugestonTextViews;
@end

@implementation PenguinChaseSugestionViewController

-(NSMutableArray *)PenguinChaseSugestonDataArr{
    if (!_PenguinChaseSugestonDataArr) {
        _PenguinChaseSugestonDataArr = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"add"], nil];
    }
    return _PenguinChaseSugestonDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navLineHidden = YES;
    self.gk_navTitle = @"意见反馈";
    [self.view addSubview:self.PenguinSugestionScrollView];
    
    UILabel * PenguinChaseDesclb = [[UILabel alloc]initWithFrame:CGRectMake(K(15.5), K(22), K(200), K(15))];
    PenguinChaseDesclb.text = @"问题描述";
    PenguinChaseDesclb.font = [UIFont fontWithName:@"PingFangSC-Medium" size:K(16)];
    PenguinChaseDesclb.textColor = [UIColor colorWithHexString:@"#333333"];
    [_PenguinSugestionScrollView addSubview:PenguinChaseDesclb];
    
    
    UITextView * PenguinChaseSugestonTextViews = [[UITextView alloc]initWithFrame:CGRectMake(K(15.5), CGRectGetMaxY(PenguinChaseDesclb.frame)+K(11.5), SCREEN_Width-K(31), K(102.5))];
    PenguinChaseSugestonTextViews.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    PenguinChaseSugestonTextViews.zw_placeHolder =  @"请输入您的意见或建议";
    PenguinChaseSugestonTextViews.zw_limitCount = 1000;
    PenguinChaseSugestonTextViews.zw_placeHolderColor = [UIColor colorWithHexString:@"#B3B3B3"];
    PenguinChaseSugestonTextViews.layer.cornerRadius = K(5);
    PenguinChaseSugestonTextViews.layer.masksToBounds = YES;
    [_PenguinSugestionScrollView addSubview:PenguinChaseSugestonTextViews];
    _PenguinChaseSugestonTextViews = PenguinChaseSugestonTextViews;
    
    
    UILabel * PenguinChaseSugestonToplbs = [[UILabel alloc]initWithFrame:CGRectMake(K(15.5), K(22)+CGRectGetMaxY(PenguinChaseSugestonTextViews.frame), K(200), K(15))];
    PenguinChaseSugestonToplbs.text = @"上传图片";
    PenguinChaseSugestonToplbs.font = [UIFont fontWithName:@"PingFangSC-Medium" size:K(16)];
    PenguinChaseSugestonToplbs.textColor = [UIColor colorWithHexString:@"#333333"];
    [_PenguinSugestionScrollView addSubview:PenguinChaseSugestonToplbs];
    _PenguinChaseSugestonToplbs  =PenguinChaseSugestonToplbs;
    [_PenguinSugestionScrollView addSubview:self.PenguinChaseSugestonCollectioinView];
    [_PenguinChaseSugestonCollectioinView registerClass:[PenguinChaseAdviceCollectionCell class] forCellWithReuseIdentifier:@"PenguinChaseAdviceCollectionCell"];
    [_PenguinSugestionScrollView addSubview:self.PenguinChaseSugestonBtn];
}
-(UIButton *)PenguinChaseSugestonBtn{
    if (!_PenguinChaseSugestonBtn) {
        _PenguinChaseSugestonBtn  =[[UIButton alloc]initWithFrame:CGRectMake(K(22.5), CGRectGetMaxY(_PenguinChaseSugestonCollectioinView.frame)+K(50), SCREEN_Width-K(45), K(40))];
        _PenguinChaseSugestonBtn.layer.cornerRadius =  K(20);
        _PenguinChaseSugestonBtn.layer.masksToBounds = YES;
        [_PenguinChaseSugestonBtn setBackgroundColor:LGDMianColor];
        [_PenguinChaseSugestonBtn setTitle:@"提交" forState:UIControlStateNormal];
        _PenguinChaseSugestonBtn.titleLabel.font = [UIFont systemFontOfSize:K(15)];
        _PenguinChaseSugestonBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_PenguinChaseSugestonBtn addTarget:self action:@selector(PenguinChaseSugestonBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PenguinChaseSugestonBtn;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.PenguinChaseSugestonDataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PenguinChaseAdviceCollectionCell * PenguinChaseSugeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PenguinChaseAdviceCollectionCell" forIndexPath:indexPath];
    PenguinChaseSugeCell.tag = indexPath.row;
    PenguinChaseSugeCell.Delegate = self;
    PenguinChaseSugeCell.penguinimmgs = self.PenguinChaseSugestonDataArr[indexPath.row];
    return PenguinChaseSugeCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.PenguinChaseSugestonDataArr.count-1) {
        if (self.PenguinChaseSugestonDataArr.count > 6) {
            [LCProgressHUD showInfoMsg:@"最多只能上传5张"];
            return;
        }
        [self PenguinChaseSugeLoaphotVcs];
    }else{
        //浏览图片
        PenguinChaseAdviceCollectionCell * PenguinChaseSugeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PenguinChaseAdviceCollectionCell" forIndexPath:indexPath];
        NSMutableArray * PenguinChaseSugeTempArr = self.PenguinChaseSugestonDataArr.mutableCopy;
        [PenguinChaseSugeTempArr removeObject:[UIImage imageNamed:@"add"]];
        [HUPhotoBrowser showFromImageView:PenguinChaseSugeCell.pengiinImgViews withImages:PenguinChaseSugeTempArr atIndex:indexPath.row];
    }
}
//提交
-(void)PenguinChaseSugestonBtnClick{
    if (_PenguinChaseSugestonTextViews.text.length == 0) {
        
        [LCProgressHUD showInfoMsg:@"请输入个人建议"];
        return;
    }

    
    if ([FilmFactoryAccountComponent checkLogin:YES]) {
    
    [LCProgressHUD showLoading:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD showSuccess:@"感谢反馈,结果会24h通知到你的手机号上"];
        [self.navigationController popViewControllerAnimated:YES];
    });}
    
}
#pragma mark--
-(void)PenguinChaseCollectionCellDelegateWithBtnCliocks:(NSInteger)SanXiandex{
    UIImage * keqiangboySugeImgs = self.PenguinChaseSugestonDataArr[SanXiandex];
    if (keqiangboySugeImgs !=[UIImage imageNamed:@"add"]) {
        [self.PenguinChaseSugestonDataArr removeObjectAtIndex:SanXiandex];
        [self.PenguinChaseSugestonCollectioinView reloadData];
        self.PenguinChaseSugestonCollectioinView.height = self.PenguinChaseSugestonCollectioinView.collectionViewLayout.collectionViewContentSize.height;
        self.PenguinChaseSugestonBtn.y = CGRectGetMaxY(_PenguinChaseSugestonCollectioinView.frame)+K(50);
    }
}
- (void)photosViewController:(UIViewController *)viewController
                      images:(NSArray <UIImage *> *)images
                       infos:(NSArray <NSDictionary *> *)infos{
    [self.PenguinChaseSugestonDataArr addObjectsFromArray:images];
    
    MJWeakSelf;
    [self.PenguinChaseSugestonDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage * keqiangboySugeImgs = (UIImage *)obj;
        if (keqiangboySugeImgs == [UIImage imageNamed:@"add"]) {
            [weakSelf.PenguinChaseSugestonDataArr removeObject:keqiangboySugeImgs];
            *stop = YES;
        }
    }];
    
    [self.PenguinChaseSugestonDataArr addObject:[UIImage imageNamed:@"add"]];
    [self.PenguinChaseSugestonCollectioinView reloadData];
    self.PenguinChaseSugestonCollectioinView.height = self.PenguinChaseSugestonCollectioinView.collectionViewLayout.collectionViewContentSize.height;
    self.PenguinChaseSugestonBtn.y = CGRectGetMaxY(_PenguinChaseSugestonCollectioinView.frame)+K(50);
}

-(UIImagePickerController *)PenguinChaseSugestonPickVers{
    if (!_PenguinChaseSugestonPickVers) {
        _PenguinChaseSugestonPickVers = [[UIImagePickerController alloc] init];
        _PenguinChaseSugestonPickVers.delegate = self;
        _PenguinChaseSugestonPickVers.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        _PenguinChaseSugestonPickVers.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        _PenguinChaseSugestonPickVers.allowsEditing = YES;
    }
    return _PenguinChaseSugestonPickVers;
}
-(void)PenguinChaseSugeLoaphotVcs{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus keqiangboySugeLautor = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(keqiangboySugeLautor == AVAuthorizationStatusRestricted || keqiangboySugeLautor == AVAuthorizationStatusDenied){
        NSString *errorStr = @"应用相机权限受限,请在设置中启用";
        [LCProgressHUD showInfoMsg:errorStr];
        return;
    }
    RITLPhotosViewController *PneguincSugeVcs = RITLPhotosViewController.photosViewController;
    PneguincSugeVcs.configuration.maxCount = 5;
    PneguincSugeVcs.configuration.containVideo = false;
    PneguincSugeVcs.photo_delegate = self;
    [self presentViewController:PneguincSugeVcs animated:true completion:^{}];
}

-(UICollectionView *)PenguinChaseSugestonCollectioinView{
    if (!_PenguinChaseSugestonCollectioinView) {
        UICollectionViewFlowLayout * PenguinChaseSugeLayouts =[[UICollectionViewFlowLayout alloc]init];
        PenguinChaseSugeLayouts.itemSize = CGSizeMake(K(155/2),  K(155/2+7.5));
        PenguinChaseSugeLayouts.sectionInset =  UIEdgeInsetsMake(0, K(15), 0, K(15));
        PenguinChaseSugeLayouts.minimumLineSpacing = K(12);
        PenguinChaseSugeLayouts.minimumInteritemSpacing = K(12);
        _PenguinChaseSugestonCollectioinView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_PenguinChaseSugestonToplbs.frame)+K(22), SCREEN_Width, K(155/2+7.5)) collectionViewLayout:PenguinChaseSugeLayouts];
        _PenguinChaseSugestonCollectioinView.delegate = self;
        _PenguinChaseSugestonCollectioinView.dataSource = self;
        _PenguinChaseSugestonCollectioinView.showsVerticalScrollIndicator = NO;
        _PenguinChaseSugestonCollectioinView.showsHorizontalScrollIndicator = NO;
        _PenguinChaseSugestonCollectioinView.backgroundColor = [UIColor whiteColor];
    }
    return _PenguinChaseSugestonCollectioinView;
}
-(UIScrollView *)PenguinSugestionScrollView{
    if (!_PenguinSugestionScrollView) {
        _PenguinSugestionScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NaviH, SCREEN_Width, SCREEN_Height-NaviH-GK_SAFEAREA_BTM)];
        _PenguinSugestionScrollView.backgroundColor = [UIColor whiteColor];
        _PenguinSugestionScrollView.showsHorizontalScrollIndicator = NO;
        _PenguinSugestionScrollView.showsVerticalScrollIndicator  =NO;
        _PenguinSugestionScrollView.contentSize = CGSizeMake(SCREEN_Width, SCREEN_Height);
    }
    return _PenguinSugestionScrollView;
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





