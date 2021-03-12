//
//  MiRmdPicCell.h
//  CityMi
//
//  Created by JSH on 2021/3/9.
//

#import <UIKit/UIKit.h>
#import "MiRmdPicCell.h"
#import "MiRmdCellModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MiRmdPicCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView rmdCellModel:(MiRmdCellModel *)rmdCellModel;
@end

NS_ASSUME_NONNULL_END
