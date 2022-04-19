//
//  HelpCenterHeadView.m
//  Tanc
//
//  Created by f on 2019/12/10.
//  Copyright © 2019 f. All rights reserved.
//

#import "HelpCenterHeadView.h"

@implementation HelpCenterHeadView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    CGRect rect = MY_RECT(12, 16, 18, 19);
    rect.size.width = rect.size.height;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    [self addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"helpcenterNumber"];
    
    _labNumber = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labNumber];
    _labNumber.text = @"1";
    _labNumber.textColor = [UIColor colorWithRed:99/255.0 green:177/255.0 blue:94/255.0 alpha:1.0];
    _labNumber.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
    _labNumber.textAlignment = NSTextAlignmentCenter;
    rect = MY_RECT(39, 19, 290, 15);
     
    _labTit = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labTit];
    _labTit.text = @"1";
    _labTit.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    _labTit.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:13];
    _labTit.textAlignment = NSTextAlignmentLeft;
    
    rect = MY_RECT(348, 22, 13, 7.5);
    rect.size.width = rect.size.height / 7.5 * 13;
    _imageNext = [[UIButton alloc]initWithFrame:rect];
    [self addSubview:_imageNext];
    [_imageNext setImage:[UIImage imageNamed:@"helpCenterNext"] forState:UIControlStateNormal];
    [_imageNext setImage:[UIImage imageNamed:@"helpCenterNext_sele"] forState:UIControlStateSelected];
    
    
    rect = CGRectMake(0, 0, WIDTH, 51 / IPHONE6SHEIGHT * HEIGHT);
    _button = [[UIButton alloc]initWithFrame:rect];
    [self addSubview:_button];
    
    
    rect = MY_RECT(0, 50, IPHONE6SWIDTH, 0.7);
    _viewLine =[[UIView alloc]initWithFrame:rect];
    [self addSubview:_viewLine];
    _viewLine.backgroundColor = [UIColor colorWithRed:229 /255.0 green:229 /255.0 blue:229 /255.0 alpha:1];
    
    self.backgroundView = ({
          UIView * view = [[UIView alloc] initWithFrame:self.bounds];
          view.backgroundColor = [UIColor colorWithWhite: 0 alpha:0];
          view;
      });
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
