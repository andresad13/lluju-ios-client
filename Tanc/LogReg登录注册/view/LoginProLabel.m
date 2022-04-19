//
//  LoginProLabel.m
//  Tanc
//
//  Created by f on 2019/12/5.
//  Copyright © 2019 f. All rights reserved.
//

#import "LoginProLabel.h"

@implementation LoginProLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(UILabel *)labFir
{
    if (!_labFir) {
        
        _labFir = [[UILabel alloc]init];
        [self addSubview:_labFir];
        _labFir.textColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
        _labFir.textAlignment = NSTextAlignmentLeft;
    }
    return _labFir;
}

-(UILabel *)labSec
{
    if (!_labSec) {
        
        _labSec = [[UILabel alloc]init];
        [self addSubview:_labSec];
        _labSec.textColor = [UIColor colorWithRed:244/255.0 green:83/255.0 blue:68/255.0 alpha:1.0];
        _labSec.textAlignment = NSTextAlignmentLeft;
    }
    return _labSec;
}

  
- (void)setLabText:(NSString *)str strSec:(NSString *)strSec font:(UIFont *)font
{
    CGFloat flox = [GlobalObject widthOfString:str font:font];
    CGFloat floHei = [GlobalObject getStringHeightWithText:str font:font viewWidth:flox];
    CGRect rect = CGRectMake(0, 0, flox, CGRectGetHeight(self.frame));
    self.labFir.frame = rect;
    self.labFir.text = str;
    self.labFir.font = font;
    
    if (flox > 0) {
        rect.size.height = floHei;
        rect.origin.y = (CGRectGetHeight(self.frame) - rect.size.height) / 2.0;
        self.labFir.frame = rect;
        
        flox = flox + 3;
    }
    
    CGFloat floWid = [GlobalObject widthOfString:strSec font:font];
    rect = CGRectMake(flox, 0,floWid, CGRectGetHeight(self.frame));
    self.labSec.frame = rect;
    self.labSec.text = strSec;
    self.labSec.font = font;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
