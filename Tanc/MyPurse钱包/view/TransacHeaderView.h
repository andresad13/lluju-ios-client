//
//  TransacHeaderView.h
//  Tanc
//
//  Created by f on 2019/12/11.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransacHeaderView : UITableViewHeaderFooterView

@property (nonatomic,strong)UILabel *labTiti;

- (void)setLabTitiText:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
