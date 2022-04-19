//
//  BankCardCheckView.h
//  ChargeBuddy
//
//  Created by f on 2020/4/18.
//  Copyright © 2020 f. All rights reserved.
//银行卡选择表

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BankCardCheckViewDelegate <NSObject>

@optional
- (void)addOtherBank;

- (void)seleBankPay:(NSString *)bankID;

- (void)seleBalancePay;//选择余额支付

@end


@interface BankCardCheckView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tabView;
    
    UIView *viewBackgr;
    
    UIButton *buttonOtherCar;
   
    NSArray *arrayBank;
    
    NSString *str_Wall;
}

@property (nonatomic,assign)id<BankCardCheckViewDelegate>delegate;

- (void)updateBankList:(NSArray *)array strWall:(NSString *)strWall;


@end

NS_ASSUME_NONNULL_END
