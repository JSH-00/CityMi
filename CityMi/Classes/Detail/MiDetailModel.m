//
//  MiDetailModel.m
//  CityMi
//
//  Created by Billie Ji on 2021/3/3.
//

#import "MiDetailModel.h"

@implementation MiDetailModel
+ (instancetype)detailModelWith:(NSDictionary *)dict
{
    MiDetailModel *detail = [self new];
    [detail setValuesForKeysWithDictionary:dict];
    return detail;
}
@end
