//
//  MiViewController.h
//  CityMi
//
//  Created by Billie Ji on 2021/4/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^coverDidRomove)(void);

@interface MiViewController : UIViewController
/** 遮盖按钮 */
@property (nonatomic, strong) UIButton * __nullable coverBtn;

@property (nonatomic, strong) coverDidRomove coverDidRemove;

@property (nonatomic, assign) BOOL isScale;
@end

NS_ASSUME_NONNULL_END
