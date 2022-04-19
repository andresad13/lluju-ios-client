//
//  MerchantWindowView.h
//  Tanc
//
//  Created by f on 2019/12/18.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MerchantWindowView : UIView

@property (nonatomic,strong)UIImageView *imageIcon;//图标

@property (nonatomic,strong)UIButton *buttonNavigation;//图标

@property (nonatomic,strong)UILabel *labName;//商家名称

@property (nonatomic,strong)UILabel *labAddress;//商家地址

@property (nonatomic,strong)UILabel *labBusinesshours;//营业时间

@property (nonatomic,strong)UILabel *labAvailable;//可以租借

@property (nonatomic,strong)UILabel *labCanreturn;//可以归还

@property (nonatomic,strong)UILabel *labDistance;//距离

@property (nonatomic,strong)NSString *shopId;

@property (nonatomic,strong)UIButton *buttonDef;//商家详情

@end

NS_ASSUME_NONNULL_END
