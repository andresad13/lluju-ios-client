//
//  RechargeResultViewController.h
//  Tanc
//
//  Created by f on 2020/1/14.
//  Copyright © 2020 f. All rights reserved.
//

#import "AllSupViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RechargeResultViewController : AllSupViewController

@property (nonatomic,assign)BOOL bBuy;//押金购买
@property (nonatomic,assign)BOOL bWithdraw;//提现结果
@property (nonatomic,assign)BOOL bSucces;//是否成功
@property (nonatomic,strong)NSString *strTime;//支付时间
@property (nonatomic,strong)NSDictionary *dic;//支付时间
@end

NS_ASSUME_NONNULL_END
