//
//  MerchantWindowView.m
//  Tanc
//
//  Created by f on 2019/12/18.
//  Copyright © 2019 f. All rights reserved.
//商家窗口

#import "MerchantWindowView.h"

@implementation MerchantWindowView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    CGRect rect = MY_RECT(17, 17.5, 60, 60);
    rect.size.width = rect.size.height;
    _imageIcon = [[UIImageView alloc]initWithFrame:rect];
    [self addSubview:_imageIcon];
    
    rect = MY_RECT(10, 23, 160, 14);
    rect.origin.x = rect.origin.x + CGRectGetWidth(_imageIcon.frame) + _imageIcon.frame.origin.x;
    _labName = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labName];
    _labName.textColor = [UIColor  blackColor];
    _labName.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:14];
    _labName.textAlignment = NSTextAlignmentLeft;
    _labName.text = @"test";
    
    
    rect = MY_RECT(10, 45, 9, 11);
    rect.origin.x = rect.origin.x + CGRectGetWidth(_imageIcon.frame) + _imageIcon.frame.origin.x;
    rect.size.width = rect.size.height / 11.0 * 9;
    UIImageView *imageDis = [[UIImageView alloc]initWithFrame:rect];
    [self addSubview:imageDis];
    imageDis.image = [UIImage imageNamed:@"Positioning"];
    
    rect = MY_RECT(4, 45, 160, 11);
    rect.origin.x = rect.origin.x + CGRectGetWidth(imageDis.frame) + imageDis.frame.origin.x;
    _labAddress = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labAddress];
    _labAddress.textColor = [UIColor colorWithRed:97/255.0 green:97/255.0 blue:97/255.0 alpha:1.0];
    _labAddress.text = @"343m";
    _labAddress.textAlignment = NSTextAlignmentLeft;
    _labAddress.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:10];
    
    rect = MY_RECT(10, 63, 10, 12);
    rect.origin.x = rect.origin.x + CGRectGetWidth(_imageIcon.frame) + _imageIcon.frame.origin.x;
    rect.size.width = rect.size.height / 39.0 * 32;
    UIImageView *imageTime = [[UIImageView alloc]initWithFrame:rect];
    [self addSubview:imageTime];
    imageTime.image = [UIImage imageNamed:@"Business hours"];
    
    rect = MY_RECT(4, 63, 160, 11);
    //  rect.size.width = CGRectGetWidth(_labAddress.frame);
    rect.origin.x = rect.origin.x + CGRectGetWidth(imageTime.frame) + imageTime.frame.origin.x;
    _labBusinesshours = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labBusinesshours];
    _labBusinesshours.textColor = [UIColor colorWithRed:97/255.0 green:97/255.0 blue:97/255.0 alpha:1.0];
    _labBusinesshours.text = @"343m";
    _labBusinesshours.textAlignment = NSTextAlignmentLeft;
    _labBusinesshours.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:10];
    
    
    
    
    rect = MY_RECT(0, 94.5, 355, 48);
    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewBackgr];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,rect.size.width,rect.size.height);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:0x93/255.0 green:0xc1/255.0 blue:0x5f/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0x63/255.0 green:0xb1/255.0 blue:0x5e/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    [viewBackgr.layer addSublayer:gl];
    //       viewBackgr.shadowOpacity(0.7).shadowColor((UIColor *)[UIColor colorWithRed:99/255.0 green:177/255.0 blue:94/255.0 alpha:1.0]).shadowRadius(6).shadowOffset(CGSizeMake(5, 5)).conrnerRadius(rect.size.height / 2.0).conrnerCorner(UIRectCornerAllCorners).showVisual();
    //    viewBackgr.backgroundColor = [UIColor colorWithRed:0xf4 / 255.0 green:53 / 255.0 blue:44 / 255.0 alpha:1];
    
    
    
    rect = MY_RECT(12, 0, 114 - 14, 48);
    _labAvailable = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:_labAvailable];
    _labAvailable.textColor = [UIColor whiteColor];
    _labAvailable.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:12];
    _labAvailable.textAlignment = NSTextAlignmentLeft;
    _labAvailable.text = @"asd";
    
    
    rect = MY_RECT(114 + 12, 0, 114 - 14, 48);
    _labCanreturn = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:_labCanreturn];
    _labCanreturn.textColor = [UIColor whiteColor];
    _labCanreturn.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:12];
    _labCanreturn.textAlignment = NSTextAlignmentLeft;
    _labCanreturn.text = @"asd";
    
    rect = MY_RECT(114 * 2 + 12, 0, 114 - 14, 48);
    _labDistance = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:_labDistance];
    _labDistance.textColor = [UIColor whiteColor];
    _labDistance.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:12];
    _labDistance.textAlignment = NSTextAlignmentLeft;
    _labDistance.text = @"asd";
    
    rect = MY_RECT(0, 0, IPHONE6SWIDTH, 95);
    _buttonDef = [[UIButton alloc]initWithFrame:rect];
    [self addSubview:_buttonDef];
    
    
    rect = MY_RECT(291, 19, 56, 56);
    rect.size.width = rect.size.height;
    _buttonNavigation = [[UIButton alloc]initWithFrame:rect];
    [self addSubview:_buttonNavigation];
    [_buttonNavigation setImage:[UIImage imageNamed:@"map_navigation"] forState:UIControlStateNormal];
    
    
    for (int i = 1; i < 3; i ++) {
        rect = MY_RECT(114 * i, 10, 0.8, 28);
        UIView *viewLine = [[UIView alloc]initWithFrame:rect];
        [viewBackgr addSubview:viewLine];
        viewLine.backgroundColor = [UIColor whiteColor];
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
