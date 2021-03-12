//
//  MiHomeCellModel.m
//  CityMi
//
//  Created by Billie Ji on 2021/2/2.
//

#import "MiHomeCellModel.h"

@implementation MiHomeCellModel
+ (instancetype)cellModelWithDict:(NSDictionary *)dict {
    MiHomeCellModel *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
@end
