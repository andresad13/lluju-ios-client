//
//  USerProWindow.m
//  ChargingTreasure
//
//  Created by f on 2019/7/5.
//  Copyright © 2019 Mr.fang. All rights reserved.
//

#import "USerProWindow.h"

@implementation USerProWindow

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
       // [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    CGRect rect = MY_RECT(0, 0, 0, 0);
    UIView *viewBackgr = [[UIView alloc]initWithFrame:rect];
    [self addSubview:viewBackgr];
    viewBackgr.backgroundColor =[UIColor whiteColor];
    viewBackgr.layer.cornerRadius = 6;
    viewBackgr.clipsToBounds = YES;
    
    CGFloat floHei = 0;
    
    rect = MY_RECT(157, 27, 43.5, 47.5);
    rect.size.width = rect.size.height /  47.5  * 43.5;
    rect.origin.x = (rect.origin.x - rect.size.width) / 2.0;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    [viewBackgr addSubview:imageView];
    imageView.image =  !_bSucce ? [UIImage imageNamed:@"error_Pro"] : [UIImage imageNamed:@"succe_pro"];
    //imageView.center = CGPointMake(viewBackgr.frame.size.width / 2.0, imageView.center.y);

    floHei  = rect.size.height + rect.origin.y + 15 / IPHONE6SHEIGHT * HEIGHT;
    
   CGFloat floTextHei = [GlobalObject getStringHeightWithText:_strPro font:[GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:14] viewWidth:(157 - 20) / IPHONE6SWIDTH * WIDTH];
    
    rect = MY_RECT(10, 0, 157 - 20, 0);
    rect.origin.y = floHei;
    rect.size.height = floTextHei;
    rect.size.width = (157 - 20) / IPHONE6SWIDTH * WIDTH;
    UILabel *labPro = [[UILabel alloc]initWithFrame:rect];
    [viewBackgr addSubview:labPro];
    labPro.text = _strPro;
    labPro.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:11];
    labPro.textAlignment = NSTextAlignmentCenter;
   // labPro.backgroundColor = [UIColor redColor];
    labPro.textColor = [UIColor blackColor];
    labPro.numberOfLines = 0;
    
    
    floHei  = rect.size.height + floHei + 19 / IPHONE6SHEIGHT * HEIGHT;
    
    rect = viewBackgr.frame;
    rect.size.height = floHei;
    rect.size.width = 157 / IPHONE6SWIDTH * WIDTH;
     viewBackgr.center = CGPointMake(WIDTH / 2.0, HEIGHT / 2.0);
    
    viewBackgr.frame = rect;
    viewBackgr.center = CGPointMake(WIDTH / 2.0, HEIGHT / 2.0);
    
   viewBackgr.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:0.35 animations:^{
     viewBackgr.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
    
     timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];;// [NSTimer scheduledTimerWithTimeInterval:1.5 invocation:@selector(timerAction) repeats:NO]; //[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerAction) userInfo:alter repeats:NO];
}

- (void)timerAction
{
    [timer invalidate];
    timer = nil;
    [self removeFromSuperview];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [timer invalidate];
    timer = nil;
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
