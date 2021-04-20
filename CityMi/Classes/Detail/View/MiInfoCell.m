//
//  MiInfoCell.m
//  CityMi
//
//  Created by JSH on 2021/3/14.
//

#import "MiInfoCell.h"
#define InfoCellIdentifier @"infoCell"
@interface MiInfoCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@end
@implementation MiInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView infoCellModel:(MiInfoModel *)infoCellModel {
    MiInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:InfoCellIdentifier];
    if (!cell) {
        cell = [[MiInfoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:InfoCellIdentifier];
        [cell setUIWithModel:infoCellModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = infoCellModel;
    return cell;
}

- (void)setUIWithModel:(MiInfoModel *)model {
    _titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).with.offset(20);
    }];
    _titleLabel.text = model.title;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.numberOfLines = 0;
    
    if (model.subTitle) {
        _subTitleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_subTitleLabel];
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(20);
            make.left.equalTo(self.mas_left).with.offset(20);
            make.right.equalTo(self.mas_right).with.offset(-20);
        }];
        _subTitleLabel.text = model.subTitle;
        _subTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _subTitleLabel.numberOfLines = 0;
    }
}

- (void)setModel:(MiInfoModel *)model {
    _model = model;
    [self layoutIfNeeded]; //刷新 frame，否则 masonry 约束获取的 frame 为 0
    
    CGFloat titleLabelHeight = CGRectGetHeight(self.titleLabel.frame);
    CGFloat subTitleLabelHeight = CGRectGetHeight(self.subTitleLabel.frame);

    if (titleLabelHeight && subTitleLabelHeight) {
        model.cellHeight = CGRectGetHeight(self.titleLabel.frame) + CGRectGetHeight(self.subTitleLabel.frame) + 60;
    } else if (titleLabelHeight || subTitleLabelHeight) {
        model.cellHeight = CGRectGetHeight(self.titleLabel.frame) + CGRectGetHeight(self.subTitleLabel.frame) + 40;
    } else {
        model.cellHeight = 0;
    }
}
@end
