//
//  MiDetailRnmdTableHeadView.m
//  CityMi
//
//  Created by Billie Ji on 2021/3/2.
//

#import "MiDetailRnmdTableHeadView.h"
@interface MiDetailRnmdTableHeadView ()
@property (nonatomic, strong) UIImageView *authorIconImageView;
@property (nonatomic, strong) UILabel *authorNameLabel;
@property (nonatomic, strong) UILabel *browseCountLable;
@property (nonatomic, strong) UILabel * titleLable;
@end
@implementation MiDetailRnmdTableHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.authorIconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 10, 40, 40)];
    [self.authorIconImageView setImage:[UIImage imageNamed:@"myicon.png"]];
    [self.authorIconImageView setContentMode:UIViewContentModeScaleAspectFill];
    self.authorIconImageView.layer.masksToBounds = YES;
    self.authorIconImageView.layer.cornerRadius = self.authorIconImageView.bounds.size.height * 0.5;
    [self addSubview:self.authorIconImageView];
    
    // 添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick)];
    [self addGestureRecognizer:tap];
    
    UIImageView *roleLogo = [[UIImageView alloc]initWithFrame:CGRectMake(300, 20, 30, 20)];
    [roleLogo setImage:[UIImage imageNamed:@"RoleLogo.png"]];
    [roleLogo setContentMode:UIViewContentModeScaleAspectFill];
    [self addSubview:roleLogo];
    
    self.authorNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 15, 130, 30)];
    [self.authorNameLabel setText:@"Hello EiYeMaYa"];
    [self.authorNameLabel setTextColor:MiGolbalGreen];
    [self addSubview:self.authorNameLabel];
}
- (void)viewClick {
    NSLog(@"push to UserInfoDetailViewController");
}

@end
