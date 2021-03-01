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
@interface MiDetailViewController () <MiSelectViewDelegate, UITableViewDelegate, UITableViewDataSource>
/** 记录scrollView上次偏移X的距离，没有初始化 */
@property (nonatomic, assign) CGFloat                    scrollX;
/** 最底部的scrollView，用来掌控所有控件的上下滚动 */
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
/** 用来装顶部的scrollView用的View */
@property (nonatomic, strong) UIView *topView;
/** 顶部图片的scrollView，展示图片 */
@property (nonatomic, strong) MiScrollHeadView *topScrollView;
/** 选择tableView的view */
@property (nonatomic, strong) MiSelectView *selectView;
/** 记录当前展示的tableView 计算顶部topView滑动的距离 */
@property (nonatomic, strong) UITableView *showingTableView;
/** 推荐tableView */
@property (nonatomic, strong) UITableView *rmdTableView;
/** 信息tableView */
@property (nonatomic, strong) UITableView *infoTableView;

@end

@implementation MiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setUI];
}
- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];

    // 初始化最底部 scrollView,用来装切换的tableView
    self.backgroundScrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.backgroundScrollView];
    self.backgroundScrollView.backgroundColor = [UIColor whiteColor];
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = NO;
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backgroundScrollView.delegate = self;
    self.backgroundScrollView.contentSize = CGSizeMake(MiAppWidth * 2, 0);


    // 切换的推荐view
    self.rmdTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.rmdTableView.delegate = self;
    self.rmdTableView.dataSource = self;
    self.rmdTableView.backgroundColor = [UIColor whiteColor];
    [self.backgroundScrollView addSubview:self.rmdTableView];
    self.rmdTableView.contentInset = UIEdgeInsetsMake(ScrollHeadViewHeight + SelectViewHeight, 0, 0, 0);

    // 切换的信息view
    self.infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(MiAppWidth, 0, MiAppWidth, MiAppHeight) style:UITableViewStylePlain];
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.backgroundColor = [UIColor whiteColor];
    [self.backgroundScrollView addSubview:self.infoTableView];
    self.infoTableView.contentInset = UIEdgeInsetsMake(ScrollHeadViewHeight + SelectViewHeight, 0, 0, 0);

    NSArray *imagrArr = @[@"https://ghproxy.com/https://raw.githubusercontent.com/lingyia/APIIMG/master/scenery/717.jpg", @"https://ghproxy.com/https://raw.githubusercontent.com/lingyia/APIIMG/master/scenery/718.jpg", @"https://ghproxy.com/https://raw.githubusercontent.com/lingyia/APIIMG/master/scenery/719.jpg"];
    self.topScrollView = [MiScrollHeadView scrollHeadViewWithImages:imagrArr];
    self.topScrollView.backgroundColor = [UIColor whiteColor];
    [self.topScrollView setFrame:CGRectMake(0, 90, MiAppWidth, ScrollHeadViewHeight)];
    [self.view addSubview:self.topScrollView]; // 后续应加在topview上

    // 切换推荐/信息的 view
    self.selectView = [[MiSelectView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topScrollView.frame), MiAppWidth, SelectViewHeight)];
    self.selectView.delegate = self;
    [self.view addSubview:self.selectView];
}

#pragma mark - tableViewDataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.rmdTableView) {
        return 1;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
}

#pragma mark - MiSelectViewDelegate选择条的代理方法
- (void)selectView:(MiSelectView *)selectView didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to {
    switch (to) {
        case 0:
            self.showingTableView = self.rmdTableView;
            break;
        case 1:
            self.showingTableView = self.infoTableView;
            break;
        default:
            break;
    }

    CGFloat offsetX = to * MiAppWidth;
    CGPoint scrPoint = self.backgroundScrollView.contentOffset;
    scrPoint.x = offsetX;
    [UIView animateWithDuration:0.3 animations:^{
            [self.backgroundScrollView setContentOffset:scrPoint];
    }];
}

// 滑动view时的delegate
- (void)selectView:(MiSelectView *)selectView didChangeSelectedView:(NSInteger)to {
    if (to == 0) {
        self.showingTableView = self.rmdTableView;
    } else if (to == 1) {
        self.showingTableView = self.infoTableView;
    }
}

// 滑动view时，计算方法较为复杂 (UIScrollViewDelegate)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.rmdTableView || scrollView == self.infoTableView) {
        // 说明是tableView在竖着滚动
        // 添加代码，向上滑动后，banner会跟着上移，并慢慢显示出nav
    } else { // 说明是backgroundScrollView在横向滚动
        // TODO：滑动到下面后，应该禁止横行滑动
        // TODO：让新出来的tableView的contentOffset正好卡在selectView的头上？？？

        CGFloat offsetX = self.backgroundScrollView.contentOffset.x;
        NSInteger index = offsetX / MiAppWidth;

        CGFloat seleOffsetX = offsetX - self.scrollX; // 计算偏移量，判断是在向左滑（>0）还是向右滑（<0）
        self.scrollX = offsetX;

        //根据scrollViewX偏移量算出顶部selectViewline的位置，滑动幅度大于0.5时，调用lineToIndex
        if (seleOffsetX > 0 && offsetX / MiAppWidth >= (0.5 + index)) {
            [self.selectView lineToIndex:index + 1];
        } else if (seleOffsetX < 0 && offsetX / MiAppWidth <= (0.5 + index)) {
            [self.selectView lineToIndex:index];
        }
    }
}

@end
