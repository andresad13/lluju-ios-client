//
//  LoginView.h
//  Tanc
//
//  Created by f on 2019/12/4.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllInputBoxView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LoginViewDelegate <NSObject>

@optional

/*找回密码*/
- (void)openForgetPassword;

- (void)openLoginSucc;

/*打开选择区号的界面*/
- (void)openCode:(int)intType;

@end

@interface LoginView : UIView<UITextFieldDelegate>
{
    BOOL bEmail;//当前是否是邮箱
}

@property (nonatomic,assign)id<LoginViewDelegate>delegate;

@property (nonatomic,strong)AllInputBoxView *phoneTextfiel;
@property (nonatomic,strong)AllInputBoxView *passTextfiel;

@property (nonatomic,strong)NSString *strCode;

/*停止键盘输入*/
- (void)StopInput;

/*结束输入 并且更新*/
- (void)endAndUpdate;
@end

NS_ASSUME_NONNULL_END
