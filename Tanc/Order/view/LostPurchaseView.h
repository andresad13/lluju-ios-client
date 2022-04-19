//
//  LostPurchaseView.h
//  Tanc
//
//  Created by f on 2019/12/18.
//  Copyright © 2019 f. All rights reserved.
//遗失购买

#import <UIKit/UIKit.h>

@protocol LostPurchaseViewDelete <NSObject>

@optional

- (void)requestPay;

@end

NS_ASSUME_NONNULL_BEGIN

@interface LostPurchaseView : UIView

@property (nonatomic,assign)id<LostPurchaseViewDelete>delegate;

@end

NS_ASSUME_NONNULL_END
