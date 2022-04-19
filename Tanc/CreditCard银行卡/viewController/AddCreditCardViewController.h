//
//  AddCreditCardViewController.h
//  Tanc
//
//  Created by f on 2019/12/26.
//  Copyright © 2019 f. All rights reserved.
//

#import "AllSupViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AddCreditCardViewControllerDelegate <NSObject>

@optional

- (void)addBankID:(NSString *)bankI_d;

@end

@interface AddCreditCardViewController : AllSupViewController

@property (nonatomic,assign)int addCareditCardType;//添加银行类型 1 充值 2 收费规则

@property (nonatomic,assign)id<AddCreditCardViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
