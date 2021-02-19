//
//  MiSelectView.m
//  CityMi
//
//  Created by Billie Ji on 2021/2/18.
//

#import "MiSelectView.h"
#import "MiSelectButton.h"
@interface MiSelectView ()
/**推荐按钮*/
@property (nonatomic, strong) MiSelectButton *groomBtn;
/**信息按钮*/
@property (nonatomic, strong) MiSelectButton *infoBtn;
/**底部滑动动画条*/
@property (nonatomic, strong) UIView *slideLineView;
@end
@implementation MiSelectView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor whiteColor];

    self.groomBtn = [MiSelectButton buttonWithType:UIButtonTypeCustom];
    [self.groomBtn initBtn:self.groomBtn title:@"推荐" image:[UIImage imageNamed:@"groom"] tag:0];
    [self addSubview:self.groomBtn];

    self.infoBtn = [MiSelectButton buttonWithType:UIButtonTypeCustom];
    [self.groomBtn initBtn:self.infoBtn title:@"信息" image:[UIImage imageNamed:@"info"] tag:1];
    [self addSubview:self.infoBtn];

    self.slideLineView = [[UIView alloc]init];
    self.slideLineView.backgroundColor = MiGolbalGreen;
    self.slideLineView.layer.masksToBounds = YES;
    self.slideLineView.layer.cornerRadius = 2;
    [self addSubview:self.slideLineView];

    [self.groomBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    [self.infoBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark - 设置控件的frame
- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat viewH = self.bounds.size.height;
    CGFloat viewW = self.bounds.size.width;
    CGFloat btnW = viewW * 0.3;
    CGFloat btnH = viewH;
    // self.subview.count = MiSelectButton数量 + 底部滑动动画条
    CGFloat margin = (viewW - btnW * (self.subviews.count - 1))/ self.subviews.count;
    self.groomBtn.frame = CGRectMake(margin, 0, btnW, btnH);
    self.infoBtn.frame = CGRectMake(margin * 2 + btnW , 0, btnW, btnH);
    self.slideLineView.frame = CGRectMake(margin, viewH - 4, btnW, 4);
}
#pragma mark - 按钮的Action
- (void)btnClick:(MiSelectButton *)sender {
    CGRect rect = self.slideLineView.frame;
    rect.origin.x = sender.frame.origin.x;
    [UIView animateWithDuration:0.3 animations:^{
        self.slideLineView.frame = rect;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
