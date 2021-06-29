//
//  PenguinChaseBaseTableViewCell.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/6/28.
//

#import "PenguinChaseBaseTableViewCell.h"

@implementation PenguinChaseBaseTableViewCell
+(id)PenguinChasecreateCellWithTheTableView:(UITableView *)tableView AndTheIndexPath:(NSIndexPath *)indexPath{
    NSString  *identifier = NSStringFromClass([self classForCoder]);
    [tableView registerClass:[self classForCoder] forCellReuseIdentifier:identifier];
    PenguinChaseBaseTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return  cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =  UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self PenguinChaseAddSubViews];
    }
    return  self;
}
-(void)PenguinChaseAddSubViews{
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
