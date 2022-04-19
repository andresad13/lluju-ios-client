//
//  HelpCenterHeadView.h
//  Tanc
//
//  Created by f on 2019/12/10.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelpCenterHeadView : UITableViewHeaderFooterView

@property (nonatomic,strong)UILabel *labNumber;

@property (nonatomic,strong)UILabel *labTit;

@property (nonatomic,strong)UIButton * imageNext;

@property (nonatomic,strong)UIButton * button;

@property (nonatomic,assign)NSInteger section;

@property (nonatomic,strong)UIView *viewLine;

@end

NS_ASSUME_NONNULL_END
