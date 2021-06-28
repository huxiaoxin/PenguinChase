#import "UILabel+CDGPSpaceLb.h"
#import <CoreText/CoreText.h>
#define HEIGHT [ [ UIScreen mainScreen ] bounds ].size.height
@implementation UILabel (CDGPSpaceLb)
-(void)AddlbTapActionWith:(lbTapAction)item{
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, @selector(lbTapAction:), item, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UITapGestureRecognizer * lbTapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lbTapAction:)];
    [self addGestureRecognizer:lbTapgesture];
    
}
-(void)lbTapAction:(UITapGestureRecognizer *)lbtap{
    UILabel * lb = (UILabel *)[lbtap view];
    lbTapAction lblock =  objc_getAssociatedObject(self, _cmd);
    if (lblock) {
        lblock(lb);
    }
}
- (void)setText:(NSString *)text spacing:(CGFloat)spacing{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSKernAttributeName:@(spacing)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:self.textAlignment];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length]-1)];
    self.attributedText = attributedString;
    [self sizeToFit];
}
- (void)setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing
{
    if (!text || lineSpacing < 0.01) {
        self.text = text;
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}
- (void)setText:(NSString *)text  appendingText:(NSString *)appendingstr lineSpacing:(CGFloat)lineSpacing{
    if (!text || lineSpacing < 0.01) {
        self.text = text;
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    NSString * TottalText = [NSString stringWithFormat:@"%@%@",text,appendingstr];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:TottalText];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [TottalText length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#666666"] range:NSMakeRange(0, text.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FF6C00"] range:NSMakeRange(text.length, appendingstr.length)];
    self.attributedText = attributedString;
}
- (void)setText:(NSString *)text  textColor:(UIColor *)textColor appendingImg:(NSString *)appendingimg  imgIndex:(NSInteger)imgIndex lineSpacing:(CGFloat)lineSpacing{
    if (!text || lineSpacing < 0.01) {
        self.text = text;
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    NSString * TottalText = [NSString stringWithFormat:@"%@",text];
    
    UIImage * myImgName = [UIImage imageNamed:appendingimg];
    NSTextAttachment * attment = [[NSTextAttachment alloc]init];
    attment.image = myImgName;
    CGFloat mid = self.font.descender + self.font.capHeight;
    CGFloat imgY = self.font.descender - attment.image.size.height/2 + mid + 2;
    attment.bounds = CGRectMake(0, imgY, attment.image.size.width, attment.image.size.height);
    
    NSAttributedString * myAttbute  = [NSAttributedString attributedStringWithAttachment:attment];
   
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:TottalText];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [TottalText length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, text.length)];
    [attributedString insertAttributedString:myAttbute atIndex:imgIndex];
    self.userInteractionEnabled = YES;

    self.attributedText = attributedString;
}
- (void)setText:(NSString *)text  textColor:(UIColor *)textColor appendingImg:(NSString *)appendingimg lineSpacing:(CGFloat)lineSpacing{
    if (!text || lineSpacing < 0.01) {
        self.text = text;
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    NSString * TottalText = [NSString stringWithFormat:@"%@  ",text];
    
    UIImage * myImgName = [UIImage imageNamed:appendingimg];
    NSTextAttachment * attment = [[NSTextAttachment alloc]init];
    attment.image = myImgName;
    CGFloat mid = self.font.descender + self.font.capHeight;
    CGFloat imgY = self.font.descender - attment.image.size.height/2 + mid + 2;
    attment.bounds = CGRectMake(0, imgY, attment.image.size.width, attment.image.size.height);
    
    NSAttributedString * myAttbute  = [NSAttributedString attributedStringWithAttachment:attment];
   
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:TottalText];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [TottalText length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, text.length)];
    [attributedString insertAttributedString:myAttbute atIndex:TottalText.length];
    self.userInteractionEnabled = YES;

    self.attributedText = attributedString;
}
-(CGSize)getSpaceLabelSize:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width lineSpacing:(CGFloat)lineSpacing{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpacing;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
};
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}
-(NSInteger)rowsOfString:(NSString *)text withFont:(UIFont *)font withWidth:(CGFloat)width
{
if (!text || text.length == 0) {
    return 0;
}
CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
[attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
CFRelease(myFont);
CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
CGMutablePathRef path = CGPathCreateMutable();
CGPathAddRect(path, NULL, CGRectMake(0,0,width,MAXFLOAT));
CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
return lines.count;
}
@end

