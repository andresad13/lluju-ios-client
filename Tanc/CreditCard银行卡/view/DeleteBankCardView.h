//
//  DeleteBankCardView.h
//  Tanc
//
//  Created by f on 2019/12/26.
//  Copyright © 2019 f. All rights reserved.
//删除银行卡

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DeleteBankCardViewDelegate <NSObject>

@optional
- (void)removeBank;

@end

@interface DeleteBankCardView : UIView
{
    UIView *viewBackgr;
}

@property (nonatomic,assign)id<DeleteBankCardViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
