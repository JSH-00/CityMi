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

#import "MiDetailViewController.h"
#import "MiScrollHeadView.h"
@interface MiDetailViewController ()
/** 最底部的scrollView，用来掌控所有控件的上下滚动 */
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
/** 顶部图片的scrollView，展示图片 */
@property (nonatomic, strong) MiScrollHeadView *topScrollView;
@end

@implementation MiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setUI];
}
- (void)setUI {
    self.view.backgroundColor = [UIColor redColor];
    NSArray *imagrArr = @[@"http://img.chengmi.com/cm/3bc2198c-c909-4698-91b2-88e00c5dff2a",
                                                                     @"http://img.chengmi.com/cm/dba3fb4d-b5ef-4218-b976-52cba4538381",
                                                                     @"http://img.chengmi.com/cm/934ad87f-400c-452e-9427-12a03fe9cf6e"];
    self.topScrollView = [MiScrollHeadView scrollHeadViewWithImages:imagrArr];
    self.topScrollView.backgroundColor = [UIColor whiteColor];
    [self.topScrollView setFrame:CGRectMake(0, 90, MiAppWidth, ScrollHeadViewHeight)];
    [self.view addSubview:self.topScrollView];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
