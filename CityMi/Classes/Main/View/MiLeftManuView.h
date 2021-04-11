//
//  MiLeftManuView.h
//  CityMi
//
//  Created by Billie Ji on 2021/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, MiLeftButtonType) {
    MiLeftButtonTypeHome = 0
    
};

@protocol MiLeftMenuViewDelegate <NSObject>
- (void)leftMenuViewButtonClickFrom:(MiLeftButtonType)fromIndex to:(MiLeftButtonType)toIndex;
@end
@interface MiLeftManuView : UIView
@property (nonatomic, weak)id <MiLeftMenuViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
