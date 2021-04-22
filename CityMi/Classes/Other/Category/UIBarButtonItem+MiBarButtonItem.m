//
//  UIBarButtonItem+MiBarButtonItem.m
//  CityMi
//
//  Created by Billie Ji on 2021/4/20.
//

#import "UIBarButtonItem+MiBarButtonItem.h"

@implementation UIBarButtonItem (MiBarButtonItem)
+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action {
    UIImage *normalImage = [UIImage imageNamed:image];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
