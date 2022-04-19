//
//  RechargeViewController.h
//  Tanc
//
//  Created by f on 2019/12/11.
//  Copyright © 2019 f. All rights reserved.
//充钱

#import "AllSupViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RechargeViewController : AllSupViewController
{
    BOOL bStart_Pay;//是否开始支付
    BOOL bRequest;
    long long curTime;//记录当前时间
    int number;//记录次数
    NSTimer *timer;
   // NSString *order_Id;
    NSString *paymentId;
    NSDictionary *dicPay;
}
@property (nonatomic,assign)BOOL bChargin;//是s否从 租借的地方进入
@end

NS_ASSUME_NONNULL_END
