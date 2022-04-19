//
//  ActivityView.m
//  Cloris
//
//  Created by Mr.fang on 2018/3/21.
//  Copyright © 2018年 Mr.fang. All rights reserved.
//

#import "ActivityView.h"
#import "UIImage+GIF.h"
@implementation ActivityView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initUI];
        [self startAnimation];
    }
    return self;
}

- (void)initUI
{
    //ipad适配
//    CGRect rect = MY_RECT(0, 0, 60, 60);
//    rect.size.width = rect.size.height;
//    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
//    [self addSubview:viewBackgr];
//    viewBackgr.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//    viewBackgr.center = CGPointMake(WIDTH  / 2.0, HEIGHT / 2.0);
    
     CGRect rect = MY_RECT(0, 0, 30, 30);
    rect.size.width = rect.size.height;
    imageView = [[UIImageView alloc]initWithFrame:rect];
    imageView.center = CGPointMake(WIDTH  / 2.0, HEIGHT / 2.0);
    [self addSubview:imageView];
    
  
    
}

- (void)createLabtitle:(NSString *)str
{
    CGRect rect = MY_RECT(10, 0, IPHONE6SWIDTH - 20, 20);
    rect.origin.y = imageView.frame.origin.y + imageView.frame.size.height + 10;
    _labTitle = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labTitle];
    _labTitle.textColor = [UIColor whiteColor];
    _labTitle.textAlignment = NSTextAlignmentCenter;
    _labTitle.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:14]; 
    _labTitle.text = str;
}

- (void)startAnimation
{
    imageView.image = [UIImage sd_animatedGIFNamed:@"loding"];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [gAppDelegate removeActivityView];
//}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

