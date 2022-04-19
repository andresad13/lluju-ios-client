//
//  UserInputBoxView.h
//  Tanc
//
//  Created by f on 2019/12/7.
//  Copyright © 2019 f. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum
{
    InputBox_Name = 0,//名字
    InputBox_Email = 2,//邮件
   
    
}InputBoxEnum;

@protocol UserInputBoxViewDelegate <NSObject>

@optional

- (void)editTextEnd:(NSString *)str;

@end

@interface UserInputBoxView : UIView<UITextFieldDelegate>
{
    InputBoxEnum  curInputBoxEnum;//当前选中 的枚举
    
    UITextField *textField;//输入框
    
    UILabel *labLen;//文字长度
    
    UIView *viewBackgr;
}



@property (nonatomic,assign)id<UserInputBoxViewDelegate>delegate;


- (void)setInputBoxEnum:(InputBoxEnum)seleInputBoxEnum str:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
