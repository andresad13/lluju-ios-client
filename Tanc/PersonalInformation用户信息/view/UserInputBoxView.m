//
//  UserInputBoxView.m
//  Tanc
//
//  Created by f on 2019/12/7.
//  Copyright © 2019 f. All rights reserved.
//

#import "UserInputBoxView.h"

@implementation UserInputBoxView

- (void)initUI
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    
    CGRect rect = MY_RECT(51, 157, 273, 234);
    
    viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewBackgr];
    viewBackgr.backgroundColor = [UIColor whiteColor];
    [viewBackgr qi_clipCorners:UIRectCornerAllCorners radius:10];
    
    rect = MY_RECT(245, 15, 12.5, 12.5);
    rect.size.height = rect.size.width;
    UIButton *buttonDelete = [[UIButton alloc]initWithFrame:rect];
    [viewBackgr addSubview:buttonDelete];
    [buttonDelete setImage:[UIImage imageNamed:@"closeNotRound"] forState:UIControlStateNormal];
    [buttonDelete addTarget:self action:@selector(clickClose) forControlEvents:UIControlEventTouchUpInside];
    
    
    rect = MY_RECT(0, 54, 0, 20);
    UIView *viewTitleBackgr = [[UIView alloc]initWithFrame:rect];
    [viewBackgr addSubview:viewTitleBackgr];
    
    rect = MY_RECT(0, 0, 20, 20);
    rect.size.height = rect.size.width;
    UIImageView *imageEdit = [[UIImageView alloc]initWithFrame:rect];
    [viewTitleBackgr addSubview:imageEdit];
    imageEdit.image = [UIImage imageNamed:@"userInfor_Edit"];
    
    NSString *str = InputBox_Name == curInputBoxEnum ? [GlobalObject getCurLanguage:@"Please enter a nickname"] : [GlobalObject getCurLanguage:@"email"];
    UIFont *font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16];
    CGFloat flowid = [GlobalObject widthOfString:str font:font];
    rect = CGRectMake(CGRectGetWidth(imageEdit.frame) + 3, 0, flowid, 20);
    //
    UILabel *labTitle = [[UILabel alloc]initWithFrame:rect];
    [viewTitleBackgr addSubview:labTitle];
    labTitle.font = font;
    labTitle.text = str;
    labTitle.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    
    
    rect = viewTitleBackgr.frame;
    rect.size.width = CGRectGetWidth(labTitle.frame) + labTitle.frame.origin.x;
    rect.origin.x = (CGRectGetWidth(viewBackgr.frame) - rect.size.width) / 2.0;
    viewTitleBackgr.frame = rect;
    
    
  
    NSArray *array = InputBox_Name == curInputBoxEnum ?  @[@"It ’s easier for friends to find",@"you after setting up your nickname"] : @[@"Please enter your e-mail address"];
    CGFloat floY = (89  - 4 ) / IPHONE6SHEIGHT * HEIGHT;
    for (int i = 0; i< array.count; i ++) {
        
        str = CurLanguageCon(array[i]);
        rect = MY_RECT(21, 89  - 4, 273 - 21 * 2, 12);
        rect.origin.y = floY;
        rect.size.height = [GlobalObject getStringHeightWithText:str font:[GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:11] viewWidth:rect.size.width];
        UILabel *labSec = [[UILabel alloc]initWithFrame:rect];
        [viewBackgr addSubview:labSec];
        labSec.textAlignment = NSTextAlignmentCenter;
        labSec.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:11];;
        labSec.textColor =[UIColor colorWithRed:161/255.0 green:161/255.0 blue:161/255.0 alpha:1.0];
        labSec.numberOfLines = 0;
        labSec.text = CurLanguageCon(array[i]);
        floY = floY + rect.size.height;
    } 
    rect = MY_RECT(21, 109 + 10, 230, 34);
    UIView *viewTextFilBackgr = [[UIView alloc]initWithFrame:rect];
    [viewBackgr addSubview:viewTextFilBackgr];
    viewTextFilBackgr.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [viewTextFilBackgr qi_clipCorners:UIRectCornerAllCorners radius:6];
    
    rect = MY_RECT(10, 2, 150, 32);
    textField = [[UITextField alloc]initWithFrame:rect];
    [viewTextFilBackgr addSubview:textField];
    textField.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    textField.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:11];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.delegate = self;
    
    if (InputBox_Name == curInputBoxEnum) {
        rect = MY_RECT(198 - 30, 2, 21 + 30, 32);
        labLen = [[UILabel alloc]initWithFrame:rect];
        [viewTextFilBackgr addSubview:labLen];
        labLen.text = @"1/12";
        labLen.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:11];
        labLen.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
        labLen.textAlignment = NSTextAlignmentRight;
    }
    else
    {
        rect = MY_RECT(204, (34 - 16) / 2.0, 16, 16);
        rect.size.width = rect.size.height;
        UIButton *buttonClean = [[UIButton alloc]initWithFrame:rect];
        [viewTextFilBackgr addSubview:buttonClean];
        [buttonClean setImage:[UIImage imageNamed:@"editEmailDelet"] forState:UIControlStateNormal];
        [buttonClean addTarget:self action:@selector(clickClean) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    str = InputBox_Name == curInputBoxEnum ? [GlobalObject getCurLanguage:@"DETERMINE"] : [GlobalObject getCurLanguage:@"BIND"];
    rect = MY_RECT(78.5, 185.5, 116, 31);
    UIButton *buttonOk = [[UIButton alloc]initWithFrame:rect];
    [viewBackgr addSubview:buttonOk];
    [buttonOk setTitle:str forState:UIControlStateNormal];
    buttonOk.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
    [buttonOk addTarget:self action:@selector(clickOK) forControlEvents:UIControlEventTouchUpInside];
    buttonOk.backgroundColor = [UIColor colorWithRed:100/255.0 green:177/255.0 blue:94/255.0 alpha:1.0];
    [buttonOk qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
    [buttonOk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //editEmailDelet@3x
}


- (void)setInputBoxEnum:(InputBoxEnum)seleInputBoxEnum str:(NSString *)str
{
    curInputBoxEnum = seleInputBoxEnum;
   
    
    [self initUI];
    
    textField.text = str;
   // textField.text = @"flaviotorresg@hotmail.com";
    if (InputBox_Name == curInputBoxEnum) {
        labLen.text = [NSString stringWithFormat:@"%ld/10",[str length]];
    }
}



#pragma mark ---textField delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * textfieldContent = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (InputBox_Name == curInputBoxEnum) {
        if (textfieldContent.length > 10) {
            textField.text =  [textfieldContent substringToIndex:10];
            
            labLen.text = [NSString stringWithFormat:@"%ld/10",[textField.text length]];
            return NO;
        }
        labLen.text = [NSString stringWithFormat:@"%ld/10",[textfieldContent length]];
    }
     
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view != viewBackgr) {
     [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    }
    else if(touch.view != textField)
    {
        [textField resignFirstResponder];
        
    }
}


#pragma mark --- clickClose

- (void)clickOK
{
    if (_delegate && [_delegate respondsToSelector:@selector(editTextEnd:)]) {
        [_delegate editTextEnd:textField.text];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)clickClose
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)clickClean
{
    textField.text = @"";
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
