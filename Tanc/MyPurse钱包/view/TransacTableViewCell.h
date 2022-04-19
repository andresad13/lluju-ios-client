//
//  TransacTableViewCell.h
//  Tanc
//
//  Created by f on 2019/12/11.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransacTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *labType;
@property (nonatomic,strong)UILabel *labTime;
@property (nonatomic,strong)UILabel *labMon;
@property (nonatomic,strong)UIImageView *imageIcon;
- (void)setCurType:(int)intType;
@end

NS_ASSUME_NONNULL_END
