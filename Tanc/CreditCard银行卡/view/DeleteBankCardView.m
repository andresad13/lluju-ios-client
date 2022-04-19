//
//  CustomerServiceView.m
//  Tanc
//
//  Created by f on 2019/12/10.
//  Copyright © 2019 f. All rights reserved.
//

#import "DeleteBankCardView.h"

@implementation DeleteBankCardView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.45];
        
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    CGRect rect = MY_RECT(0, 0, 273, 261);
    viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewBackgr];
    viewBackgr.backgroundColor =[UIColor whiteColor];
    [viewBackgr qi_clipCorners:UIRectCornerAllCorners radius:9];
    viewBackgr.center = CGPointMake(WIDTH / 2.0, HEIGHT / 2.0);
    
    
    rect = MY_RECT(245, 15, 13, 13);
    rect.size.width = rect.size.height;
    UIImageView *imageDelete = [[UIImageView alloc]initWithFrame:rect];
    [viewBackgr addSubview:imageDelete];
    imageDelete.image = [UIImage imageNamed:@"deleteCreditCard"];
    
     rect = MY_RECT(245 - 13, 0, 13 * 3, 13 * 3);
    UIButton *buttonDelete =[[UIButton alloc]initWithFrame:rect];
    [viewBackgr addSubview:buttonDelete];
    [buttonDelete addTarget:self action:@selector(clickDelete) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    rect = MY_RECT(0, 50, 50, 40);
    rect.size.width = rect.size.height / 40.0 * 65;
    rect.origin.x = (CGRectGetWidth(viewBackgr.frame) - rect.size.width) / 2.0;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    [viewBackgr addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"proCreditCard"];
    
    rect = MY_RECT(0, 120, 273, 18);
    UILabel *labTips = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labTips];
    labTips.text = CurLanguageCon(@"Tips");
    labTips.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    labTips.textAlignment = NSTextAlignmentCenter;
    labTips.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16];
    
    NSString *strPhone = CurLanguageCon(@"Are you sure you want to");
      NSString *strWorking = CurLanguageCon(@"delete the credit card?");
    
    NSArray *array = @[strPhone,strWorking];
   
    for ( int i = 0; i < 2; i ++) {
            rect = MY_RECT(0, 149 + 18 * i, 273, 11);
          UILabel *label = [[UILabel alloc]initWithFrame:rect];
          [viewBackgr addSubview:label];
          label.text = array[i];
          label.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
          label.textAlignment = NSTextAlignmentCenter;
          label.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
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
 
//    [button qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height/2.0];
    [button setTitle:[GlobalObject getCurLanguage:@"CONFIRM"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
     
    viewBackgr.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.35 animations:^{
        self->viewBackgr.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)click
{
    if (_delegate && [_delegate respondsToSelector:@selector(removeBank)]) {
        [_delegate removeBank];
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
