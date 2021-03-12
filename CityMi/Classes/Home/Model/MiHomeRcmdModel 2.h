//
//  MiHomeRecommendHeadView.h
//  CityMi
//
//  Created by Billie Ji on 2021/2/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MiHomeRcmdModel : NSObject
//headView的颜色
@property (nonatomic, copy) NSString *color;
/** headView的title */
@property (nonatomic, copy) NSString *tag_name;
/** headView的subTitle */
@property (nonatomic, copy) NSString *section_count;
/** cell模型 */
@property (nonatomic, strong) NSArray *body;

- (instancetype)initHomeHeadModelWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
