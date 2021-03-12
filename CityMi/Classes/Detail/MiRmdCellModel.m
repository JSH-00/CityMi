//
//  MiRmdCellModel.m
//  CityMi
//
//  Created by Billie Ji on 2021/3/4.
//

#import "MiRmdCellModel.h"

@implementation MiRmdCellModel
+ (instancetype)rmdCellModelWithDict:(NSDictionary *)dict {
    MiRmdCellModel *cellModel = [[self alloc]init];
    cellModel.pic = dict[@"pic"];
    cellModel.ch = dict[@"ch"];
    return cellModel;
}
@end
