#import "PenguinChaseFabuViewController.h"
#import <UITextView+ZWPlaceHolder.h>
#import <UITextView+ZWLimitCounter.h>
#import "PenguinhaseSendZoneCollectionCell.h"
#import <HUPhotoBrowser-umbrella.h>
#import <RITLPhotos/RITLPhotos.h>

@interface PenguinChaseFabuViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,RITLPhotosViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong) UICollectionView * PenguinChaseFabuColltionView;
@property(nonatomic,strong) NSMutableArray * PenguinChaseSendDataArr;
@property(nonatomic,strong) UITextView * PenguinChaseSendTextViews;
@property(nonatomic,strong) UIImagePickerController *PenguinChaseSendPickers;
@end

@implementation PenguinChaseFabuViewController

-(NSMutableArray *)PenguinChaseSendDataArr{
    if (!_PenguinChaseSendDataArr) {
        _PenguinChaseSendDataArr = [[NSMutableArray alloc]init];
        [_PenguinChaseSendDataArr addObject:[UIImage imageNamed:@"add"]];
    }
    return _PenguinChaseSendDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * PenguinChaseSenView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, K(80), K(40))];
    UIButton * PenguinChaseCacnleBtn = [[UIButton alloc]initWithFrame:CGRectMake(K(15), K(5), K(40), K(20))];
    [PenguinChaseCacnleBtn setTitle:@"取消" forState:UIControlStateNormal];
    PenguinChaseCacnleBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    [PenguinChaseCacnleBtn setTitleColor:LGDGaryColor forState:UIControlStateNormal];
    [PenguinChaseCacnleBtn addTarget:self action:@selector(PenguinChaseCacnleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [PenguinChaseSenView addSubview:PenguinChaseCacnleBtn];
    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:PenguinChaseSenView];
    
    
    UIView * PenguinChaseSendViews =[[UIView alloc]initWithFrame:CGRectMake(0, 0, K(80), K(40))];
    UIButton * PenguinChaseSendbtns = [[UIButton alloc]initWithFrame:CGRectMake(K(15), K(5), K(40), K(20))];
    [PenguinChaseSendbtns setTitle:@"发布" forState:UIControlStateNormal];
    PenguinChaseSendbtns.titleLabel.font = [UIFont systemFontOfSize:14];
    [PenguinChaseSendbtns setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [PenguinChaseSendbtns addTarget:self action:@selector(PenguinChaseSendbtnsClick) forControlEvents:UIControlEventTouchUpInside];
    [PenguinChaseSendViews addSubview:PenguinChaseSendbtns];
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:PenguinChaseSendViews];
    
    
    UITextView * PenguinChaseSendTextViews = [[UITextView alloc]initWithFrame:CGRectMake(K(15), NaviH+K(15), SCREEN_Width-K(20), K(120))];
    PenguinChaseSendTextViews.zw_placeHolder = @"说点什么吧....";
    PenguinChaseSendTextViews.zw_placeHolderColor = LGDGaryColor;
    PenguinChaseSendTextViews.font = [UIFont systemFontOfSize:14];
    PenguinChaseSendTextViews.textColor = [UIColor blackColor];
    PenguinChaseSendTextViews.zw_limitCount =  1500;
    [self.view addSubview:PenguinChaseSendTextViews];
    _PenguinChaseSendTextViews = PenguinChaseSendTextViews;
    
    
    
    UICollectionViewFlowLayout * PenguinChaseSendLayout = [[UICollectionViewFlowLayout alloc]init];
    PenguinChaseSendLayout.sectionInset =  UIEdgeInsetsMake(0, K(15), 0, K(30));
    PenguinChaseSendLayout.itemSize  = CGSizeMake(K(100), K(100));
    UICollectionView * PenguinChaseSenLCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(PenguinChaseSendTextViews.frame)+K(20), SCREEN_Width, K(200)) collectionViewLayout:PenguinChaseSendLayout];
    PenguinChaseSenLCollectionView.delegate = self;
    PenguinChaseSenLCollectionView.dataSource = self;
    PenguinChaseSenLCollectionView.showsVerticalScrollIndicator = NO;
    PenguinChaseSenLCollectionView.showsHorizontalScrollIndicator = NO;
    PenguinChaseSenLCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:PenguinChaseSenLCollectionView];
    [PenguinChaseSenLCollectionView registerClass:[PenguinhaseSendZoneCollectionCell class] forCellWithReuseIdentifier:@"PenguinhaseSendZoneCollectionCell"];
    _PenguinChaseFabuColltionView = PenguinChaseSenLCollectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.PenguinChaseSendDataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PenguinhaseSendZoneCollectionCell * PenginChaseSenLCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PenguinhaseSendZoneCollectionCell" forIndexPath:indexPath];
    PenginChaseSenLCell.PeuinChaseImgViewIcon.image = self.PenguinChaseSendDataArr[indexPath.row];
    return PenginChaseSenLCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PenguinhaseSendZoneCollectionCell * PenginChaseSenLCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PenguinhaseSendZoneCollectionCell" forIndexPath:indexPath];
    if (indexPath.row == self.PenguinChaseSendDataArr.count -1) {
        [self PenguinChaseSenPhotVcs];
    }else{
        NSMutableArray * PenguinDataArr = self.PenguinChaseSendDataArr;
        [PenguinDataArr removeLastObject];
        [HUPhotoBrowser showFromImageView:PenginChaseSenLCell.PeuinChaseImgViewIcon withImages:PenguinDataArr atIndex:indexPath.row];
    }
    
}
- (void)photosViewController:(UIViewController *)viewController
                      images:(NSArray <UIImage *> *)images
                       infos:(NSArray <NSDictionary *> *)infos{
    [self.PenguinChaseSendDataArr addObjectsFromArray:images];
    MJWeakSelf;
    [self.PenguinChaseSendDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage * WindwounnTrenSendImg = (UIImage *)obj;
        if (WindwounnTrenSendImg == [UIImage imageNamed:@"add"]) {
            [weakSelf.PenguinChaseSendDataArr removeObject:WindwounnTrenSendImg];
            *stop = YES;
        }
    }];
    [self.PenguinChaseSendDataArr addObject:[UIImage imageNamed:@"add"]];
    [self.PenguinChaseFabuColltionView reloadData];
    self.PenguinChaseFabuColltionView.height = self.PenguinChaseFabuColltionView.collectionViewLayout.collectionViewContentSize.height;
}

-(UIImagePickerController *)PenguinChaseSendPickers{
    if (!_PenguinChaseSendPickers) {
        _PenguinChaseSendPickers = [[UIImagePickerController alloc] init];
        _PenguinChaseSendPickers.delegate = self;
        _PenguinChaseSendPickers.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        _PenguinChaseSendPickers.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        _PenguinChaseSendPickers.allowsEditing = YES;
    }
    return _PenguinChaseSendPickers;
}
-(void)PenguinChaseSenPhotVcs{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSString *errorStr = @"应用相机权限受限,请在设置中启用";
        [LCProgressHUD showInfoMsg:errorStr];
        return;
    }
    RITLPhotosViewController *PenguinChasePhotoVc = RITLPhotosViewController.photosViewController;
    PenguinChasePhotoVc.configuration.maxCount = 5;
    PenguinChasePhotoVc.configuration.containVideo = false;
    PenguinChasePhotoVc.photo_delegate = self;
    [self presentViewController:PenguinChasePhotoVc  animated:true completion:^{}];
}

#pragma mark--发布
-(void)PenguinChaseSendbtnsClick{
    if (_PenguinChaseSendTextViews.text.length == 0) {
        [LCProgressHUD showInfoMsg:@"说点什么吧~"];
        return;
    }
    
    [LCProgressHUD showLoading:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD showSuccess:@"发布成功,请等待平台审核后显示!"];
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    
    
}
-(void)PenguinChaseCacnleBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
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



