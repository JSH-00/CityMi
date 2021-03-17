//
//  MiInfoModel.m
//  CityMi
//
//  Created by JSH on 2021/3/13.
//

#import "MiInfoModel.h"

@implementation MiInfoModel
+ (instancetype)infoModelWithDict:(NSDictionary *)dict {
    MiInfoModel *model = [[MiInfoModel alloc]init];
    model.title = dict[@"title"];
    model.subTitle = dict[@"subTitle"];
    model.isShowImage = [dict[@"isShowImage"] integerValue];
    return model;
}
@end
