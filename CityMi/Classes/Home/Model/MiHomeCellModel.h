//
//  MiHomeCellModel.h
//  CityMi
//
//  Created by Billie Ji on 2021/2/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MiHomeCellModel : NSObject

/** cellTitle */
@property (nonatomic, copy) NSString *section_title;
/** 图片地址 */
@property (nonatomic, copy) NSString *imageURL;
/** 浏览次数 */
@property (nonatomic, copy) NSString *fav_count;
/** 底部名称 */
@property (nonatomic, copy) NSString *poi_name;

+ (instancetype)cellModelWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
