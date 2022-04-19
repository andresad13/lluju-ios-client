//
//  BankCardTableViewCell.h
//  ChargeBuddy
//
//  Created by f on 2020/4/18.
//  Copyright © 2020 f. All rights reserved.
//cell 高度

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankCardTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *imageIcon;

@property (nonatomic,strong)UILabel *labNumber;

@property (nonatomic,strong)UIButton *buttonCheck;

- (void)setImageIconType:(NSInteger)intType;
@end

NS_ASSUME_NONNULL_END
