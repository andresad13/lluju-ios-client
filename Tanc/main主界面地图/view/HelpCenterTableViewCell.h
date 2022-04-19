//
//  HelpCenterTableViewCell.h
//  Tanc
//
//  Created by f on 2019/12/10.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelpCenterTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *labCon;//e内容
@property (nonatomic,strong)UIView *viewLine;

- (void)setLabConText:(NSString *)str floHei:(CGFloat)floHei;
@end

NS_ASSUME_NONNULL_END
