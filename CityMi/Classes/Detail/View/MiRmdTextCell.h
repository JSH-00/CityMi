//
//  MiRmdTextCell.h
//  CityMi
//
//  Created by JSH on 2021/3/6.
//

#import <UIKit/UIKit.h>
#import "MiRmdCellModel.h"
NS_ASSUME_NONNULL_BEGIN
@class MiRmdCellModel;
@interface MiRmdTextCell : UITableViewCell
@property (nonatomic, strong) MiRmdCellModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView rmdCellModel:(MiRmdCellModel *)rmdCellModel;
@end

NS_ASSUME_NONNULL_END
