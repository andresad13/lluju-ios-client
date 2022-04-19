//
//  AreaCodeTableViewCell.h
//  SpeedTime
//
//  Created by f on 2019/9/10.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AreaCodeTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *labName;
@property (nonatomic,strong)UILabel *labCode;

@property (nonatomic,strong)UIView *viewLine;

@end

NS_ASSUME_NONNULL_END
