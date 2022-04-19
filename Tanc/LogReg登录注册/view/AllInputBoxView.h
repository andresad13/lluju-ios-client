//
//  AllInputBoxView.h
//  Tanc
//
//  Created by f on 2019/12/4.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginProLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AllInputBoxView : UIView
{
    BOOL bCurSele;//记录当前选中的状态
}
@property (nonatomic,strong)LoginProLabel *labPro;//提示文字
@property (nonatomic,strong)UITextField *textField;//输入
@property (nonatomic,strong)UIButton *buttonCode;//区号
@property (nonatomic,strong)UIView *viewLine;//区号 
@property (nonatomic,assign)BOOL bCode;//是否是区号
@property (nonatomic,assign)BOOL bEmal;//

@property (nonatomic,assign)BOOL bEnter;//是否是正在输入

@property (nonatomic,strong)UIButton *buttonClick;
 

+ (AllInputBoxView *)createAllInput:(CGRect)frame bCode:(BOOL)bCode;

/*刷新选中的状态*/
- (void)updateSeleUI:(BOOL)bSele;

/*当前s是否在上面 是否有文字 */
- (void)setAllinputViewState:(BOOL)bTop;

- (void)updateTextUI;

-(void)setEmail:(BOOL)bEmail;//选择当前邮箱

@end

NS_ASSUME_NONNULL_END
