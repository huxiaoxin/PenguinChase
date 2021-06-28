#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^lbTapAction)(id object);
@interface UILabel (CDGPSpaceLb)
-(void)AddlbTapActionWith:(lbTapAction)item;
//设置一行文字相邻间距
- (void)setText:(NSString *)text spacing:(CGFloat)spacing;
//设置行与行之间的距离
- (void)setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing;
- (void)setText:(NSString *)text  appendingText:(NSString *)appendingstr lineSpacing:(CGFloat)lineSpacing;
-(CGSize)getSpaceLabelSize:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;
//计算行数
-(NSInteger)rowsOfString:(NSString *)text withFont:(UIFont *)font withWidth:(CGFloat)width;
- (void)setText:(NSString *)text  textColor:(UIColor *)textColor appendingImg:(NSString *)appendingimg lineSpacing:(CGFloat)lineSpacing;
- (void)setText:(NSString *)text  textColor:(UIColor *)textColor appendingImg:(NSString *)appendingimg  imgIndex:(NSInteger)imgIndex lineSpacing:(CGFloat)lineSpacing;

@end
NS_ASSUME_NONNULL_END
