//
//  MiInfoCell.h
//  CityMi
//
//  Created by JSH on 2021/3/14.
//

#import <UIKit/UIKit.h>
#import "MiInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MiInfoCell : UITableViewCell
@property (nonatomic, strong) MiInfoModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView infoCellModel:(MiInfoModel *)model;
@end

NS_ASSUME_NONNULL_END
