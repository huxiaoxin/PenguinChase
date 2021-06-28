# CWCarousel

## 基于collectionView实现的通用无限轮播图封装.

> 1. issues里面的可以重现的问题已经修复.
> 2. 部分不能重现的问题暂未处理.
> 3. 请大家提issue尽量描述详细些,最好能提供代码或者截图.请附上是OC版本还是Swift版本的问题.
> 4. 谢谢配合,大家一起进步.
> 代码示例为oc代码, 项目中已有swift版本,请自行下载. oc版本支持cocoaPods安装 `pod search OC_CWCarousel`

#### 未来版本计划
> 1. 优化网络图片获取展示逻辑，添加没有请求到网络数据时会显示轮播图缺省样式！
> 2. 重新修改间距算法，并暴露出对应的属性出来，使自定义间距更加简单化！
> 3. 优化timer相关逻辑，争取把controllerWillAppear 和 controllerWillDisAppear 这两个方法干掉。
> 4. 优化自定义pageControl相关逻辑

#### OC版本记录
| 版本号 | 更新内容 |
| ------ | ------ |
| 1.1.0 | 修复了之前的一些bug |
| 1.1.1 | 添加了无限轮播功能开关 endless |
| 1.1.2 | 控件优化 |
| 1.1.3 | 提升了一个版本号 |
| 1.1.4 | 修复样式3在320尺寸屏幕上可能出现的问题 |
| 1.1.5 | 1.新增了2个代理回调<br>2.点击事件代理回调逻辑优化 |
| 1.1.6 | 适配iOS14 感谢[milletZZ](https://github.com/milletZZ) |

#### swift版本记录
| 版本号 | 更新内容 |
| ------ | :----- |
| 1.1.0 | 功能同OC版 1.1.0 |
| 1.1.1 | 添加了无限轮播功能开关 endless |
| 1.1.2 | 修复样式3在320尺寸屏幕上可能出现的问题 |
| 1.1.3 | 适配swift5.0 |
| 1.1.4 | 修复通过layout创建视图,偶现不自动轮播问题. |
| 1.1.5 | 适配iOS14 感谢[milletZZ](https://github.com/milletZZ) |

<!--![example.gif](https://github.com/baozoudiudiu/CWCarousel/blob/master/CWCarousel/Sources/example.gif)-->
![example.gif](https://upload-images.jianshu.io/upload_images/3096223-64b23965562677f7.gif?imageMogr2/auto-orient/strip)

* 目前支持4种样式
```
typedef NS_ENUM(NSUInteger, CWCarouselStyle) {
CWCarouselStyle_Unknow = 0,     ///<未知样式
CWCarouselStyle_Normal,         ///<普通样式,一张图占用整个屏幕宽度
CWCarouselStyle_H_1,            ///<自定义样式一, 中间一张居中,前后2张图有部分内容在屏幕内可以预览到
CWCarouselStyle_H_2,            ///<自定义样式二, 中间一张居中,前后2张图有部分内容在屏幕内可以预览到,并且中间一张图正常大小,前后2张图会缩放
CWCarouselStyle_H_3,            ///<自定义样式三, 中间一张居中,前后2张图有部分内容在屏幕内可以预览到,中间一张有放大效果,前后2张正常大小
};
```
> CWCarouselStyle_Normal

<!--![normal.gif](https://github.com/baozoudiudiu/CWCarousel/blob/master/CWCarousel/Sources/normal.gif)-->
![normal.gif](https://upload-images.jianshu.io/upload_images/3096223-7a745a375cf86b75.gif?imageMogr2/auto-orient/strip)

> CWCarouselStyle_H_1

<!--![H_1.gif](https://github.com/baozoudiudiu/CWCarousel/blob/master/CWCarousel/Sources/H_1.gif)-->
![H_1.gif](https://upload-images.jianshu.io/upload_images/3096223-04925d699694000a.gif?imageMogr2/auto-orient/strip)
> CWCarouselStyle_H_2

<!--![H_2.gif](https://github.com/baozoudiudiu/CWCarousel/blob/master/CWCarousel/Sources/H_2.gif)-->
![H_2.gif](https://upload-images.jianshu.io/upload_images/3096223-158f78ab0329288e.gif?imageMogr2/auto-orient/strip)

> CWCarouselStyle_H_3

<!--![H_3.gif](https://github.com/baozoudiudiu/CWCarousel/blob/master/CWCarousel/Sources/H_3.gif)-->
![H_3.gif](https://upload-images.jianshu.io/upload_images/3096223-39307907361b1e4d.gif?imageMogr2/auto-orient/strip)

* 控件实例对象创建
1. 创建flowLayout对象,设置轮播图风格
```
/**
构造方法

@param style 轮播图风格
@return 实例对象
*/
- (instancetype)initWithStyle:(CWCarouselStyle)style;

// egg:
CWFlowLayout *flowLayout = [[CWFlowLayout alloc] initWithStyle:[self styleFromTag:tag]];
```
2. 创建容器对象
```
/**
创建实例构造方法

@param frame 尺寸大小
@param delegate 代理
@param datasource 数据源
@param flowLayout 自定义flowlayout
@return 实例对象
*/
- (instancetype _Nullable )initWithFrame:(CGRect)frame
                                delegate:(id<CWCarouselDelegate> _Nullable)delegate
                              datasource:(id<CWCarouselDatasource> _Nullable)datasource
                              flowLayout:(nonnull CWFlowLayout *)flowLayout;

// egg:
CWCarousel *carousel = [[CWCarousel alloc] initWithFrame:self.animationView.bounds
                                                delegate:self
                                              datasource:self
                                              flowLayout:flowLayout];
```
3. 注册自定义cell,并实现代理方法,刷新视图
```
[carousel registerViewClass:[UICollectionViewCell class] identifier:@"cellId"];
[carousel freshCarousel];

#pragma mark - Delegate
// 每个轮播图cell样式
- (UICollectionViewCell *)viewForCarousel:(CWCarousel *)carousel indexPath:(NSIndexPath *)indexPath index:(NSInteger)index{
    UICollectionViewCell *cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    /*
    your code
    */
    return cell;
}

// 点击代理回调
- (void)CWCarousel:(CWCarousel *)carousel didSelectedAtIndex:(NSInteger)index {
    NSLog(@"...%ld...", index);
}

// 轮播图个数
- (NSInteger)numbersForCarousel {
    return kCount;
}
```

4. 为了流畅性和避免概率图片位置错乱问题,当开启自动滚动时,在banner所处的控制器生命周期中需要调用以下对应方法
```
/**
轮播图所处控制器WillAppear方法里调用
*/
- (void)controllerWillAppear;

/**
轮播图所处控制器WillDisAppear方法里调用
*/
- (void)controllerWillDisAppear;
```
* 具体UI样式修改都有具体的属性,详情请查看对应类的.h文件即可. 
* 如有问题和bug,欢迎指正.

