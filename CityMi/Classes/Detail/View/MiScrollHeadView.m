//
//  MiScrollHeadView.m
//  CityMi
//
//  Created by Billie Ji on 2021/2/9.
//

#import "MiScrollHeadView.h"
#import "UIImageView+WebCache.h"
@interface MiScrollHeadView () <UIScrollViewDelegate>
@property (nonatomic, strong)NSArray *images;
@property (nonatomic, strong)UIPageControl *pageView;
@end
@implementation MiScrollHeadView
// 通过数组创建 scrollHeadView
+ (instancetype)scrollHeadViewWithImages:(NSArray *)images {
    MiScrollHeadView *headView = [[self alloc]init];
    headView.images = images;
    return headView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.pagingEnabled = YES; // 当滚动时，只在视图的倍数处停止
//        self.showsHorizontalScrollIndicator = NO; // 横向指示器滚筒条
        self.delegate = self;
    }
    return self;
}
// 初始化 PageView
- (void)setPageView {
    self.pageView = [[UIPageControl alloc] init];
    CGFloat x = 0;
    CGFloat y = self.bounds.size.height - 25;
    CGFloat w = self.bounds.size.width;
    CGFloat h = 25;
    self.pageView.frame = CGRectMake(x, y, w, h);
    [self.superview insertSubview:self.pageView aboveSubview:self];
    
    NSInteger count = self.images.count;
    int i = 0;
    for (NSString *urlStr in self.images) {
        //获取网络请求路径
        NSURL *url = [NSURL URLWithString:urlStr];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        UIImageView *loadingImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MiBG"]];
        loadingImage.con
        
        [imageView sd_setImageWithURL:url placeholderImage:];
        CGFloat w = self.bounds.size.width;
        CGFloat h = self.bounds.size.height;
        imageView.frame = CGRectMake(i * w, 0, w, h);
        [self insertSubview:imageView atIndex:i];
        i++;

    }
    if (count <= 1)
        return;
    self.pageView.numberOfPages = count;
    self.contentSize = CGSizeMake((count + 1) * self.bounds.size.width, 0);

}



- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    [self setPageView];

    NSLog(@"===>%s",__func__);
}
- (void)didMoveToSuperview {
    [super didMoveToSuperview];

    NSLog(@"===>%s",__func__);

}
- (void)didMoveToWindow {
    [super didMoveToWindow];
    NSLog(@"===>%s",__func__);

}
@end
