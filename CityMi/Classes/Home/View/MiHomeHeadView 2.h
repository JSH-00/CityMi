//
//  MiHomeHeadView.h
//  CityMi
//
//  Created by Billie Ji on 2021/2/2.
//

#import <UIKit/UIKit.h>
#import "MiHomeRcmdModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MiHomeHeadView : UITableViewHeaderFooterView
@property (strong, nonatomic) MiHomeRcmdModel *headModel;
- (instancetype)initWithHomeRcmdMode:(MiHomeRcmdModel *)headModel;
@end

NS_ASSUME_NONNULL_END
