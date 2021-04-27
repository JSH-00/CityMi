//
//  MiViewController.m
//  CityMi
//
//  Created by Billie Ji on 2021/4/20.
//

#import "MiViewController.h"
#import "UIBarButtonItem+MiBarButtonItem.h"

#define MiScaleAnimateWithDuration 0.3
@interface MiViewController ()

@end

@implementation MiViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"artcleList_btn_info" target:self action:@selector(leftClick)];
}

- (void)leftClick {
    // 给整个 MiViewController 添加遮盖按钮，拦截用户操作，点击后隐藏左侧抽屉
    self.coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.coverBtn.frame = self.navigationController.view.bounds; // 覆盖包括 navigationController 的部分
    [self.coverBtn addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:self.coverBtn];
    
    // 缩放比例
    CGFloat zoomScale = (MiAppHeight - MiScaleTopMargin * 2) / MiAppHeight;
    
    // x 移动距离
    CGFloat moveX = MiAppWidth - MiAppWidth * MiZoomScaleRight;
    [UIView animateWithDuration:MiScaleAnimateWithDuration animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(zoomScale, zoomScale);
        self.navigationController.view.transform = CGAffineTransformTranslate(transform, moveX, 0); // 连同 nav 一起变形
        self.isScale = YES;
    }];
}

- (void)coverClick {

    [UIView animateWithDuration:MiScaleAnimateWithDuration animations:^{
        self.navigationController.view.transform = CGAffineTransformIdentity; // 还原到最初形变前的状态
    } completion:^(BOOL finished) {
        [self.coverBtn removeFromSuperview];
        self.coverBtn = nil;
        self.isScale = NO;
        //当遮盖按钮被销毁时调用
        if (self.coverDidRemove) {
            self.coverDidRemove();
        }
    }];
}
@end
