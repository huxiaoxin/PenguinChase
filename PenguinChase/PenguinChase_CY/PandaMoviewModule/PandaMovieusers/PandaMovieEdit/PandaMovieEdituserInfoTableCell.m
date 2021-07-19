
#import "PandaMovieEdituserInfoTableCell.h"
#import "GNHBaseTextField.h"

@implementation PandaMovieEditUserInformCellItem

@end

@interface PandaMovieEdituserInfoTableCell () <UITextFieldDelegate>

@property (nonatomic, strong) GNHBaseTextField *textField;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation PandaMovieEdituserInfoTableCell

#pragma mark - LifeCycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)setupSubviews
{
    [super setupSubviews];
    
    GNHBaseTextField *textField = [GNHBaseTextField ly_TextFieldWithPlaceholder:@"请输入昵称" font:zy_fontSize14];
    [self.contentView addSubview:textField];
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeyDone;
    textField.enablesReturnKeyAutomatically = YES;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.textColor = gnh_color_p;
    textField.backgroundColor = gnh_color_d;
    textField.textRectLeftGap = 9.5f;
    textField.editingRectLeftGap = 9.5f;
    textField.layer.cornerRadius = 10.0f;
    textField.layer.masksToBounds = YES;
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:@"请输入昵称" attributes:@{NSFontAttributeName:zy_fontSize14,NSForegroundColorAttributeName:gnh_color_bb}];
    [textField setAttributedPlaceholder:attr];
    textField.clipsToBounds = YES;
    [textField addTarget:self action:@selector(textFieldContentChanged:) forControlEvents:UIControlEventEditingChanged];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16.0f);
        make.left.right.equalTo(self.contentView).inset(15.0f);
        make.height.mas_equalTo(35.5f);
    }];
    self.textField = textField;
    
    UILabel *tipLabel = [UILabel ly_LabelWithTitle:@"以英文字母或汉字开头" font:zy_fontSize10 titleColor:gnh_color_bb];
    [self.contentView addSubview:tipLabel];
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.backgroundColor = UIColor.clearColor;
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textField.mas_bottom).offset(10.0f);
        make.left.equalTo(self.contentView).offset(20.0f);
        make.height.mas_equalTo(14);
    }];
    
    UILabel *countLabel = [UILabel ly_LabelWithTitle:@"0/16" font:zy_fontSize10 titleColor:gnh_color_bb];
    [self.contentView addSubview:countLabel];
    countLabel.textAlignment = NSTextAlignmentRight;
    countLabel.backgroundColor = UIColor.clearColor;
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20.0f);
        make.centerY.equalTo(tipLabel);
        make.height.mas_equalTo(14);
    }];
    self.countLabel = countLabel;
}

- (void)textFieldContentChanged:(UITextField *)textfield
{
    self.countLabel.text = [NSString stringWithFormat:@"%@/16", @(textfield.text.length)];
}

- (NSString *)text
{
    return self.textField.text;
}

- (void)setItem:(id<GNHBaseActionItemProtocol>)item
{
    self.topLine.hidden = YES;
    self.bottomLine.hidden = YES;
    if ([item isKindOfClass:[PandaMovieEditUserInformCellItem class]]) {
        PandaMovieEditUserInformCellItem *cellItem = (PandaMovieEditUserInformCellItem *)item;
        self.textField.text = cellItem.nickName;
        self.countLabel.text = [NSString stringWithFormat:@"%@/16", @(cellItem.nickName.length)];
    }
}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length > 16) {
        [SVProgressHUD showInfoWithStatus:@"您输入的关昵称过长，请重新输入"];
        return NO;
    } else if (textField.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入昵称"];
        return NO;
    } else {
        [self.textField resignFirstResponder];
        
        return YES;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

#pragma mark - Override System Method

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{}

+ (CGFloat)heightForItem:(id<GNHBaseActionItemProtocol>)item
{
    return 35.5f + 32 + 20;
}

@end
