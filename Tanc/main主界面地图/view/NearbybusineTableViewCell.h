//
//  NearbybusineTableViewCell.h
//  Tanc
//
//  Created by f on 2019/12/12.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NearbybusineTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *imageIcon;//图标
@property (nonatomic,strong)UILabel *labName;//商家名称
@property (nonatomic,strong)UILabel *labAddress;//地址
@property (nonatomic,strong)UILabel *labTimer;//营业时间
@property (nonatomic,strong)UILabel *labDistance;//距离
@property (nonatomic,strong)UILabel *labAvailable;//Available
@property (nonatomic,strong)UILabel *labCanreturn;//Can returnCan return
  
@end

NS_ASSUME_NONNULL_END
