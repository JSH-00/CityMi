//
//  MiDetailViewController.m
//  CityMi
//
//  Created by Billie Ji on 2021/2/9.
//
/* 由于 MiDetailViewController 页面可重用，所以单独放在 Detail 文件夹下。
 */
// 顶部scrollHeadView 的高度
#define ScrollHeadViewHeight 250
//选择View的高度
#define SelectViewHeight 45
#import "MiDetailViewController.h"
#import "MiScrollHeadView.h"
#import "MiSelectView.h"
#import "MiDetailRnmdTableHeadView.h"
#import "MiDetailModel.h"
#import "MiRmdCellModel.h"
#import "MiRmdTextCell.h"
#import "MiRmdPicCell.h"
#import "MiInfoModel.h"
#import "MiInfoCell.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
typedef NS_ENUM(NSInteger, RowType) {
    MapRow = 0,
    InfoFirstRow,
    InfoSecondRow,
    TeleRow
};
@interface MiDetailViewController () <MiSelectViewDelegate, UITableViewDelegate, UITableViewDataSource, MAMapViewDelegate>
/** 记录scrollView上次偏移X的距离，没有初始化 */
@property (nonatomic, assign) CGFloat scrollX;
/** 记录scrollView上次偏移Y的距离 */
@property (nonatomic, assign) CGFloat scrollY;
/** 最底部的scrollView，用来掌控所有控件的上下滚动 */
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
/** 导航条的背景view */
@property (nonatomic, strong) UIView *naviView;
/** 返回按钮 */
@property (nonatomic, strong) UIButton *backBtn;
/** 用来装顶部的scrollView用的View */
@property (nonatomic, strong) UIView *topView;
/** 顶部图片的scrollView，展示图片 */
@property (nonatomic, strong) MiScrollHeadView *topScrollView;
/** 选择tableView的view */
@property (nonatomic, strong) MiSelectView *selectView;
/** 推荐tableViewtableHeadView */
@property (nonatomic, strong) MiDetailRnmdTableHeadView * tableHeadView;
/** 记录当前展示的tableView 计算顶部topView滑动的距离 */
@property (nonatomic, strong) UITableView *showingTableView;
/** 推荐tableView */
@property (nonatomic, strong) UITableView *rmdTableView;
/** 信息tableView */
@property (nonatomic, strong) UITableView *infoTableView;
/** 详情页的数据 */
@property (nonatomic, strong) MiDetailModel *details;
/** 推荐页的数据 */
@property (nonatomic, strong) NSMutableArray *rmdDatas;
/** 信息页的数据 */
@property (nonatomic, strong) NSMutableArray *infoDatas;
/** 地图ivew */
@property (nonatomic, strong) MAMapView *mapView;
/** 电话弹窗 */
@property (nonatomic, strong) UIAlertController *actionController;
@end

@implementation MiDetailViewController

// 懒加载数据
- (MiDetailModel *)details {
    if (!_details) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"detailJson" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        _details = [MiDetailModel detailModelWith:dict[@"body"]];
    }
    return _details;
}

- (NSMutableArray *)rmdDatas {
    if (!_rmdDatas) {
        _rmdDatas = [NSMutableArray array];
        if (!self.details.article_list || self.details.article_list.count <= 0) return _rmdDatas;
        NSMutableArray *tmp = [NSMutableArray array];
        tmp = self.details.article_list[0][@"newcontent"];
        for (NSDictionary *dict in tmp) {
            MiRmdCellModel *cellModel = [MiRmdCellModel rmdCellModelWithDict:dict];
            [_rmdDatas addObject:cellModel];
        }
    }
    return _rmdDatas;
}

- (NSMutableArray *)infoDatas {
    if (!_infoDatas) {
        _infoDatas = [NSMutableArray array];
        NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"infoDatas" ofType:@"plist"]];
        for (NSDictionary *dict in arr) {
            MiInfoModel *model = [MiInfoModel infoModelWithDict:dict];
            [_infoDatas addObject:model];
        }
    }
    return _infoDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setUI];
    [self setUpNavigationBar];
}
- (void)setUI {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 当 scrollView 是其父视图上的第一个子视图，且 navigationBar 不隐藏的情况下，加到 scrollView 里的视图，都会默认下移64个像素。
    // 添加如下代码，可以避免下移
    if (@available(iOS 11.0, *)){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
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
    self.rmdTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MiAppWidth, MiAppHeight)];
    self.rmdTableView.delegate = self;
    self.rmdTableView.dataSource = self;
    self.rmdTableView.backgroundColor = [UIColor whiteColor];
    [self.backgroundScrollView addSubview:self.rmdTableView];
    self.rmdTableView.contentInset = UIEdgeInsetsMake(ScrollHeadViewHeight + SelectViewHeight - 48, 0, 0, 0);

    // 切换的信息view
    self.infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(MiAppWidth, 0, MiAppWidth, MiAppHeight) style:UITableViewStylePlain];
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.backgroundColor = [UIColor whiteColor];
    [self.backgroundScrollView addSubview:self.infoTableView];
    self.infoTableView.contentInset = UIEdgeInsetsMake(ScrollHeadViewHeight + SelectViewHeight - 48, 0, 0, 0);

    NSArray *imagrArr = @[@"https://ghproxy.com/https://raw.githubusercontent.com/lingyia/APIIMG/master/scenery/717.jpg", @"https://ghproxy.com/https://raw.githubusercontent.com/lingyia/APIIMG/master/scenery/718.jpg", @"https://ghproxy.com/https://raw.githubusercontent.com/lingyia/APIIMG/master/scenery/719.jpg"];
    self.topScrollView = [MiScrollHeadView scrollHeadViewWithImages:imagrArr];
    self.topScrollView.backgroundColor = [UIColor whiteColor];

    self.topView = [[UIView alloc]init];
    self.topView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.width.equalTo(@MiAppWidth);
        make.height.equalTo(@ScrollHeadViewHeight);
    }];
    
    [self.topView addSubview:self.topScrollView];
    [self.topScrollView setFrame:CGRectMake(0, 0, MiAppWidth, ScrollHeadViewHeight)];
    [self.topScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left);
        make.top.equalTo(self.topView.mas_top);
        make.width.equalTo(@MiAppWidth);
        make.height.equalTo(@ScrollHeadViewHeight);
    }];

    // 切换推荐/信息的 view
    self.selectView = [[MiSelectView alloc]init];
    self.selectView.delegate = self;
    [self.view addSubview:self.selectView];
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top).with.offset(CGRectGetMaxY(self.topScrollView.frame));
        make.width.equalTo(@MiAppWidth);
        make.height.equalTo(@SelectViewHeight);
    }];

    //添加推荐 tableView 的 HeadView
    self.tableHeadView = [[MiDetailRnmdTableHeadView alloc]initWithFrame:CGRectMake(0, 0, MiAppWidth, 60)];
    self.rmdTableView.tableHeaderView = self.tableHeadView;
    
    // 初始化地图
    [AMapServices sharedServices].apiKey = @"b97f852099883851c86b6d57ab6f1d89";
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, MiAppWidth, 220)];
    self.mapView.delegate = self;
    self.mapView.showsScale = NO;
    self.mapView.showsCompass = NO;
    self.mapView.showsUserLocation = YES;
    self.mapView.scrollEnabled = NO;
    self.mapView.zoomLevel = 14;
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(30.1871, 120.1646) animated:YES];
    self.infoTableView.tableHeaderView = self.mapView;

    // 添加自定义图片
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.1871, 120.1646);
    [self.mapView addAnnotation:pointAnnotation];
}

#pragma mark - Map
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (!annotationView) {
            annotationView = [[MAAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"map_activity"];
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.rmdTableView) {
        MiRmdCellModel *rmdCellModel = self.rmdDatas[indexPath.row];
        NSString *ch = rmdCellModel.ch;
        if (ch) {
            return rmdCellModel.cellHeight;
        } else {
            return 348;
        }
    } else {
        MiInfoModel *infoCellModel = self.infoDatas[indexPath.row];
        return infoCellModel.cellHeight;
    }
}

#pragma mark - tableViewDataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.rmdTableView) {
        return self.rmdDatas.count;
    } else {
        return self.infoDatas.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.rmdTableView) {
        MiRmdCellModel *rmdCellModel = self.rmdDatas[indexPath.row];
        NSString *ch = rmdCellModel.ch;
        if (ch) {
            return [MiRmdTextCell cellWithTableView:tableView rmdCellModel:rmdCellModel];
        } else {
            return [MiRmdPicCell cellWithTableView:tableView rmdCellModel:rmdCellModel];
        }
    }
    MiInfoCell *InfoCell = [MiInfoCell cellWithTableView:tableView infoCellModel:self.infoDatas[indexPath.row]];
    return InfoCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.rmdTableView) {
        return;
    } else if (indexPath.row == MapRow) {
        // 跳转到地图页面
    } else if (indexPath.row == TeleRow) {
        MiInfoModel *model = self.infoDatas[indexPath.row];
        // 打电话
        self.actionController = [UIAlertController alertControllerWithTitle:@"选择要播的电话" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * phoneNum1 = [UIAlertAction actionWithTitle:model.title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 添加跳转到电话
        }];

        UIAlertAction * phoneNum2 = [UIAlertAction actionWithTitle:model.subTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 添加跳转到电话
        }];

        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.actionController dismissViewControllerAnimated:YES completion:nil];
        }];

        [self.actionController addAction:phoneNum1];
        [self.actionController addAction:phoneNum2];
        [self.actionController addAction:cancel];
        [self presentViewController:self.actionController animated:YES completion:nil];
    }
}

#pragma mark - 自定义导航条
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)setUpNavigationBar {
    // 初始化自定义导航条
    self.naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MiAppWidth, 90)];
    self.naviView.backgroundColor = MiGolbalGreen;
    self.naviView.alpha = 0.0;
    [self.view addSubview:self.naviView];

    // 添加返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(5, 56, 25, 25);
    [self.backBtn addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:self.backBtn];
}

- (void)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

        // 记录当前展示的是哪个tableView
        self.showingTableView = (UITableView *)scrollView;

        // 记录出上一次滑动的距离
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat seleOffsetY = offsetY - self.scrollY;
        self.scrollY = offsetY;

        //修改顶部的 topView 位置
        CGRect headRect = self.topView.frame;
        headRect.origin.y -= seleOffsetY;
        self.topView.frame = headRect;

        // 据偏移量算出alpha的值,渐隐,当偏移量大于-180开始计算消失的值
        CGFloat startF = -80;
        // 初始的偏移量Y值为，顶部俩个控件的高度
        CGFloat initY = SelectViewHeight + ScrollHeadViewHeight;
        
        //渐现alpha值
        CGFloat alphaScaleShow = (offsetY + startF + 340) / 75 ;
        if (alphaScaleShow >= 0.98) {
            //显示导航条
            [UIView animateWithDuration:0.04 animations:^{
                self.naviView.alpha = 1;
            }];
        } else {
            self.naviView.alpha = 0;
        }
        self.topScrollView.naviView.alpha = alphaScaleShow;

        // 让 selectView 随着 banner 移动
        if (offsetY >= -(90 + SelectViewHeight)) {
            // 悬浮于 naviView 下面
            self.selectView.frame = CGRectMake(0, 90, MiAppWidth, SelectViewHeight);
        } else {
            // 和 topView 一起滑动
            self.selectView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), MiAppWidth, SelectViewHeight);
        }

        // 下拉时，让头部变形
        CGFloat scaleTopView = 1 - (offsetY + SelectViewHeight + ScrollHeadViewHeight) / 100;
        scaleTopView = scaleTopView > 1 ? scaleTopView : 1;
        //算出头部的变形 这里的动画不是很准确，好的动画是一点一点试出来了  这里可能还需要配合锚点来进行动画,关于这种动画我会在以后单开一个项目配合blog来讲解的 这里这就不细调了
        CGAffineTransform transform = CGAffineTransformMakeScale(scaleTopView, scaleTopView);
        CGFloat ty = (scaleTopView - 1) * ScrollHeadViewHeight;
        self.topView.transform = CGAffineTransformTranslate(transform, 0, -ty * 0.2);

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
