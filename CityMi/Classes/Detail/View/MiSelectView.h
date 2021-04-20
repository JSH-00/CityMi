//
//  MiSelectView.h
//  CityMi
//
//  Created by Billie Ji on 2021/2/18.
//

#import <UIKit/UIKit.h>
@class MiSelectView;
NS_ASSUME_NONNULL_BEGIN
@protocol MiSelectViewDelegate <NSObject>
@optional
- (void)selectView:(MiSelectView *)selectView didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;
- (void)selectView:(MiSelectView *)selectView didChangeSelectedView:(NSInteger)to;
@end
@interface MiSelectView : UIView
@property(nonatomic, weak) id <MiSelectViewDelegate> delegate;
//提供给外部一个可以滑动底部line的方法
- (void)lineToIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
