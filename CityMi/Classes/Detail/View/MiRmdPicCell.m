//
//  MiRmdPicCell.m
//  CityMi
//
//  Created by JSH on 2021/3/9.
//

#import "MiRmdPicCell.h"
#import <UIImageView+WebCache.h>
@interface MiRmdPicCell ()
@property (nonatomic, strong) UIImageView *picImageView;
@end
@implementation MiRmdPicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView rmdCellModel:(MiRmdCellModel *)rmdCellModel {
    MiRmdPicCell *cell = [tableView dequeueReusableCellWithIdentifier:RmdPicCellIdentifier];
    if (!cell) {
        cell = [[MiRmdPicCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:RmdPicCellIdentifier];
        [cell setUIWithModel:rmdCellModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:rmdCellModel.pic] placeholderImage:[UIImage imageNamed:@"MiBG"]];
    return cell;
}

- (void)setUIWithModel:(MiRmdCellModel *)model {
    _picImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_picImageView];
    [_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(20);
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
    }];
    [_picImageView setContentMode:UIViewContentModeScaleAspectFill];
    _picImageView.clipsToBounds = YES;
}

@end
