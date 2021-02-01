//
//  HomeViewController.m
//  CityMi
//
//  Created by Billie Ji on 2021/2/1.
//

#import "HomeViewController.h"
#import "MiRecommendCell.h"
@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UISegmentedControl *titleView;
//推荐View
@property (nonatomic, strong) UITableView *rmedView;
@property (nonatomic, strong) UIImageView *nearImageView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //设置导航条
    [self setUpNavigationItem];
    
    //初始化UI
    [self setUpUI];
}

- (void)setUpNavigationItem
{
    //设置导航条titleView
    UISegmentedControl *topTitle = [[UISegmentedControl alloc]initWithItems:@[@"推荐", @"附近"]];
    self.titleView = topTitle;
    topTitle.frame = CGRectMake(self.view.bounds.size.width * 0.25, self.view.safeAreaInsets.top +44, self.view.bounds.size.width * 0.5, 30);
    [topTitle setBackgroundColor:MiGolbalGreen];
    [self.view addSubview:topTitle];
    
    // 设置文字选中样式
    NSMutableDictionary *attDicSelected = [NSMutableDictionary dictionary];
    attDicSelected[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    attDicSelected[NSForegroundColorAttributeName] = MiColor(26, 163, 146);
    [topTitle setTitleTextAttributes:attDicSelected forState:UIControlStateSelected];
    
    // 设置文字未选中样式
    NSMutableDictionary *attDicNormal = [NSMutableDictionary dictionary];
    attDicNormal[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    attDicNormal[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [topTitle setTitleTextAttributes:attDicNormal forState:UIControlStateNormal];
    
     // 事件
     topTitle.selectedSegmentIndex = 0; // 默认光标所在位置
     [topTitle addTarget:self action:@selector(titleViewChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)setUpUI {
    //设置背景色
    [self.view setBackgroundColor:MiColor(51, 52, 53)];
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MiAppWidth, MiAppHeight - 64) style:UITableViewStylePlain];
    self.rmedView = tableV;
    self.rmedView.delegate = self;
    self.rmedView.dataSource = self;
    [self.view insertSubview:self.rmedView belowSubview:self.titleView];
    self.rmedView.backgroundColor = self.view.backgroundColor;
    
    self.nearImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.nearImageView setImage:[UIImage imageNamed:@"wnxBG"]];
    [self.nearImageView setContentMode:UIViewContentModeScaleAspectFill];
}

#pragma mark - titleViewAction
- (void)titleViewChange:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        //显示推荐View
        [self.view insertSubview:self.rmedView belowSubview:self.titleView];
        [self.nearImageView removeFromSuperview];
    } else {
        //显示nearView
        [self.view insertSubview:self.nearImageView belowSubview:self.titleView];
        [self.rmedView removeFromSuperview];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MiRecommendCell *cell = [MiRecommendCell new];
    return cell;
    
}

@end
