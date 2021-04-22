//
//  HomeViewController.m
//  CityMi
//
//  Created by Billie Ji on 2021/2/1.
//

#import "HomeViewController.h"
#import "MiRecommendCell.h"
#import "MiHomeHeadView.h"
#import "MiHomeCellModel.h"
#import "MiHomeRcmdModel.h"
#import "MiDetailViewController.h"
#define recommendCellID @"recommendCell"
@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UISegmentedControl *titleView;
//推荐View
@property (nonatomic, strong) UITableView *rmedView;
@property (nonatomic, strong) NSMutableArray *homeDatas;
@property (nonatomic, strong) NSMutableArray *testDatas;
@property (nonatomic, strong) UIImageView *nearImageView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationController = [[UINavigationController alloc]init];
    //设置导航条
    [self setUpNavigationItem];
    
    //初始化UI
    [self setUpUI];
//    NSMutableArray *a;
//    self.testDatas[2] = {
//        {-1, -2}
//    };
//    
//    if (!self.testDatas || sizeof(a)/sizeof(a[0])) {
//        printf("\nYES\n")
//    }
    
}

- (void)setUpNavigationItem
{
    //设置导航条titleView
    UISegmentedControl *topTitle = [[UISegmentedControl alloc]initWithItems:@[@"推荐", @"附近"]];
    self.titleView = topTitle;
    topTitle.frame = CGRectMake(0, 0, self.view.bounds.size.width * 0.5, 30);
    [topTitle setBackgroundColor:MiGolbalGreen];
    
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
    
    self.navigationItem.titleView = self.titleView;
}

- (void)setUpUI {
    //设置背景色
    [self.view setBackgroundColor:MiColor(51, 52, 53)];
    self.rmedView = [[UITableView alloc] init];
    self.rmedView.delegate = self;
    self.rmedView.dataSource = self;
    [self.view insertSubview:self.rmedView belowSubview:self.titleView];
    [self.rmedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.top.equalTo(self.view.mas_top).with.offset(95);
        make.width.equalTo(@MiAppWidth);
        make.height.equalTo(@(MiAppHeight - 95));
    }];
    
    self.rmedView.backgroundColor = self.view.backgroundColor;
    
    self.nearImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.nearImageView setImage:[UIImage imageNamed:@"MiBG"]];
    [self.nearImageView setContentMode:UIViewContentModeScaleAspectFill];
}

- (NSMutableArray *)homeDatas {
    if (!_homeDatas) {
        _homeDatas = [[NSMutableArray alloc]init];
        NSArray *tmpArr = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"HomeDatas" ofType:@"plist"]];
        for (NSDictionary *dict in tmpArr) {
            MiHomeRcmdModel *homeModel = [[MiHomeRcmdModel alloc]initHomeHeadModelWithDictionary:dict];
            [_homeDatas addObject:homeModel];
        }
    }
    return _homeDatas;
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
    MiHomeRcmdModel *model = self.homeDatas[section];
    return model.body.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.homeDatas.count;
}

// 加载cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MiRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCellID];
    if (!cell) {
        cell = [[MiRecommendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:recommendCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MiHomeRcmdModel *homeModel = _homeDatas[indexPath.section];
    MiHomeCellModel *model = [MiHomeCellModel cellModelWithDict:(NSDictionary *)(homeModel.body[indexPath.row])];
    [cell setCellInfo:model];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MiHomeCellHeight;
}

// cell点击跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MiDetailViewController *detailVC = [[MiDetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MiHomeRcmdModel *homeModel = self.homeDatas[section];
    MiHomeHeadView *headView = [[MiHomeHeadView alloc]initWithHomeRcmdMode:homeModel];;
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return MiHeadViewHeight;
}

// 隐藏导航栏

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    // 添加绿色背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"recomend_btn_gone"] forBarMetrics:UIBarMetricsDefault];
    [super viewWillAppear:animated];
}
@end
