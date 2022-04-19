//
//  FeedBackButton.m
//  Tanc
//
//  Created by f on 2019/12/9.
//  Copyright © 2019 f. All rights reserved.
//

#import "FeedBackButton.h"

@implementation FeedBackButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//      CGRect frame = CGRectMake(0, 0, f.size.width, rect.size.height);
        viewBtnBackgr = [[UIView alloc]init];
        [self addSubview:viewBtnBackgr];
    }
    return self;
}

//
-(UILabel *)labTitle
{
    if (!_labTitle) {
        CGRect rect = MY_RECT(15 + 3, 0, 0, 30);
        rect.origin.x = rect.origin.x + 14 / IPHONE6SHEIGHT * HEIGHT;
        _labTitle = [[UILabel alloc]initWithFrame:rect];
        [self addSubview:_labTitle];
        _labTitle.textAlignment = NSTextAlignmentLeft;
        _labTitle.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:14];
    }
    return _labTitle;
}

-(UIButton *)button
{
    if (!_button) {
        _button = [[UIButton alloc]init];
        [self addSubview:_button];
        
    }
    return _button;
}

- (UIButton *)buttonImage
{
    if (!_buttonImage) {
        CGRect rect = MY_RECT(15, 8, 14, 14);
        rect.size.width = rect.size.height;
        _buttonImage = [[UIButton alloc]initWithFrame:rect];
        [self addSubview:_buttonImage];
        [_buttonImage setImage:[UIImage imageNamed:@"feedBackSele"] forState:UIControlStateNormal];
        [_buttonImage setImage:[UIImage imageNamed:@"feedBackSele_yes"] forState:UIControlStateSelected];
        
    }
    return _buttonImage;
}

- (void)createViewBtn:(CGRect)rect
{
  CGRect frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    viewBtnBackgr.frame = frame;
//    [self addSubview:viewBtnBackgr];
//    viewBtnBackgr.backgroundColor = [UIColor redColor];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:0x93/255.0 green:0xc1/255.0 blue:0x5f/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0x63/255.0 green:0xb1/255.0 blue:0x5e/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];

    [viewBtnBackgr.layer addSublayer:gl];
    viewBtnBackgr.hidden = YES;
}


/*设置文字*/
- (void)setButtonText:(NSString *)str
{
    CGFloat floWid = [GlobalObject widthOfString:str font:self.labTitle.font];
    self.buttonImage.selected = NO;
    
    CGRect rect = self.labTitle.frame;
    rect.size.width = floWid;
    self.labTitle.frame = rect;
    self.labTitle.text = str;
    self.labTitle.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
    
    rect = self.frame;
    rect.size.width = self.labTitle.frame.size.width + self.labTitle.frame.origin.x + 15 / IPHONE6SWIDTH * WIDTH;
    self.frame = rect;
    
    self.button.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    [self qi_clipCorners:UIRectCornerAllCorners radius:3];
}

/*设置当前z选中的状态*/
- (void)setCurSele:(BOOL)bSele
{
    
    self.buttonImage.selected = bSele;
    self.labTitle.textColor = !bSele ? [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0] : [UIColor whiteColor];
    
    self.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:250/255.0 alpha:1.0];
    
    viewBtnBackgr.hidden = !bSele;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
