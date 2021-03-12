//
//  MiDetailModel.h
//  CityMi
//
//  Created by Billie Ji on 2021/3/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MiDetailModel : NSObject
/** detail列表 */
@property (nonatomic, strong) NSArray *poi_list;

/** 头部信息 */
@property (nonatomic, strong) NSDictionary *section_info;

/** 推荐tableview数据 */
@property (nonatomic, strong) NSArray *article_list;

/** 推荐status数据 */
@property (nonatomic, strong) NSArray *status;

/** 推荐iscollect数据 */
@property (nonatomic, strong) NSArray *iscollect;
+ (instancetype)detailModelWith:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
