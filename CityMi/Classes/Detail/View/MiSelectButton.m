//
//  MiSelectButton.m
//  CityMi
//
//  Created by Billie Ji on 2021/2/18.
//

#import "MiSelectButton.h"

@implementation MiSelectButton
- (void)initBtn:(MiSelectButton *)btn title:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag {
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = tag;
}

// 点击or抬起按钮时，都会触发layoutSubviews，所以把布局放在addSubview中，而不是layoutSubviews
-(void)addSubview:(UIView *)view {
    [super addSubview:view];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setTitleColor:MiColor(26, 163, 146) forState:UIControlStateNormal];

    CGFloat padding = 0; // 设置图片与文字的距离
    CGFloat zoom = 8; // 设置图片缩放大小
    self.titleEdgeInsets = UIEdgeInsetsMake(0, padding/2, 0, -padding/2);
    self.imageEdgeInsets = UIEdgeInsetsMake(zoom, -padding/2 - 16, zoom, padding/2);
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    self.adjustsImageWhenHighlighted = NO; // 点击后button图片不变灰
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
