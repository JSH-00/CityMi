//
//  MiLeftManuView.m
//  CityMi
//
//  Created by Billie Ji on 2021/3/30.
//

#import "MiLeftManuView.h"
#import "MiMenuButton.h"
@interface MiLeftManuView ()
/** 首页 */
@property (nonatomic, strong) MiMenuButton *homeBtn;

/** 当前 Button */
@property (nonatomic, weak) UIButton *selectedBtn;
@end
@implementation MiLeftManuView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setViewUI];
    }
    return self;
}

- (void)setViewUI {
    self.backgroundColor = [UIColor colorWithRed:41.0/255 green:42.0/255 blue:43.0/255 alpha:1];
    self.homeBtn = [MiMenuButton buttonWithType:UIButtonTypeCustom];
    self.homeBtn.frame = CGRectMake(0, 100, CGRectGetWidth(self.frame), 50);
    [self.homeBtn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [self.homeBtn setImage:[UIImage imageNamed:@"homeSeletced"] forState:UIControlStateHighlighted];
    [self.homeBtn addTarget:self action:@selector(sender:) forControlEvents:UIControlEventTouchUpInside];
    self.homeBtn.tag = MiLeftButtonTypeHome;
    [self addSubview:self.homeBtn];
}

- (void)setDelegate:(id<MiLeftMenuViewDelegate>)delegate {
    _delegate = delegate;
    [self sender:self.homeBtn];
}

- (void)sender:(MiMenuButton *)sender {
    if ([self.delegate respondsToSelector:@selector(leftMenuViewButtonClickFrom:to:)]) {
        [self.delegate leftMenuViewButtonClickFrom:self.selectedBtn.tag to:sender.tag];
    }
    
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
}
@end
