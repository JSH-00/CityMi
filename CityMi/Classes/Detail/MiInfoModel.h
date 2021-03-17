//
//  MiInfoModel.h
//  CityMi
//
//  Created by JSH on 2021/3/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MiInfoModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, assign) BOOL *isShowImage;
@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)infoModelWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
