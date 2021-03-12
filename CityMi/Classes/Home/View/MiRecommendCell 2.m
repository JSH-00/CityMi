//
//  MiRecommendCell.m
//  CityMi
//
//  Created by Billie Ji on 2021/2/1.
//

#import "MiRecommendCell.h"
#import <UIImageView+WebCache.h>
@interface MiRecommendCell()
@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *adressLabel;
@property (strong, nonatomic) UILabel *praiseLabel;
@property (strong, nonatomic) UIImageView *adressImageView;
@property (strong, nonatomic) UIImageView *praiseImageView;

@end

@implementation MiRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    _backImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_backImageView];
    [_backImageView setContentMode:UIViewContentModeScaleAspectFill];
    _backImageView.clipsToBounds = YES; //是否裁剪其帧超出接收器可见范围的子视图
    [_backImageView setBackgroundColor:[UIColor redColor]];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
//        self.backgroundView = _backImageView;

    _nameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel setText:@"nameLable"];
    [_nameLabel setTextColor:[UIColor whiteColor]];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-47.5);
    }];

    _adressLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_adressLabel];
    [_adressLabel setText:@"adressLabel"];
    [_adressLabel setTextColor:[UIColor whiteColor]];
    [_adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(40);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-18.5);
    }];

    _praiseLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_praiseLabel];
    [_praiseLabel setText:@"praiseLabel"];
    [_praiseLabel setTextColor:[UIColor whiteColor]];
    [_praiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-18);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-19);
    }];
}

- (void)setCellInfo:(MiHomeCellModel *)model {
    [_nameLabel setText:model.section_title];
    [_adressLabel setText:model.poi_name];
    [_praiseLabel setText:model.fav_count];
    [_backImageView sd_setImageWithURL:[NSURL URLWithString:model.imageURL] placeholderImage:[UIImage imageNamed:@"MiBG"]];
}
@end
