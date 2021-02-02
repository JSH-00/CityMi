//
//  MiRecommendCell.m
//  CityMi
//
//  Created by Billie Ji on 2021/2/1.
//

#import "MiRecommendCell.h"

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
        _nameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel setText:@"nameLable"];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(30);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-20);
        }];
    }
    return self;
}
@end
