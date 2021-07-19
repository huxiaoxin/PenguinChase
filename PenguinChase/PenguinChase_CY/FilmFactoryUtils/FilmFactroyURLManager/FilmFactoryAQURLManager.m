

#import "FilmFactoryAQURLManager.h"
#import "PandaMovieH5ViewController.h"

@implementation FilmFactoryAQURLManager

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)jumpWithType:(NSString *)urlStr type:(NSInteger)type title:(nonnull NSString *)title
{
    NSDictionary *params = [self parameterWithURL:urlStr.urlWithString];
    if (urlStr.length) {
        switch (type) {
            case 0: {
                UIViewController *vc = [[PandaMovieH5ViewController alloc] initWithURL:urlStr.urlWithString];
                vc.edgesForExtendedLayout = UIRectEdgeNone;
                vc.title = title;
                [[UIViewController mdf_toppestViewController].navigationController pushViewController:vc animated:YES];
                
                break;
            }
            default:
                [ORMainAPI openScheme:urlStr completion:nil]; // 浏览器打开
                break;
        }
    }
}

- (NSDictionary *)parameterWithURL:(NSURL *)url
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithCapacity:2];
    
    //传入url创建url组件类
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
    
    //回调遍历所有参数，添加入字典
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [params setObject:obj.value forKey:obj.name];
    }];
    
    return params;
}


@end
