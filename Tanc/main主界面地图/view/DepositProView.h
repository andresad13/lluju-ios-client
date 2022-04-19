//
//  DepositProView.h
//  Qualle
//
//  Created by f on 2020/2/27.
//  Copyright © 2020 f. All rights reserved.
//押金不足的提示框

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DepositProViewDelegate <NSObject>

- (void)recharge;

@end

@interface DepositProView : UIView
{
    UIView *viewBackgr;
}
@property (nonatomic,assign)id<DepositProViewDelegate>delegate;

@property (nonatomic,assign)BOOL bDeposit;//是否是a押金

@property (nonatomic,assign)BOOL bWithdraw;//是否t提现

@property (nonatomic,strong)NSString *strMon;//是否是a押金

- (void)updateUI;
@end

NS_ASSUME_NONNULL_END
