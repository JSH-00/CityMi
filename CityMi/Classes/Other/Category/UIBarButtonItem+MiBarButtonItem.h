//
//  UIBarButtonItem+MiBarButtonItem.h
//  CityMi
//
//  Created by Billie Ji on 2021/4/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (MiBarButtonItem)
/**
 * 根据图片快速创建一个 UIBarButtonItem 并返回
 */
+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
