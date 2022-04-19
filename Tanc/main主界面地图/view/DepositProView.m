//
//  DepositProView.m
//  Qualle
//
//  Created by f on 2020/2/27.
//  Copyright © 2020 f. All rights reserved.
//

#import "DepositProView.h"

@implementation DepositProView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

- (void)updateUI
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    
    CGRect rect = MY_RECT(51, 203, 273, 261);
   viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewBackgr];
    viewBackgr.backgroundColor = [UIColor whiteColor];
    [viewBackgr qi_clipCorners:UIRectCornerAllCorners radius:6];
    
    rect = MY_RECT(245, 15, 13, 13);
    rect.size.width = rect.size.height;
    UIImageView *imageDelete = [[UIImageView alloc]initWithFrame:rect];
    [viewBackgr addSubview:imageDelete];
    imageDelete.image = [UIImage imageNamed:@"deleteCreditCard"];
     
    rect = MY_RECT(245 - 20, 0, 13 + 40, 13 + 40);
    UIButton *buttonDelete = [[UIButton alloc]initWithFrame:rect];
    [viewBackgr addSubview:buttonDelete];
    [buttonDelete addTarget:self action:@selector(clickDelete) forControlEvents:UIControlEventTouchUpInside];
    
    
    rect = MY_RECT(104, 50, 65, 40);
    rect.size.width = rect.size.height / 40.0 * 65;
    UIImageView *imagePro = [[UIImageView alloc]initWithFrame:rect];
    [viewBackgr addSubview:imagePro];
    imagePro.center = CGPointMake(viewBackgr.frame.size.width / 2.0, imagePro.center.y);
    imagePro.image = [UIImage imageNamed:@"proCreditCard"];
    
 
    rect = MY_RECT(0, 120, 273, 18);
    UILabel *labTips = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labTips];
    labTips.text = CurLanguageCon(@"Tips");
    labTips.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    labTips.textAlignment = NSTextAlignmentCenter;
    labTips.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16];
     
    if(!_bWithdraw)
    {
        [self initDep];
    }
    else
    {
        [self initWithdraw];
    }
   
    
    rect = MY_RECT(78, 205, 116, 31);
    UIView *viewBtnBackgr = [[UIView alloc]initWithFrame:rect];
      [viewBackgr addSubview:viewBtnBackgr];
      
      CAGradientLayer *gl = [CAGradientLayer layer];
      gl.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
      gl.startPoint = CGPointMake(0, 0);
      gl.endPoint = CGPointMake(1, 1);
      gl.colors = @[(__bridge id)[UIColor colorWithRed:0x93/255.0 green:0xc1/255.0 blue:0x5f/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0x63/255.0 green:0xb1/255.0 blue:0x5e/255.0 alpha:1.0].CGColor];
      gl.locations = @[@(0.0),@(1.0)];
      
      [viewBtnBackgr.layer addSublayer:gl];
      viewBtnBackgr.shadowOpacity(0.7).shadowColor((UIColor *)[UIColor colorWithRed:99/255.0 green:177/255.0 blue:94/255.0 alpha:1.0]).shadowRadius(6).shadowOffset(CGSizeMake(5, 5)).conrnerRadius(rect.size.height / 2.0).conrnerCorner(UIRectCornerAllCorners).showVisual();
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:rect];
    [viewBackgr addSubview:button];//Confirm
//    button.backgroundColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
//    [button qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height/2.0];
    [button setTitle:[GlobalObject getCurLanguage:@"Recharge"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    viewBackgr.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.35 animations:^{
        self->viewBackgr.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}

- (void)initWithdraw
{
     
    NSString *strDep = [NSString stringWithFormat:@"%@ SAR%0.1f",[GlobalObject getCurLanguage:@"Current total deposit:"],[[GlobalObject shareObject].userModel.defaultAccount floatValue]];
    NSString *strWithdrawable = [NSString stringWithFormat:@"%@ SAR%0.1f",[GlobalObject getCurLanguage:@"Withdrawable deposit:"],([_strMon floatValue] - 1.01) * (1 - 0.027)];
    
     NSString *strCostPerTran = [GlobalObject getCurLanguage:@"Cost per transaction:"];
      NSString *strCommission = [GlobalObject getCurLanguage:@"Commission per transaction:"];
  
    NSArray *array = @[strDep,strWithdrawable,strCostPerTran,strCommission];
    
    UIFont *font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
    CGFloat floY = 140 / IPHONE6SHEIGHT * HEIGHT;
    for (int i = 0; i < array.count; i ++) {
        
        CGRect rect = MY_RECT(0, 149 + 18 , 273, 11);
        rect.origin.y = floY;
        UIView *viewLab = [[UIView alloc]initWithFrame:rect];
        [viewBackgr addSubview:viewLab];
        
        NSString *curStrMon = [GlobalObject getCurLanguage:array[i]];
        CGFloat floWid = [GlobalObject widthOfString:curStrMon font:font];
        rect = MY_RECT(0, 0  , 273, 11);
        rect.size.width = i > 1 ?  floWid :rect.size.width;
        UILabel *labelFir = [[UILabel alloc]initWithFrame:rect];
        [viewLab addSubview:labelFir];
        labelFir.text = curStrMon;
        labelFir.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
        labelFir.textAlignment = NSTextAlignmentCenter;
        labelFir.font = font;
         
        if (i > 1) {
            NSString *strCon = i == 2 ? @"$1.01": @"2.7%";
            floWid = [GlobalObject widthOfString:strCon font:font];
            rect = MY_RECT(0, 0  , 273, 11);
            rect.origin.x = labelFir.frame.size.width;
            rect.size.width = floWid;
            UILabel *labelSec = [[UILabel alloc]initWithFrame:rect];
            [viewLab addSubview:labelSec];
            labelSec.text = strCon;
            labelSec.textColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
            labelSec.textAlignment = NSTextAlignmentCenter;
            labelSec.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
            
            rect = viewLab.frame;
            rect.size.width = labelSec.frame.origin.x + CGRectGetWidth(labelSec.frame);
            rect.origin.x = (CGRectGetWidth(viewBackgr.frame) - rect.size.width) / 2.0;
            viewLab.frame = rect;
        }
        floY = floY + CGRectGetHeight(viewLab.frame) + 2;
    }
}


- (void)initDep
{
    NSString *strPhone = _bDeposit ? [GlobalObject getCurLanguage:@"Your current account deposit is"] :[GlobalObject getCurLanguage:@"Your current account balance is"];
    NSString *strWorking = CurLanguageCon(@", please top up first");
    
    NSArray *array = @[strPhone,strWorking];
        
    CGRect rect = MY_RECT(0, 149  , 273, 11);
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:label];
    label.text = array[0];
    label.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
    
    rect = MY_RECT(0, 149 + 18 , 273, 11);
    UIView *viewLab = [[UIView alloc]initWithFrame:rect];
    [viewBackgr addSubview:viewLab];
    
    NSString *curStrMon = [NSString stringWithFormat:@"$ %0.2f",[_strMon floatValue]];
    CGFloat floWid = [GlobalObject widthOfString:curStrMon font:label.font];
    rect = MY_RECT(0, 0  , 273, 11);
    rect.size.width = floWid;
    UILabel *labelFir = [[UILabel alloc]initWithFrame:rect];
    [viewLab addSubview:labelFir];
    labelFir.text = curStrMon;
    labelFir.textColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
    labelFir.textAlignment = NSTextAlignmentCenter;
    labelFir.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
    
    floWid = [GlobalObject widthOfString:array[1] font:label.font];
    rect = MY_RECT(0, 0  , 273, 11);
    rect.origin.x = labelFir.frame.size.width;
    rect.size.width = floWid;
    UILabel *labelSec = [[UILabel alloc]initWithFrame:rect];
    [viewLab addSubview:labelSec];
    labelSec.text = CurLanguageCon(array[1]);
    labelSec.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    labelSec.textAlignment = NSTextAlignmentCenter;
    labelSec.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
    
    rect = viewLab.frame;
    rect.size.width = labelSec.frame.origin.x + CGRectGetWidth(labelSec.frame);
    rect.origin.x = (CGRectGetWidth(viewBackgr.frame) - rect.size.width) / 2.0;
    viewLab.frame = rect;
}
    

- (void)click
{
    if (_delegate && [_delegate respondsToSelector:@selector(recharge)]) {
        [_delegate recharge];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
                    self.alpha = 0;
                } completion:^(BOOL finished) {
                    [self removeFromSuperview];
                }];
}

- (void)clickDelete
{
    [UIView animateWithDuration:0.5 animations:^{
                    self.alpha = 0;
                } completion:^(BOOL finished) {
                    [self removeFromSuperview];
                }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view != viewBackgr) {
   
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
