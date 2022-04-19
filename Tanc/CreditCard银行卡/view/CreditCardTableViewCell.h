//
//  CreditCardTableViewCell.h
//  Tanc
//
//  Created by f on 2019/12/25.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreditCardTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *labNumber;//卡号
@property (nonatomic,strong)UIImageView *imageIcon;//卡号图标
@property (nonatomic,strong)UILabel *labMon;//年月日

@end

NS_ASSUME_NONNULL_END
