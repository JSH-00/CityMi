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
/** 发现 */
@property (nonatomic, strong) MiMenuButton *foundBtn;
/** 消息 */
@property (nonatomic, strong) MiMenuButton *messageBtn;
/** 设置 */
@property (nonatomic, strong) MiMenuButton *settingBtn;

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
    [self addSubview:self.homeBtn];
    [self.homeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(100);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@50);
    }];
    self.homeBtn.tag = MiLeftButtonTypeHome;
    [self.homeBtn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [self.homeBtn setImage:[UIImage imageNamed:@"homeSelected"] forState:UIControlStateHighlighted];
    [self.homeBtn setImage:[UIImage imageNamed:@"homeSelected"] forState:UIControlStateSelected];
    [self.homeBtn setAdjustsImageWhenHighlighted:NO];
    [self.homeBtn addTarget:self action:@selector(sender:) forControlEvents:UIControlEventTouchUpInside];
    
    self.foundBtn = [MiMenuButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.foundBtn];
    [self.foundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.homeBtn.mas_top).with.offset(80);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
    }];
    self.foundBtn.tag = MiLeftButtonTypeFound;
    [self.foundBtn setImage:[UIImage imageNamed:@"found"] forState:UIControlStateNormal];
    [self.foundBtn setImage:[UIImage imageNamed:@"foundSelected"] forState:UIControlStateHighlighted];
    [self.foundBtn setImage:[UIImage imageNamed:@"foundSelected"] forState:UIControlStateSelected];
    [self.foundBtn setAdjustsImageWhenHighlighted:NO];
    [self.foundBtn addTarget:self action:@selector(sender:) forControlEvents:UIControlEventTouchUpInside];
    
    self.messageBtn = [MiMenuButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.messageBtn];
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.foundBtn.mas_top).with.offset(180);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
    }];
    self.messageBtn.tag = MiLeftButtonTypeMessage;
    [self.messageBtn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [self.messageBtn setImage:[UIImage imageNamed:@"messageSelected"] forState:UIControlStateHighlighted];
    [self.messageBtn setImage:[UIImage imageNamed:@"messageSelected"] forState:UIControlStateSelected];
    [self.messageBtn setAdjustsImageWhenHighlighted:NO];
    [self.messageBtn addTarget:self action:@selector(sender:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.settingBtn = [MiMenuButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.settingBtn];
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageBtn.mas_top).with.offset(80);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
    }];
    self.settingBtn.tag = MiLeftButtonTypeSetting;
    [self.settingBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [self.settingBtn setImage:[UIImage imageNamed:@"settingSelected"] forState:UIControlStateHighlighted];
    [self.settingBtn setImage:[UIImage imageNamed:@"settingSelected"] forState:UIControlStateSelected];
    [self.settingBtn setAdjustsImageWhenHighlighted:NO];
    [self.settingBtn addTarget:self action:@selector(sender:) forControlEvents:UIControlEventTouchUpInside];
    
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
