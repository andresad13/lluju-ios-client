//
//  TransacHeaderView.m
//  Tanc
//
//  Created by f on 2019/12/11.
//  Copyright © 2019 f. All rights reserved.
//

#import "TransacHeaderView.h"

@implementation TransacHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = ({
            UIView * view = [[UIView alloc] initWithFrame:self.bounds];
            view.backgroundColor = [UIColor colorWithWhite: 0 alpha:0];
            view;
        });
    }
    return self;
}

- (UILabel *)labTiti
{
    if (!_labTiti) {
        CGRect rect = MY_RECT(12, 0, 150, 11);
        _labTiti = [[UILabel alloc]initWithFrame:rect];
        [self addSubview:_labTiti];
        _labTiti.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1.0];
        _labTiti.textAlignment = NSTextAlignmentLeft;
        _labTiti.font = [GlobalObject getAvenirFontEnumType:Avenir_Roman fontSize:13];
        _labTiti.text = @"就是告诉大家会发光";
    }
    return _labTiti;
}

- (void)setLabTitiText:(NSString *)str
{
     self.labTiti.text = str;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
