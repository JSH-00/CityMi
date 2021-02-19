//
//  MiDetailViewController.m
//  CityMi
//
//  Created by Billie Ji on 2021/2/9.
//
/* 由于 MiDetailViewController 页面可重用，所以单独放在 Detail 文件夹下。
 */
// 顶部scrollHeadView 的高度
static const CGFloat ScrollHeadViewHeight = 200;
//选择View的高度
static const CGFloat SelectViewHeight = 45;
#import "MiDetailViewController.h"
#import "MiScrollHeadView.h"
#import "MiSelectView.h"
@interface MiDetailViewController ()
/** 最底部的scrollView，用来掌控所有控件的上下滚动 */
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
/** 顶部图片的scrollView，展示图片 */
@property (nonatomic, strong) MiScrollHeadView *topScrollView;
/** 选择tableView的view */
@property (nonatomic, strong) MiSelectView *selectView;

@end

@implementation MiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setUI];
}
- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *imagrArr = @[@"https://ghproxy.com/https://raw.githubusercontent.com/lingyia/APIIMG/master/scenery/717.jpg", @"https://ghproxy.com/https://raw.githubusercontent.com/lingyia/APIIMG/master/scenery/718.jpg", @"https://ghproxy.com/https://raw.githubusercontent.com/lingyia/APIIMG/master/scenery/719.jpg"];
    self.topScrollView = [MiScrollHeadView scrollHeadViewWithImages:imagrArr];
    self.topScrollView.backgroundColor = [UIColor whiteColor];
    [self.topScrollView setFrame:CGRectMake(0, 90, MiAppWidth, ScrollHeadViewHeight)];
    [self.view addSubview:self.topScrollView];

    self.selectView = [[MiSelectView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topScrollView.frame), MiAppWidth, SelectViewHeight)];
    [self.view addSubview:self.selectView];
}
@end
