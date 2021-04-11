//
//  MiMainViewController.m
//  CityMi
//
//  Created by Billie Ji on 2021/3/30.
//

#import "MiMainViewController.h"
#import "MiLeftManuView.h"
#import "HomeViewController.h"
#import "MiNavigationController.h"
@interface MiMainViewController ()<MiLeftMenuViewDelegate>

@end

@implementation MiMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // Do any additional setup after loading the view.
    NSArray *classNames = @[@"HomeViewController"];
    for (NSString *className in classNames) {
        UIViewController *vc = (UIViewController *)[[NSClassFromString(className) alloc]init];
        MiNavigationController *nc = [[MiNavigationController alloc]initWithRootViewController:vc];
        [nc setNavigationBarHidden:YES animated:NO];
//        nc.view.layer.shadowColor = [UIColor blackColor].CGColor;
//        nc.view.layer.shadowOffset = CGSizeMake(-3.5, 0);
//        nc.view.layer.shadowOpacity = 0.2;
        [self addChildViewController:nc];
    }
    
    MiLeftManuView *view = [[MiLeftManuView alloc]initWithFrame:CGRectMake(0, 0, 300, 500)];
    view.delegate = self;
    [self.view insertSubview:view atIndex:0];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(40);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.8);
    }];
    // 通过 delegate 实现跳转到 homepage
}

- (void)leftMenuViewButtonClickFrom:(MiLeftButtonType)fromIndex to:(MiLeftButtonType)toIndex {
    MiNavigationController *newNC = self.childViewControllers[toIndex];
    MiNavigationController *oldNC = self.childViewControllers[fromIndex];
    [oldNC.view removeFromSuperview];
    [self.view addSubview:newNC.view];
}

@end
