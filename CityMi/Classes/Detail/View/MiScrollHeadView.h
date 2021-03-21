//
//  MiScrollHeadView.h
//  CityMi
//
//  Created by Billie Ji on 2021/2/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MiScrollHeadView : UIScrollView
@property (nonatomic, strong) UIView *naviView;
+ (instancetype)scrollHeadViewWithImages:(NSArray *)images;
@end

NS_ASSUME_NONNULL_END
