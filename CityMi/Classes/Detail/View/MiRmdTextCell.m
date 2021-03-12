//
//  MiRmdTextCell.m
//  CityMi
//
//  Created by JSH on 2021/3/6.
//

#import "MiRmdTextCell.h"
@interface MiRmdTextCell ()
@property (nonatomic, strong) UILabel *rmdTextLabel;
@property (nonatomic, copy) NSString *lableText;
@end
@implementation MiRmdTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView rmdCellModel:(MiRmdCellModel *)rmdCellModel {
    static NSString *identifier = @"rmdTextcell";
    MiRmdTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MiRmdTextCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        [cell setUIWithModel:rmdCellModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = rmdCellModel;
    return cell;
}

- (void)setUIWithModel:(MiRmdCellModel *)model {
    _rmdTextLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_rmdTextLabel];
    [_rmdTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(20);
        make.right.equalTo(self.mas_right).with.offset(-20);
    }];
    _rmdTextLabel.text = model.ch;
    _rmdTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _rmdTextLabel.numberOfLines = 0;
}

- (void)setModel:(MiRmdCellModel *)model {
    _model = model;
    [self layoutIfNeeded]; //刷新 frame，否则 masonry 约束获取的 frame 为 0
    model.cellHeight = CGRectGetMaxY(self.rmdTextLabel.frame) + 10;
}

@end
