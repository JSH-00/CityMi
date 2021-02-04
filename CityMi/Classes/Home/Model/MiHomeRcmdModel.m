//
//  MiHomeRecommendHeadView.m
//  CityMi
//
//  Created by Billie Ji on 2021/2/2.
//

#import "MiHomeRcmdModel.h"

@implementation MiHomeRcmdModel
- (instancetype)initHomeHeadModelWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
