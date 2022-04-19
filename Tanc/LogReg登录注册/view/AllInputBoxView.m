//
//  AllInputBoxView.m
//  Tanc
//
//  Created by f on 2019/12/4.
//  Copyright © 2019 f. All rights reserved.
//所有输入框背景

#import "AllInputBoxView.h"

@implementation AllInputBoxView


+ (AllInputBoxView *)createAllInput:(CGRect)frame bCode:(BOOL)bCode
{
    AllInputBoxView * allInputBoxView = [[AllInputBoxView alloc]initWithFrame:frame];
    allInputBoxView.bCode = bCode;
    [allInputBoxView setAllinputViewState:NO];
    [allInputBoxView updateSeleUI:NO];
    allInputBoxView.buttonClick.hidden = NO;
    return allInputBoxView;
}


- (UIButton *)buttonClick
{
    if (!_buttonClick) {
        CGRect rect = MY_RECT(40, 0, 200, 54);
        _buttonClick = [[UIButton alloc]initWithFrame:rect];
        [self addSubview:_buttonClick];
        [_buttonClick addTarget:self action:@selector(clickTextField) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _buttonClick;
}
 

-(LoginProLabel *)labPro
{
    if (!_labPro) {
        CGRect rect = MY_RECT(0, 24 + 8, 100, 14);
        _labPro = [[LoginProLabel alloc]initWithFrame:rect];
        [self addSubview:_labPro];
        UIFont *font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
       _labPro.labSec.textColor = [UIColor colorWithRed:75/255.0 green:84/255.0 blue:97/255.0 alpha:1.0];
        [_labPro setLabText:@"" strSec:@"" font:font];
        
    }
    return _labPro;
}

-(void)setEmail:(BOOL)bEmail
{//邮箱 当前的
    _bEmal = bEmail;
 
    [self updateTextUI];
    //是否正在输入
//    CGRect rect = self.labPro.frame;
//    if (_bEnter) {
//        rect.origin.y =  5 / IPHONE6SHEIGHT * HEIGHT;
//        rect.origin.x = 0;
//    }
//
//    [GlobalObject moveAnimation:self.labPro Rect:rect AnimaTime:0.15 AnimationStr:@"labProAnimaEnter" AnimationCurve:1];
    
     
//    if (!bEmail) {
//
//           _textField.keyboardType = UIKeyboardTypeNumberPad;
//       }
//       else
//       {
//            _textField.keyboardType = UIKeyboardTypeASCIICapable;
//       }
}

-(UIView *)viewLine
{
    if (!_viewLine) {
        CGRect rect = CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1);
        _viewLine = [[UIView alloc]initWithFrame:rect];
        [self addSubview:_viewLine];
    }
    return _viewLine;
}

-(UITextField *)textField
{
    if(!_textField)
    {
        CGRect rect = _bCode ? MY_RECT(45, 24 + 8, 280, 14) : MY_RECT(0, 24, 280, 14);
        _textField = [[UITextField alloc]initWithFrame:rect];
        [self addSubview:_textField];
        _textField.textColor = [UIColor colorWithRed:36/255.0 green:39/255.0 blue:43/255.0 alpha:1.0];
        _textField.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
        _textField.textAlignment = NSTextAlignmentLeft;
       ;
    }
    return _textField;
}

- (UIButton *)buttonCode
{
    if (!_buttonCode) {
        CGRect rect = MY_RECT(0, 24 + 8, 38, 14);
        _buttonCode = [[UIButton alloc]initWithFrame:rect];
        [_buttonCode setTitle:@"+57" forState:UIControlStateNormal];
        [self addSubview:_buttonCode];
        _buttonCode.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
        [_buttonCode setTitleColor:[UIColor colorWithRed:36/255.0 green:39/255.0 blue:43/255.0 alpha:1.0] forState:UIControlStateNormal];
        _buttonCode.hidden = !_bCode;
        _buttonCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _buttonCode;
}

/*刷新选中的状态*/
- (void)updateSeleUI:(BOOL)bSele
{
 
    if (bSele) {
        //是否是选中状态
        self.viewLine.backgroundColor = [UIColor colorWithRed:99/255.0 green:177/255.0 blue:94/255.0 alpha:1.0];
       
    }
    else
    {
        self.viewLine.backgroundColor = [UIColor colorWithRed:211/255.0 green:223/255.0 blue:239/255.0 alpha:1.0];
    }
}

/*当前s是否在上面 是否有文字 */
- (void)setAllinputViewState:(BOOL)bTop
{
  //  bCurSele = bTop;
    if (!bTop) {
        [self updateNotTopView];
    }
    else
    {
        [self updateTopView];
    }
}

/*刷新没有文字的UI*/
- (void)updateNotTopView
{
    if (_bCode && !_bEmal)
    {//没有选择状态 但是是 区号
        CGRect rect = MY_RECT(40, 24 + 8, 200, 14);
        //self.labPro.frame = rect;
        [GlobalObject moveAnimation:self.labPro Rect:rect AnimaTime:0.3 AnimationStr:@"labProAnima" AnimationCurve:1];
        
        rect = MY_RECT(40, 24 + 8, 260, 14);
        self.textField.frame = rect;
       // [GlobalObject moveAnimation:self.textField Rect:rect AnimaTime:0.3 AnimationStr:@"labProAnima" AnimationCurve:1];
        self.buttonCode.hidden = NO;
    }
    else
    {
        CGRect rect = MY_RECT(0, 24 + 8, 200, 14);
        [GlobalObject moveAnimation:self.labPro Rect:rect AnimaTime:0.3 AnimationStr:@"labProAnima" AnimationCurve:1];
        
        rect = MY_RECT(0, 24 + 8, 260, 14);
        self.textField.frame = rect;
 
        self.buttonCode.hidden = YES;
    }
     self.labPro.labSec.textColor = [UIColor colorWithRed:75/255.0 green:84/255.0 blue:97/255.0 alpha:0.45];
    self.textField.hidden = NO;
}

/*刷新  有文字的 UI*/
- (void)updateTopView
{
    //如果是选择的区号
    CGRect rect = MY_RECT(00, 5, 200, 14);
    [GlobalObject moveAnimation:self.labPro Rect:rect AnimaTime:0.15 AnimationStr:@"labProAnima" AnimationCurve:1];
   
     self.labPro.labSec.textColor = [UIColor colorWithRed:36/255.0 green:39/255.0 blue:43/255.0 alpha:0.7];
    
    if (_bCode && _bEmal) {
         CGRect rect = MY_RECT(0, 24 + 8, 200, 14);
           [GlobalObject moveAnimation:self.textField Rect:rect AnimaTime:0.15 AnimationStr:@"TextFieldAnima" AnimationCurve:1];
         _buttonCode.hidden = YES;
    }
    else if(_bCode)
    {
         _buttonCode.hidden = !YES;
        CGRect rect = MY_RECT(45, 24 + 8, 200, 14);        [GlobalObject moveAnimation:self.textField Rect:rect AnimaTime:0.15 AnimationStr:@"TextFieldAnima" AnimationCurve:1];
    }
    else
    {
       _buttonCode.hidden =  YES;
    } 
}

- (void)updateTextUI
{
    if ([_textField.text length] > 0 || _bEnter) {
        [self setAllinputViewState:YES];
    }
    else
    {
        [self setAllinputViewState:NO];
    }
}

- (void)clickTextField
{
    [_textField becomeFirstResponder];
    
}


//


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
