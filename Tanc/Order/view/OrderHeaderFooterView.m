//
//  OrderHeaderFooterView.m
//  Tanc
//
//  Created by f on 2019/12/16.
//  Copyright © 2019 f. All rights reserved.
//

#import "OrderHeaderFooterView.h"

@implementation OrderHeaderFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUi];
        
    }
    return self;
}

- (void)initUi
{
    CGRect rect = MY_RECT(0, 20, 14, 10.5);
    rect.size.width = rect.size.height / 10.5 * 14;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    [self addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"orderStatusImage"];
    
    rect = MY_RECT(29, 18, 200, 13);
    UILabel *lab =[[UILabel alloc]initWithFrame:rect];
    [self addSubview:lab];
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = [GlobalObject getCurLanguage:@"Order Status"];
    lab.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:15];
    
    rect = MY_RECT(306 - 100, 18, 55 + 100, 13);
    _labState =[[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labState];
    _labState.textAlignment =NSTextAlignmentRight;
    _labState.font = lab.font;
    _labState.text = @"On loan";
    
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
