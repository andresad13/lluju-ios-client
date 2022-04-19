//
//  RegisteredView.h
//  Tanc
//
//  Created by f on 2019/12/4.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllInputBoxView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol RegisteredViewDelegate <NSObject>

@optional

- (void)goBackLogin;

/*打开选择区号的界面*/
- (void)openCode:(int)intType;

@end

@interface RegisteredView : UIView<UITextFieldDelegate>
{
    NSMutableArray *mutArray;
    UIButton *buttonSend;
    
    NSTimer *timer;
    int numberTime;
    
    BOOL bEmail;
    
    long long curSeleTime;//记录当前选中的时间
}
 
@property (nonatomic,assign)id<RegisteredViewDelegate>delegate;
@property (nonatomic,strong)NSString *strCode;

- (void)setCode:(NSString *)strCode;
/*停止键盘输入*/
- (void)StopInput;
/*结束输入 并且更新*/
- (void)endAndUpdate;

@end

NS_ASSUME_NONNULL_END
