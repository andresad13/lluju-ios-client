//
//  LostPurchaseView.m
//  Tanc
//
//  Created by f on 2019/12/18.
//  Copyright © 2019 f. All rights reserved.
//

#import "LostPurchaseView.h"

@implementation LostPurchaseView

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
    CGRect rect = MY_RECT(0, 0, 273, 272);
    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewBackgr];
    viewBackgr.center = CGPointMake(WIDTH / 2.0, HEIGHT / 2.0);
    viewBackgr.backgroundColor = [UIColor whiteColor];
    [viewBackgr qi_clipCorners:UIRectCornerAllCorners radius:9];
    
    rect = MY_RECT(0, 29.5, 57.5, 80);
    rect.size.width = rect.size.height / 80.0 * 58;
    rect.origin.x = (CGRectGetWidth(viewBackgr.frame) - rect.size.width) / 2.0;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    [viewBackgr addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"LostPurchase"];
    
    rect = MY_RECT(245, 15, 12.5, 12.5);
    rect.size.height = rect.size.width;
    UIButton *buttonDelete = [[UIButton alloc]initWithFrame:rect];
    [viewBackgr addSubview:buttonDelete];
    [buttonDelete setImage:[UIImage imageNamed:@"LostPurchase_close"] forState:UIControlStateNormal];
    [buttonDelete addTarget:self action:@selector(clickDele) forControlEvents:UIControlEventTouchUpInside];
    
    
    rect = MY_RECT(20, 121, 232, 18);
       UILabel *labDescription = [[UILabel alloc]initWithFrame:rect];
       [viewBackgr addSubview:labDescription];
       labDescription.textColor = [UIColor blackColor];
       labDescription.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:16];
       labDescription.textAlignment = NSTextAlignmentCenter;
       labDescription.numberOfLines = 0;
       labDescription.text =  CurLanguageCon(@"Description");
    
    
    rect = MY_RECT(20, 149, 232, 58);
    UILabel *lab = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:lab];
    lab.textColor = [UIColor blackColor];
    lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:10.3];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 0;
    lab.text =  CurLanguageCon(@"If the charger is lost during the rental process, you can click the lost purchase button below. The system will refund the remaining deposit after deducting the cost of the charger.");
    
    rect = MY_RECT(89, 218, 94, 31);
    
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
    
    
    UIButton *buttonBuy = [[UIButton alloc]initWithFrame:rect];
    [viewBackgr addSubview:buttonBuy];
    [buttonBuy setTitle:[GlobalObject getCurLanguage:@"BUY"] forState:UIControlStateNormal];
    buttonBuy.titleLabel.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:15];
//    buttonBuy.backgroundColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
//    [buttonBuy qi_clipCorners:UIRectCornerAllCorners radius:rect.size.height / 2.0];
    [buttonBuy addTarget:self action:@selector(clickBuy) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickDele
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)clickBuy
{
    if (_delegate && [_delegate respondsToSelector:@selector(requestPay)]) {
        [_delegate requestPay];

    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
