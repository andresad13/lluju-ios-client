//
//  AreaCodeHeadView.m
//  SpeedTime
//
//  Created by f on 2019/9/10.
//  Copyright © 2019 f. All rights reserved.
//

#import "AreaCodeHeadView.h"

@implementation AreaCodeHeadView

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
    
    CGRect rect = MY_RECT(15, 0, 100, 26);
    _labTitle = [[UILabel alloc]initWithFrame:rect];
    [self addSubview:_labTitle];
 //   _labTitle.text = @"A";
    _labTitle.font = [GlobalObject getAvenirFontEnumType:Avenir_Light fontSize:15];
    _labTitle.textAlignment = NSTextAlignmentLeft;
    _labTitle.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor colorWithWhite: 0 alpha:0];
        view.backgroundColor = [UIColor colorWithRed:0xfa / 255.0 green:0xfa / 255.0 blue:0xfa / 255.0 alpha:1];

        view;
    });
    //self.backgroundColor = [UIColor colorWithRed:0xf1 / 255.0 green:0xf1 / 255.0 blue:0xf1 / 255.0 alpha:1];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
