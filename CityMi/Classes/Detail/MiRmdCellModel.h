//
//  MiRmdCellModel.h
//  CityMi
//
//  Created by Billie Ji on 2021/3/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MiRmdCellModel : NSObject
/** 文字 */
@property (nonatomic, copy) NSString *ch;
/** 图片地址str */
@property (nonatomic, copy) NSString *pic;
/** 文字对应的 cell 高度*/
@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)rmdCellModelWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
