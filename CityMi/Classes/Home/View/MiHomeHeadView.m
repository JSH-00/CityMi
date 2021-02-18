//
//  MiHomeHeadView.m
//  CityMi
//
//  Created by Billie Ji on 2021/2/2.
//

#import "MiHomeHeadView.h"
#import "UIColor+MiColor.h"
@interface MiHomeHeadView ()

// 分类名
@property (copy, nonatomic) UILabel *titleLabel;

// 数量
@property (copy, nonatomic) UILabel *subTitleLabel;
@end
@implementation MiHomeHeadView
- (instancetype)initWithHomeRcmdMode:(MiHomeRcmdModel *)headModel {
    if (self = [super init]) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:headModel.color alpha:1];
        _titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel setText:headModel.tag_name];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView.mas_top).with.offset(18);
                    make.right.equalTo(self.contentView.mas_right).with.offset(-30);
        }];

        _subTitleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_subTitleLabel];
        [_subTitleLabel setText:headModel.section_count];
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentView.mas_top).with.offset(18);
                    make.left.equalTo(self.contentView.mas_left).with.offset(10);
        }];
    }
    return self;
}

@end
